use alloc::vec::Vec;

/// What a draw assembles its vertices into
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum DrawPrimitive {
    Points,
    Lines,
    LineStrip,
    Triangles,
    TriangleStrip,
}

/// Which faces a draw culls
#[derive(Clone, Copy, Debug, PartialEq, Eq, Default)]
pub enum CullMode {
    #[default]
    None,
    Front,
    Back,
}

/// A vertex attribute's format in its buffer
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum VertexFormat {
    Float32,
    Float32x2,
    Float32x3,
    Float32x4,
}

impl VertexFormat {
    pub const fn components(self) -> u32 {
        match self {
            VertexFormat::Float32 => 1,
            VertexFormat::Float32x2 => 2,
            VertexFormat::Float32x3 => 3,
            VertexFormat::Float32x4 => 4,
        }
    }
}

impl TryFrom<u32> for VertexFormat {
    type Error = mlirformat::Error;

    /// A vertex attribute of `n` 32-bit floats
    fn try_from(n: u32) -> Result<VertexFormat, mlirformat::Error> {
        match n {
            1 => Ok(VertexFormat::Float32),
            2 => Ok(VertexFormat::Float32x2),
            3 => Ok(VertexFormat::Float32x3),
            4 => Ok(VertexFormat::Float32x4),
            n => Err(mlirformat::Error(alloc::format!("a vertex attribute of {n} floats"))),
        }
    }
}

/// A color target's texel format
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ColorFormat {
    Rgba32Float,
    Rgba8Unorm,
}

impl ColorFormat {
    pub const fn bytes(self) -> u32 {
        match self {
            ColorFormat::Rgba32Float => 16,
            ColorFormat::Rgba8Unorm => 4,
        }
    }
}

/// A vertex shader input, in location order: which vertex buffer, its format, where in a vertex
#[derive(Clone, Copy, Debug)]
pub struct VertexElement {
    pub buffer: u32,
    pub format: VertexFormat,
    pub offset: u32,
}

#[derive(Clone, Copy, Debug)]
pub struct VertexBuffer<'d> {
    pub bytes: &'d [u8],
    pub stride: u32,
}

/// A linear color target and its pixels before the draw (row 0 is the bottom row of the viewport's y axis)
#[derive(Clone, Copy, Debug)]
pub struct ColorTarget<'d> {
    pub width: u32,
    pub height: u32,
    pub format: ColorFormat,
    pub pixels: &'d [u8],
}

impl ColorTarget<'_> {
    pub const fn pitch(&self) -> u32 {
        self.width * self.format.bytes()
    }
}

/// One draw, described without the GPU: a target's constructor (detour's `Xe3Draw`, say) lowers it, with the program's kernels,
/// into the image the GPU runs
#[derive(Clone, Debug)]
pub struct Draw<'d> {
    pub buffers: Vec<VertexBuffer<'d>>,
    pub elements: Vec<VertexElement>,
    /// uniform blocks, by binding
    pub uniforms: Vec<(u32, &'d [u8])>,
    pub primitive: DrawPrimitive,
    pub first: u32,
    pub count: u32,
    pub instances: u32,
    /// x, y, width, height in pixels
    pub viewport: [f32; 4],
    pub depth_range: [f32; 2],
    /// x, y, width, height; None: the whole target
    pub scissor: Option<[u32; 4]>,
    pub cull: CullMode,
    pub front_ccw: bool,
    pub target: ColorTarget<'d>,
}
