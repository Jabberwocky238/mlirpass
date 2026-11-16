use alloc::borrow::ToOwned;
use alloc::format;
use alloc::string::String;
use alloc::vec;
use alloc::vec::Vec;

use mlirformat::{Attribute, Error, Op};

use crate::*;

/// One xe3 op with the fields given (the rest left to the genxml defaults)
macro_rules! xe3 {
    ($ty:ident { $($f:ident: $v:expr),* $(,)? }) => {
        $ty { $($f: Some($v.into()),)* ..Default::default() }
    };
}

/// Memory object control state: the index of the write-back, coherent entry
const MOCS: u32 = 1 << 1;
/// The binding table pool: surface states and binding tables, addressed from its base
const POOL: u32 = 0x10_0000;
/// The unit of the pool's size field
const POOL_PAGE: u32 = 4096;
/// The state base addresses' size fields: the whole 32-bit range
const STATE_SIZE: u32 = 0xf_ffff;
/// MI_LOAD_REGISTER_IMM targets and values Mesa's iris sets once per context on Xe2+
const CS_CHICKEN1: u32 = 0x20d8;
const CS_CHICKEN1_VALUE: u32 = 0x0010_0010;
const CACHE_MODE_SS: u32 = 0x6208;
const CACHE_MODE_SS_VALUE: u32 = 0x0020_0000;
/// The compute mode's variable register size allocation, its enable bit in the mask dword
const VRT_MASK: u32 = 1 << 10;
/// The drawing rectangle covers every pixel 16-bit coordinates reach
const DRAWING_MAX: u32 = 0xffff;
/// URB: the 64-byte units the VS's entries share, starting after the push constants (four stages of 8 KB)
const URB_SPACE: u32 = 5888;
const URB_START: u32 = 4;
const URB_ENTRY_GRANULE: u32 = 8;
const PUSH_STAGES: u32 = 4;
const PUSH_KB: u32 = 8;
const PUSH_ALLOC_SUB_OPCODE: u32 = 18;
/// Threads: the VS's, and the PS's per pixel shader dispatcher
const VS_THREADS: u32 = 545;
const PS_THREADS: u32 = 127;
/// GRF blocks of 32 registers a thread takes (3: 128 registers)
const REGISTERS_PER_THREAD: u32 = 3;
/// The clip's and the SF's provoking vertices: GL's and Vulkan's last vertex
const TRIANGLE_PROVOKING: u32 = 2;
const LINE_PROVOKING: u32 = 1;
const POINT_WIDTH_MAX: f32 = 255.875;
const POINT_WIDTH_MIN: f32 = 0.125;
/// The clip test's guardband around the viewport (in NDC)
const GUARDBAND: f32 = 512.0;
/// Every SBE attribute's active components: all four
const COMPONENTS_XYZW: u32 = 3;
const SBE_ATTRIBUTES: usize = 32;
const SBE_SWIZZLES: u32 = 16;
const POINT_WIDTH_FROM_STATE: u32 = 1;
const AA_LINE_DISTANCE_TRUE: u32 = 1;
const POINT_RASTERIZATION_UPPER_RIGHT: u32 = 1;
const LINE_AA_REGION_1_PIXEL: u32 = 1;
const POINT_SPRITE_ORIGIN_LOWER_LEFT: u32 = 1;
/// The WM's barycentric mode: perspective pixel
const BARYCENTRIC_PERSPECTIVE_PIXEL: u32 = 1;
/// Surface state: no swizzle (SCS_RED, SCS_GREEN, SCS_BLUE, SCS_ALPHA)
const SCS: [u32; 4] = [4, 5, 6, 7];
const HALIGN_128B: u32 = 3;
const VALIGN_4: u32 = 1;
const MIP_TAIL_NONE: u32 = 15;
/// The PS's SIMD width field: SIMD16
const PS_SIMD16: u32 = 0;
/// The color calculator's alpha test format and the blend state's alpha test function GL leaves alone
const ALPHA_TEST_FLOAT: u32 = 1;
const ALPHA_TEST_NEVER_USED: u32 = 1;
/// Everything the 3DSTATE_CONSTANT_ALL updates: VS, HS, DS, GS, PS
const CONSTANT_ALL_STAGES: u32 = 0x1f;
/// The VF's batch sizes, as Mesa sets them on Xe2+
const VFG_LIST_1: u32 = 2;
const VFG_LIST_2: u32 = 1;
const VFG_LIST_3: u32 = 2;
const VFG_STRIP: u32 = 3;
const VFG_PATCH: u32 = 1;
const VFG_PATCH_MULTIPLIER: u32 = 31;
/// Placement: surface states and the first binding table entry on 64 bytes, the following entries on 4,
/// viewports on 32 and 64, the fence on a page
const SURFACE_ALIGN: u32 = 64;
const ENTRY_ALIGN: u32 = 4;
const CC_VIEWPORT_ALIGN: u32 = 32;
const STATE_ALIGN: u32 = 64;
const FENCE_ALIGN: u64 = 4096;
const FENCE_SIZE: u64 = 64;
/// A buffer surface's size, split over its width, height and depth fields
const BUFFER_WIDTH_BITS: u32 = 7;
const BUFFER_HEIGHT_BITS: u32 = 14;
const BUFFER_DEPTH_BITS: u32 = 11;

/// genxml's SURFACE_FORMAT values the draw uses
struct SurfaceFormat;

impl SurfaceFormat {
    const R32G32B32A32_FLOAT: u32 = 0x000;
    const R32G32B32_FLOAT: u32 = 0x040;
    const R32G32_FLOAT: u32 = 0x085;
    const R32_FLOAT: u32 = 0x0d8;
    const R32_UINT: u32 = 0x0d7;
    const R8G8B8A8_UNORM: u32 = 0x0c7;
    const RAW: u32 = 0x1ff;

    const fn vertex(f: VertexFormat) -> u32 {
        match f {
            VertexFormat::Float32 => SurfaceFormat::R32_FLOAT,
            VertexFormat::Float32x2 => SurfaceFormat::R32G32_FLOAT,
            VertexFormat::Float32x3 => SurfaceFormat::R32G32B32_FLOAT,
            VertexFormat::Float32x4 => SurfaceFormat::R32G32B32A32_FLOAT,
        }
    }

    const fn color(f: ColorFormat) -> u32 {
        match f {
            ColorFormat::Rgba32Float => SurfaceFormat::R32G32B32A32_FLOAT,
            ColorFormat::Rgba8Unorm => SurfaceFormat::R8G8B8A8_UNORM,
        }
    }
}

impl From<DrawPrimitive> for Fill {
    fn from(p: DrawPrimitive) -> Fill {
        Fill::from(match p {
            DrawPrimitive::Points => XE3__3DPRIM_POINTLIST,
            DrawPrimitive::Lines => XE3__3DPRIM_LINELIST,
            DrawPrimitive::LineStrip => XE3__3DPRIM_LINESTRIP,
            DrawPrimitive::Triangles => XE3__3DPRIM_TRILIST,
            DrawPrimitive::TriangleStrip => XE3__3DPRIM_TRISTRIP,
        })
    }
}

impl From<CullMode> for Fill {
    fn from(c: CullMode) -> Fill {
        Fill::from(match c {
            CullMode::None => XE3_CULLMODE_NONE,
            CullMode::Front => XE3_CULLMODE_FRONT,
            CullMode::Back => XE3_CULLMODE_BACK,
        })
    }
}

/// A draw on Xe3: the program's kernels (in the module, as the shader pipeline leaves them), the state, the commands
/// and the memories, as one image
pub struct Xe3Draw<'b, 'a> {
    body: &'b mut Body<'a>,
    code: BlockId,
    surfaces: BlockId,
    batch: BlockId,
}

impl<'a> Xe3Draw<'_, 'a> {
    /// SPIR-V vertex and fragment shaders (spirv.module ops at the top of the module) to Xe3 kernels
    pub const SHADERS: &'static str = "builtin.module(xevm-attach-target{chip=ptl}, convert-spirv-entry-points, gpu-inline-calls, canonicalize, cse, convert-gpu-to-xe3, xe3-regalloc, xe3-control, xe3-swsb, xe3-branches, xe3-pad)";
    /// The memory holding the color target after the draw
    pub const TARGET: &'static str = "target";
    const CODE: &'static str = "code";
    const SURFACES: &'static str = "surfaces";
    const BATCH: &'static str = "batch";
    const FENCE: &'static str = "fence";
    const NULL: &'static str = "null_surface";
    const BT_NULL: &'static str = "bt_null";
    const BT: &'static str = "bt";
    const RT: &'static str = "rt_surface";
    const VS: &'static str = "vs";
    const FS: &'static str = "fs";
    const CC_VIEWPORT: &'static str = "cc_viewport";
    const SF_CLIP_VIEWPORT: &'static str = "sf_clip_viewport";
    const SCISSOR: &'static str = "scissor";
    const COLOR_CALC: &'static str = "color_calc";
    const BLEND: &'static str = "blend";
    const SHADER_MODULE: &'static str = "shaders";

    /// The module's top-level spirv.module ops moved into a gpu.module (what convert-spirv-entry-points takes),
    /// then `SHADERS` run on it
    pub fn compile(body: &mut Body<'a>, passes: &Passes) -> Result<(), Error> {
        let root = body.root;
        let top = body.top_block(root);
        let modules: Vec<OpId> = body.ops(top).filter(|&m| &*body[m].name == "spirv.module").collect();
        body[root].attributes.push(mlirformat::NamedAttr { name: "gpu.container_module".into(), value: None });
        let shaders = body.create(OpData::build("gpu.module").with("sym_name", Attribute::str(Xe3Draw::SHADER_MODULE)), &[]);
        let region = body.add_region(shaders);
        let block = body.add_block(region, &[]);
        body.insert(shaders, top, None);
        for m in modules {
            body.detach(m);
            body.insert(m, block, None);
        }
        PassManager::parse(passes, Xe3Draw::SHADERS)?.run(body, root)
    }

    /// The draw's image, built in `body` (a module `compile` left one vertex and one fragment kernel in)
    pub fn image(body: &'_ mut Body<'a>, d: &Draw<'_>) -> Result<Image, Error> {
        let root = body.root;
        let kernels = Kernels::all(body, root, Xe3Kernel::NAME);
        let code = Xe3Draw::memory(body, &ImageMemory::named(Xe3Draw::CODE, MemType::Streaming))?;
        let batch_memory = Xe3Draw::memory(body, &ImageMemory::named(Xe3Draw::BATCH, MemType::Streaming))?;
        let batch = Xe3Draw::container(body, batch_memory, OpData::head(&ImageStream::named(Xe3Draw::BATCH))?);
        let pool = ImageMemory { size: Some(u64::from(POOL)), align: Some(u64::from(POOL)), ..ImageMemory::named(Xe3Draw::SURFACES, MemType::Streaming) };
        let surfaces = Xe3Draw::memory(body, &pool)?;
        let (mut vs, mut fs) = (None, None);
        for k in kernels {
            let h = body.head::<Xe3Kernel>(k)?;
            let name = match h.stage {
                Some(ShaderStage::Vertex) if vs.is_none() => Xe3Draw::VS,
                Some(ShaderStage::Fragment) if fs.is_none() => Xe3Draw::FS,
                s => return Err(Error(format!("a draw runs one vertex and one fragment kernel, not {s:?}"))),
            };
            *if name == Xe3Draw::VS { &mut vs } else { &mut fs } = Some(h);
            body[k].set(Symbol::ATTR, Attribute::str(name));
            body.detach(k);
            body.insert(k, code, None);
        }
        let shader_modules: Vec<OpId> = body.ops(body.top_block(root)).filter(|&o| &*body[o].name == "gpu.module").collect();
        for s in shader_modules {
            body.detach(s);
        }
        let (Some(vs), Some(fs)) = (vs, fs) else { return Err(Error("a draw needs a vertex and a fragment kernel".into())) };
        let mut me = Xe3Draw { body, code, surfaces, batch };
        me.put(code, &ImageData { align: Some(FENCE_ALIGN), ..ImageData::zeros(Xe3Draw::FENCE, FENCE_SIZE) });
        me.null_surface();
        let target = Xe3Draw::memory(me.body, &ImageMemory::named(Xe3Draw::TARGET, MemType::Coherent))?;
        me.words(target, &format!("{}_data", Xe3Draw::TARGET), d.target.pixels);
        for (i, b) in d.buffers.iter().enumerate() {
            let m = Xe3Draw::memory(me.body, &ImageMemory::named(format!("vb{i}"), MemType::Streaming))?;
            me.words(m, &format!("vb{i}_data"), b.bytes);
        }
        for &(binding, bytes) in &d.uniforms {
            let m = Xe3Draw::memory(me.body, &ImageMemory::named(format!("ubo{binding}"), MemType::Streaming))?;
            me.words(m, &format!("ubo{binding}_data"), bytes);
        }
        me.context();
        me.draw(d, &vs, &fs)?;
        me.pc_flush();
        Xe3Image::end(body, root);
        ImageLayout(&Xe3Image).run(body, root)?;
        XE3_IMAGE.emit(body, root)
    }

    fn container(body: &mut Body<'a>, block: BlockId, data: OpData<'a>) -> BlockId {
        let op = body.create(data, &[]);
        let r = body.add_region(op);
        let inner = body.add_block(r, &[]);
        body.insert(op, block, None);
        inner
    }

    fn memory(body: &mut Body<'a>, m: &ImageMemory<'_>) -> Result<BlockId, Error> {
        let top = body.top_block(body.root);
        Ok(Xe3Draw::container(body, top, OpData::head(m)?))
    }

    fn put(&mut self, block: BlockId, op: &impl TypedOp) -> OpId {
        let (data, _) = op.split();
        let o = self.body.create(data, &[]);
        self.body.insert(o, block, None);
        o
    }

    fn cmd(&mut self, op: &impl TypedOp) {
        self.put(self.batch, op);
    }

    /// A state placed under `name`, aligned to `align` bytes, in the pool (`surfaces`) or with the code
    fn state(&mut self, surfaces: bool, name: &str, align: u32, op: &impl TypedOp) {
        let o = self.put(if surfaces { self.surfaces } else { self.code }, op);
        self.body[o].set(Symbol::ATTR, Attribute::str(name));
        self.body[o].set(ImagePlaced::ALIGN, A::from(align).into());
    }

    fn words(&mut self, block: BlockId, name: &str, bytes: &[u8]) {
        let values = bytes.chunks(4).map(|c| {
            let mut w = [0u8; 4];
            w[..c.len()].copy_from_slice(c);
            A::from(u32::from_le_bytes(w)).into()
        });
        self.put(block, &ImageWords::new(A::str(name).into(), values.collect(), None, None));
    }

    fn pc_flush(&mut self) {
        self.cmd(&xe3!(CmdPipeControl { depth_cache_flush_enable: true, render_target_cache_flush_enable: true, hdc_pipeline_flush_enable: true, command_streamer_stall_enable: true }));
    }

    /// The context Mesa's iris sets up on Xe2+: base addresses 0 (every pointer an address), the fence, the modes
    fn context(&mut self) {
        self.pc_flush();
        self.cmd(&xe3!(CmdStateBaseAddress {
            general_state_base_address_modify_enable: true,
            general_state_mocs: MOCS,
            general_state_buffer_size_modify_enable: true,
            general_state_buffer_size: STATE_SIZE,
            stateless_data_port_access_mocs: MOCS,
            l1_cache_control: XE3_L1CC_WB,
            surface_state_base_address_modify_enable: true,
            surface_state_mocs: MOCS,
            dynamic_state_base_address_modify_enable: true,
            dynamic_state_mocs: MOCS,
            dynamic_state_buffer_size_modify_enable: true,
            dynamic_state_buffer_size: STATE_SIZE,
            indirect_object_base_address_modify_enable: true,
            indirect_object_mocs: MOCS,
            indirect_object_buffer_size_modify_enable: true,
            indirect_object_buffer_size: STATE_SIZE,
            instruction_base_address_modify_enable: true,
            instruction_mocs: MOCS,
            instruction_buffer_size_modify_enable: true,
            instruction_buffer_size: STATE_SIZE,
            bindless_surface_state_mocs: MOCS,
            bindless_sampler_state_mocs: MOCS,
        }));
        self.cmd(&xe3!(CmdPipeControl {
            state_cache_invalidation_enable: true,
            constant_cache_invalidation_enable: true,
            texture_cache_invalidation_enable: true,
            instruction_cache_invalidate_enable: true,
            command_streamer_stall_enable: true,
        }));
        self.cmd(&xe3!(CmdStateSystemMemFenceAddress { system_memory_fence_address: A::sym(Xe3Draw::FENCE) }));
        self.cmd(&xe3!(CmdMiLoadRegisterImm { register_offset: CS_CHICKEN1, data_dword: CS_CHICKEN1_VALUE }));
        self.cmd(&xe3!(CmdMiLoadRegisterImm { register_offset: CACHE_MODE_SS, data_dword: CACHE_MODE_SS_VALUE }));
        self.cmd(&xe3!(Cmd3dstate3dMode { dx10_ogl_border_mode_for_ycrcb: true, dx10_ogl_border_mode_for_ycrcb_mask: true }));
        self.cmd(&xe3!(CmdStateComputeMode { enable_variable_register_size_allocation: true, mask1: VRT_MASK, enable_variable_register_size_allocation_mask: 1u32 }));
        self.cmd(&xe3!(Cmd3dstateDrawingRectangleFast { clipped_drawing_rectangle_x_max: DRAWING_MAX, clipped_drawing_rectangle_y_max: DRAWING_MAX }));
        self.cmd(&xe3!(Cmd3dstateSamplePattern { _1x_sample0_x_offset: 0.5f32, _1x_sample0_y_offset: 0.5f32 }));
        self.cmd(&Cmd3dstateAaLineParameters::default());
        self.cmd(&Cmd3dstateWmChromakey::default());
        self.cmd(&Cmd3dstateWmHzOp::default());
        self.cmd(&Cmd3dstatePolyStippleOffset::default());
        self.cmd(&Cmd3dstateMeshControl::default());
        self.cmd(&Cmd3dstateTaskControl::default());
        for stage in 0..PUSH_STAGES {
            self.cmd(&xe3!(Cmd3dstatePushConstantAllocDs { _3d_command_sub_opcode: PUSH_ALLOC_SUB_OPCODE + stage, constant_buffer_offset: stage * PUSH_KB, constant_buffer_size: PUSH_KB }));
        }
        self.pc_flush();
    }

    fn surface(&mut self, name: &str, base: A, t: &ColorTarget<'_>) {
        self.state(true, name, SURFACE_ALIGN, &xe3!(StateRenderSurfaceState {
            surface_type: XE3_SURFTYPE_2D,
            surface_format: SurfaceFormat::color(t.format),
            surface_horizontal_alignment: HALIGN_128B,
            surface_vertical_alignment: VALIGN_4,
            width: t.width - 1,
            height: t.height - 1,
            surface_pitch: t.pitch() - 1,
            mip_tail_start_lod: MIP_TAIL_NONE,
            mocs: MOCS,
            l1_cache_control: XE3_L1CC_WB,
            shader_channel_select_red: SCS[0],
            shader_channel_select_green: SCS[1],
            shader_channel_select_blue: SCS[2],
            shader_channel_select_alpha: SCS[3],
            surface_base_address: base,
        }));
    }

    /// A raw buffer surface of `size` bytes
    fn buffer_surface(&mut self, name: &str, base: A, size: u32) {
        let n = size.max(1).next_multiple_of(4) - 1;
        let bits = |shift: u32, width: u32| (n >> shift) & ((1 << width) - 1);
        self.state(true, name, SURFACE_ALIGN, &xe3!(StateRenderSurfaceState {
            surface_type: XE3_SURFTYPE_BUFFER,
            surface_format: SurfaceFormat::RAW,
            surface_horizontal_alignment: HALIGN_128B,
            surface_vertical_alignment: VALIGN_4,
            width: bits(0, BUFFER_WIDTH_BITS),
            height: bits(BUFFER_WIDTH_BITS, BUFFER_HEIGHT_BITS),
            depth: bits(BUFFER_WIDTH_BITS + BUFFER_HEIGHT_BITS, BUFFER_DEPTH_BITS),
            surface_pitch: 0u32,
            mocs: MOCS,
            l1_cache_control: XE3_L1CC_WB,
            surface_base_address: base,
        }));
    }

    fn null_surface(&mut self) {
        self.state(true, Xe3Draw::NULL, SURFACE_ALIGN, &xe3!(StateRenderSurfaceState { surface_type: XE3_SURFTYPE_NULL, surface_format: SurfaceFormat::R32_UINT, mocs: MOCS }));
        self.state(true, Xe3Draw::BT_NULL, SURFACE_ALIGN, &xe3!(StateBindingTableState { surface_state_pointer: A::sym(Xe3Draw::NULL) }));
    }

    /// The binding table: entry i points at surface `entries[i]` (the null surface where None)
    fn binding_table(&mut self, entries: &[Option<String>]) {
        for (i, e) in entries.iter().enumerate() {
            let s = xe3!(StateBindingTableState { surface_state_pointer: A::sym(e.as_deref().unwrap_or(Xe3Draw::NULL)) });
            if i == 0 {
                self.state(true, Xe3Draw::BT, SURFACE_ALIGN, &s);
            } else {
                let o = self.put(self.surfaces, &s);
                self.body[o].set(ImagePlaced::ALIGN, A::from(ENTRY_ALIGN).into());
            }
        }
    }

    fn viewport(&mut self, d: &Draw<'_>) {
        let [x, y, w, h] = d.viewport;
        let [near, far] = d.depth_range;
        let (tw, th) = (d.target.width as f32, d.target.height as f32);
        self.state(false, Xe3Draw::CC_VIEWPORT, CC_VIEWPORT_ALIGN, &xe3!(StateCcViewport { minimum_depth: near.min(far), maximum_depth: near.max(far) }));
        self.state(false, Xe3Draw::SF_CLIP_VIEWPORT, STATE_ALIGN, &xe3!(StateSfClipViewport {
            viewport_matrix_element_m00: w / 2.0,
            viewport_matrix_element_m11: h / 2.0,
            viewport_matrix_element_m22: far - near,
            viewport_matrix_element_m30: x + w / 2.0,
            viewport_matrix_element_m31: y + h / 2.0,
            viewport_matrix_element_m32: near,
            x_min_clip_guardband: -GUARDBAND,
            x_max_clip_guardband: GUARDBAND,
            y_min_clip_guardband: -GUARDBAND,
            y_max_clip_guardband: GUARDBAND,
            x_min_viewport: x.max(0.0),
            x_max_viewport: (x + w).min(tw) - 1.0,
            y_min_viewport: y.max(0.0),
            y_max_viewport: (y + h).min(th) - 1.0,
        }));
        let [sx, sy, sw, sh] = d.scissor.unwrap_or([0, 0, d.target.width, d.target.height]);
        let (x0, y0, x1, y1) = if sw == 0 || sh == 0 { (1, 1, 0, 0) } else { (sx, sy, sx + sw - 1, sy + sh - 1) };
        self.state(false, Xe3Draw::SCISSOR, STATE_ALIGN, &xe3!(StateScissorRect { scissor_rectangle_x_min: x0, scissor_rectangle_y_min: y0, scissor_rectangle_x_max: x1, scissor_rectangle_y_max: y1 }));
    }

    fn draw(&mut self, d: &Draw<'_>, vh: &Xe3Kernel<'_>, fh: &Xe3Kernel<'_>) -> Result<(), Error> {
        let inputs = vh.inputs.unwrap_or(0);
        let varyings = vh.varyings.unwrap_or(0);
        if inputs as usize != d.elements.len() {
            return Err(Error(format!("the vertex shader reads {inputs} inputs, the draw gives {}", d.elements.len())));
        }
        if fh.targets.unwrap_or(1) != 1 || fh.bindings.unwrap_or(0) != 0 {
            return Err(Error("a draw on Xe3: one color target and no textures, for now".into()));
        }
        self.viewport(d);
        self.state(false, Xe3Draw::COLOR_CALC, STATE_ALIGN, &xe3!(StateColorCalcState { alpha_test_format: ALPHA_TEST_FLOAT }));
        self.state(false, Xe3Draw::BLEND, STATE_ALIGN, &xe3!(StateBlendState { color_dither_enable: true, alpha_test_function: ALPHA_TEST_NEVER_USED }));
        let entry = self.put(self.code, &xe3!(StateBlendStateEntry {
            post_blend_color_clamp_enable: true,
            pre_blend_color_clamp_enable: true,
            color_clamp_range: XE3_COLORCLAMP_RTFORMAT,
            simple_float_blend_enable: true,
        }));
        self.body[entry].set(ImagePlaced::ALIGN, A::from(ENTRY_ALIGN).into());

        self.surface(Xe3Draw::RT, A::sym(Xe3Draw::TARGET), &d.target);
        let mut entries = vec![Some(Xe3Draw::RT.to_owned())];
        for &(binding, bytes) in &d.uniforms {
            let surface = format!("ubo{binding}_surface");
            self.buffer_surface(&surface, A::sym(format!("ubo{binding}")), bytes.len() as u32);
            let at = usize::from(XE3_BUFFER_BTI) + binding as usize;
            entries.resize(entries.len().max(at + 1), None);
            entries[at] = Some(surface);
        }
        let table = entries.len() as u32;
        self.binding_table(&entries);
        let bt = || A::within(Xe3Draw::SURFACES, Xe3Draw::BT);
        let null = || A::within(Xe3Draw::SURFACES, Xe3Draw::BT_NULL);
        let vs_buffers = vh.buffers.unwrap_or(0) > 0;

        self.cmd(&xe3!(Cmd3dstateViewportStatePointersCc { cc_viewport_pointer: A::sym(Xe3Draw::CC_VIEWPORT) }));
        self.cmd(&xe3!(Cmd3dstateViewportStatePointersSfClip { sf_clip_viewport_pointer: A::sym(Xe3Draw::SF_CLIP_VIEWPORT) }));
        self.cmd(&xe3!(Cmd3dstateScissorStatePointers { scissor_rect_pointer: A::sym(Xe3Draw::SCISSOR) }));
        let units = inputs.max(2 + varyings).div_ceil(4).max(1);
        let entries_urb = URB_SPACE / units / URB_ENTRY_GRANULE * URB_ENTRY_GRANULE;
        self.cmd(&xe3!(Cmd3dstateUrbAllocVs {
            vs_urb_entry_allocation_size: units - 1,
            vs_urb_starting_address_slice0: URB_START,
            vs_urb_starting_address_slice_n: URB_START,
            vs_number_of_urb_entries_slice0: entries_urb,
            vs_number_of_urb_entries_slice_n: entries_urb,
        }));
        self.cmd(&xe3!(Cmd3dstateUrbAllocHs { hs_urb_starting_address_slice0: URB_START, hs_urb_starting_address_slice_n: URB_START }));
        self.cmd(&xe3!(Cmd3dstateUrbAllocDs { ds_urb_starting_address_slice0: URB_START, ds_urb_starting_address_slice_n: URB_START }));
        self.cmd(&xe3!(Cmd3dstateUrbAllocGs { gs_urb_starting_address_slice0: URB_START, gs_urb_starting_address_slice_n: URB_START }));
        self.cmd(&xe3!(Cmd3dstateBlendStatePointers { blend_state_pointer_valid: true, blend_state_pointer: A::sym(Xe3Draw::BLEND) }));
        self.cmd(&xe3!(Cmd3dstateCcStatePointers { color_calc_state_pointer_valid: true, color_calc_state_pointer: A::sym(Xe3Draw::COLOR_CALC) }));
        self.cmd(&xe3!(Cmd3dstateConstantAll { shader_update_enable: CONSTANT_ALL_STAGES, mocs: MOCS }));
        self.cmd(&xe3!(Cmd3dstateBindingTablePoolAlloc { binding_table_pool_base_address: A::sym(Xe3Draw::SURFACES), binding_table_pool_buffer_size: POOL / POOL_PAGE, mocs: MOCS }));
        self.cmd(&xe3!(Cmd3dstateBindingTablePointersVs { pointer_to_vs_binding_table: if vs_buffers { bt() } else { null() } }));
        self.cmd(&xe3!(Cmd3dstateBindingTablePointersHs { pointer_to_hs_binding_table: null() }));
        self.cmd(&xe3!(Cmd3dstateBindingTablePointersDs { pointer_to_ds_binding_table: null() }));
        self.cmd(&xe3!(Cmd3dstateBindingTablePointersGs { pointer_to_gs_binding_table: null() }));
        self.cmd(&xe3!(Cmd3dstateBindingTablePointersPs { pointer_to_ps_binding_table: bt() }));
        self.cmd(&xe3!(CmdPipeControl { stall_at_pixel_scoreboard: true, render_target_cache_flush_enable: true }));
        self.cmd(&xe3!(Cmd3dstateMultisample { number_of_multisamples: 0u32 }));
        self.cmd(&xe3!(Cmd3dstateSampleMask { sample_mask: 1u32 }));
        self.cmd(&xe3!(Cmd3dstateVs {
            kernel_start_pointer: A::sym(Xe3Draw::VS),
            registers_per_thread: REGISTERS_PER_THREAD,
            vertex_urb_entry_read_length: inputs.div_ceil(2).max(1),
            binding_table_entry_count: if vs_buffers { table } else { 0 },
            dispatch_grf_start_register_for_urb_data: u32::from(XE3_VS_ATTR_GRF),
            enable: true,
            statistics_enable: true,
            maximum_number_of_threads: VS_THREADS,
        }));
        self.cmd(&Cmd3dstateHs::default());
        self.cmd(&Cmd3dstateTe::default());
        self.cmd(&Cmd3dstateDs::default());
        self.cmd(&Cmd3dstateGs::default());
        let imask = fh.imask.unwrap_or(false);
        let fragment_inputs = fh.inputs.unwrap_or(0);
        let setup = if fragment_inputs > 0 { Interpolate::setup(imask) } else { 1 + u8::from(imask) };
        self.cmd(&xe3!(Cmd3dstatePs {
            kernel_0_enable: true,
            kernel_0_simd_width: PS_SIMD16,
            kernel_start_pointer_0: A::sym(Xe3Draw::FS),
            registers_per_thread: REGISTERS_PER_THREAD,
            binding_table_entry_count: table,
            sampler_count: 0u32,
            maximum_number_of_threads_per_psd: PS_THREADS,
            dispatch_grf_start_register_for_constant_setup_data_0: u32::from(setup),
            kernel_0_poly_packing_policy: XE3_POLY_PACK16_FIXED,
            vector_mask_enable: false,
        }));
        self.cmd(&xe3!(Cmd3dstatePsExtra { pixel_shader_valid: true, omask_present_to_render_target: fh.omask.unwrap_or(false), input_coverage_mask_state: u32::from(imask) }));
        self.cmd(&Cmd3dstateStreamout::default());
        self.cmd(&xe3!(Cmd3dstateClip {
            api_mode: XE3_APIMODE_D3D,
            statistics_enable: true,
            force_user_clip_distance_clip_test_enable_bitmask: true,
            early_cull_enable: true,
            triangle_fan_provoking_vertex_select: TRIANGLE_PROVOKING,
            line_strip_list_provoking_vertex_select: LINE_PROVOKING,
            triangle_strip_list_provoking_vertex_select: TRIANGLE_PROVOKING,
            guardband_clip_test_enable: true,
            viewport_xy_clip_test_enable: true,
            clip_enable: true,
            force_zero_rta_index_enable: true,
            maximum_point_width: POINT_WIDTH_MAX,
            minimum_point_width: POINT_WIDTH_MIN,
        }));
        self.cmd(&xe3!(Cmd3dstateRaster {
            viewport_z_near_clip_test_enable: true,
            scissor_rectangle_enable: true,
            front_winding: u32::from(d.front_ccw),
            cull_mode: d.cull,
            viewport_z_far_clip_test_enable: true,
        }));
        self.cmd(&xe3!(Cmd3dstateSf {
            viewport_transform_enable: true,
            statistics_enable: true,
            line_width: 1.0f32,
            point_width: 1.0f32,
            point_width_source: POINT_WIDTH_FROM_STATE,
            aa_line_distance_mode: AA_LINE_DISTANCE_TRUE,
            triangle_fan_provoking_vertex_select: TRIANGLE_PROVOKING,
            line_strip_list_provoking_vertex_select: LINE_PROVOKING,
            triangle_strip_list_provoking_vertex_select: TRIANGLE_PROVOKING,
        }));
        let bary = if fragment_inputs == 0 { 0 } else { BARYCENTRIC_PERSPECTIVE_PIXEL };
        self.cmd(&xe3!(Cmd3dstateWm { point_rasterization_rule: POINT_RASTERIZATION_UPPER_RIGHT, line_antialiasing_region_width: LINE_AA_REGION_1_PIXEL, statistics_enable: true, barycentric_interpolation_mode: bary }));
        self.cmd(&xe3!(Cmd3dstateSbe {
            number_of_sf_output_attributes: varyings,
            vertex_urb_entry_read_offset: u32::from(varyings > 0),
            vertex_urb_entry_read_length: varyings.div_ceil(2).max(1),
            point_sprite_texture_coordinate_origin: POINT_SPRITE_ORIGIN_LOWER_LEFT,
            attribute_swizzle_enable: true,
            force_vertex_urb_entry_read_offset: true,
            force_vertex_urb_entry_read_length: true,
            attribute_active_component_format: vec![Fill::from(COMPONENTS_XYZW); SBE_ATTRIBUTES],
        }));
        let swiz: Vec<_> = (0..SBE_SWIZZLES).map(|i| Fields(StateSfOutputAttributeDetailFields { source_attribute: (i < varyings).then(|| i.into()), ..Default::default() })).collect();
        self.cmd(&xe3!(Cmd3dstateSbeSwiz { attribute: swiz }));
        self.cmd(&xe3!(Cmd3dstatePsBlend { has_writeable_rt: true }));
        self.cmd(&Cmd3dstateWmDepthStencil::default());
        self.cmd(&Cmd3dstateDepthBounds::default());
        self.cmd(&xe3!(Cmd3dstateDepthBuffer { surface_type: XE3_SURFTYPE_NULL, surface_format: XE3_D32_FLOAT, mocs: MOCS }));
        self.cmd(&xe3!(Cmd3dstateStencilBuffer { surface_type: XE3_SURFTYPE_NULL, mocs: MOCS }));
        self.cmd(&xe3!(Cmd3dstateHierDepthBuffer { mocs: MOCS }));
        self.cmd(&xe3!(CmdPipeControl { command_streamer_stall_enable: true }));

        self.cmd(&xe3!(Cmd3dstateVfTopology { primitive_topology_type: d.primitive }));
        let vbs: Vec<_> = d.buffers.iter().enumerate().map(|(i, b)| {
            let state = StateVertexBufferStateFields {
                vertex_buffer_index: Some((i as u32).into()),
                buffer_pitch: Some(b.stride.into()),
                address_modify_enable: Some(true.into()),
                mocs: Some(MOCS.into()),
                l3_bypass_disable: Some(true.into()),
                buffer_starting_address: Some(A::sym(format!("vb{i}")).into()),
                buffer_size: Some((b.bytes.len() as u32).into()),
                ..Default::default()
            };
            Fields(Cmd3dstateVertexBuffersElement { vertex_buffer_state: Some(Fields(state)) })
        }).collect();
        self.cmd(&xe3!(Cmd3dstateVertexBuffers { elements: vbs }));
        let elements: Vec<_> = d.elements.iter().map(|e| {
            let n = e.format.components();
            let control = |c: u32| Some(Fill::from(if c < n { XE3_VFCOMP_STORE_SRC } else if c < 3 { XE3_VFCOMP_STORE_0 } else { XE3_VFCOMP_STORE_1_FP }));
            let state = StateVertexElementStateFields {
                vertex_buffer_index: Some(e.buffer.into()),
                source_element_format: Some(SurfaceFormat::vertex(e.format).into()),
                source_element_offset: Some(e.offset.into()),
                valid: Some(true.into()),
                component_0_control: control(0),
                component_1_control: control(1),
                component_2_control: control(2),
                component_3_control: control(3),
                ..Default::default()
            };
            Fields(Cmd3dstateVertexElementsElement { element: Some(Fields(state)) })
        }).collect();
        self.cmd(&xe3!(Cmd3dstateVertexElements { elements: elements }));
        for i in 0..d.elements.len() as u32 {
            self.cmd(&xe3!(Cmd3dstateVfInstancing { vertex_element_index: i, instancing_enable: false, instance_data_step_rate: 0u32 }));
        }
        self.cmd(&Cmd3dstateVfSgvs::default());
        self.cmd(&Cmd3dstateVfSgvs2::default());
        self.cmd(&xe3!(Cmd3dstateVfStatistics { statistics_enable: true }));
        self.cmd(&xe3!(Cmd3dstateVf { geometry_distribution_enable: true }));
        self.cmd(&xe3!(Cmd3dstateVfg {
            list_1_batch_size_scale: VFG_LIST_1,
            list_2_batch_size_scale: VFG_LIST_2,
            list_3_batch_size_scale: VFG_LIST_3,
            strip_batch_size_scale: VFG_STRIP,
            patch_batch_size_scale: VFG_PATCH,
            patch_batch_size_multiplier: VFG_PATCH_MULTIPLIER,
        }));
        self.cmd(&Cmd3dstatePrimitiveReplication::default());
        self.cmd(&xe3!(Cmd3dprimitiveExtended {
            vertex_access_type: XE3_SEQUENTIAL,
            vertex_count_per_instance: d.count,
            instance_count: d.instances,
            start_vertex_location: d.first,
            base_vertex_location: 0u32,
        }));
        Ok(())
    }
}
