// Every AGX struct, each settable field a random value of its type (scripts/agx_pack_oracle.sh);
// oracle.expected is what Mesa's agx_pack packs from the same values.
agx.border {channel_0 = 0x424e617b, channel_1 = 0x4a6f188a, channel_2 = 0xaf6d114c, channel_3 = 0xe8d79f49}
agx.cdm_barrier {unk_0 = true, unk_1 = true, unk_2 = true, usc_cache_inval = true, unk_4 = true, unk_5 = true, unk_6 = true, unk_7 = true, unk_8 = false, unk_9 = true, unk_10 = false, unk_11 = true, unk_12 = true, unk_13 = false, unk_14 = true, unk_15 = true, unk_16 = false, unk_17 = false, unk_18 = false, unk_19 = true, unk_20 = false, unk_24 = false, unk_26 = true, returns = false}
agx.cdm_global_size {x = 0xe5f31bed, y = 0xc147eea8, z = 0x8cb950a5}
agx.cdm_indirect {address_hi = 0x90, address_lo = 0xfb3e7194}
agx.cdm_launch_word_0 {uniform_register_count = 0x1b7, texture_state_register_count = 0xba, sampler_state_register_count = 0x7, preshader_register_count = 0xdc, mode = 0x2}
agx.cdm_launch_word_1 {pipeline = 0x5052aa00}
agx.cdm_local_size {x = 0xa7be99ae, y = 0x1e0b4ee5, z = 0x58921843}
agx.cdm_stream_link {target_hi = 0xd1, with_return = false, target_lo = 0xb0e04e90}
agx.cdm_stream_return {}
agx.cdm_stream_terminate {}
agx.cdm_unk_g14x {}
agx.cf_binding {components = 0x2, shade_model = 0x4, source = 0x4, base_slot = 0xbf, base_coefficient_register = 0xfc}
agx.cf_binding_header {number_of_32_bit_slots = 0x22, number_of_coefficient_registers = 0x70}
agx.counts {unknown_0 = 0x1, uniform_register_count = 0x1c6, texture_state_register_count = 0x5a, sampler_state_register_count = 0x2, preshader_register_count = 0x67, cf_binding_count = 0x16, unknown = 0x85cf}
agx.cr_isp_zls_pixels {x = 0x2d9a, y = 0x206d}
agx.cr_ppp_control {opengl = false, enable_w_clamp = false, default_point_size = false, fixed_point_format = 0x1}
agx.cull {cull_front = false, cull_back = false, flat_shading_vertex = 0x3, depth_clip = true, depth_clamp = false, primitive_msaa = true, front_face_ccw = true, rasterizer_discard = true}
agx.cull_2 {clamp_w = false, draw_clipped_edges = true, needs_primitive_id = true, rasterizer_discard = false}
agx.depth_bias {depth_bias = -0.003475346602499485, slope_scale = -0.011326637119054794, clamp = -0.011776551604270935}
agx.depth_bias_scissor {scissor = 0xbc7b, depth_bias = 0xde45}
agx.fragment_control {visibility_mode = 0x1, scissor_enable = false, depth_bias_enable = true, stencil_test_enable = false, two_sided_stencil = true, tag_write_disable = true, sample_mask_after_depth_stencil = false, disable_tri_merging = true, pass_type = 0x6}
agx.fragment_face {stencil_reference = 0x9e, line_width = 0xa, polygon_mode = 0x2, disable_depth_write = true, unk___visibility_test_internal = 0x1, depth_function = 0x4}
agx.fragment_face_2 {disable_depth_write = false, conservative_depth = 0x0, depth_function = 0x2, object_type = 0x3}
agx.fragment_occlusion_query {index = 0x150d}
agx.fragment_occlusion_query_2 {unknown = 0x19326}
agx.fragment_shader_word_0 {unknown_0 = 0x1, uniform_register_count = 0x72, texture_state_register_count = 0x73, sampler_state_register_count = 0x1, preshader_register_count = 0x23, cf_binding_count = 0x36}
agx.fragment_shader_word_1 {unknown_10 = 0x2, pipeline = 0x98594740}
agx.fragment_shader_word_2 {cf_bindings = 0x8e600acc}
agx.fragment_shader_word_3 {unknown = 0xc}
agx.fragment_stencil {write_mask = 0x8b, read_mask = 0xb1, depth_pass = 0x0, depth_fail = 0x7, stencil_fail = 0x3, compare = 0x6}
agx.index_list {index_buffer_hi = 0x57, primitive = 0xa5, restart_enable = true, index_size = 0x4, index_buffer_size_present = true, index_buffer_present = true, index_count_present = false, instance_count_present = true, start_present = false, unk_1_present = false, indirect_buffer_present = false, unk_2_present = true}
agx.index_list_buffer_lo {buffer_lo = 0xf03b3189}
agx.index_list_buffer_size {size = 0x784abeb8}
agx.index_list_count {count = 0x85a300e0}
agx.index_list_indirect_buffer {address_hi = 0x5d, address_lo = 0xda048969}
agx.index_list_instances {count = 0xd5a2038f}
agx.index_list_start {start = 0x92936e8}
agx.output_select {clip_distance_plane_0 = true, clip_distance_plane_1 = false, clip_distance_plane_2 = false, clip_distance_plane_3 = true, clip_distance_plane_4 = false, clip_distance_plane_5 = false, clip_distance_plane_6 = true, clip_distance_plane_7 = true, clip_distance_plane_8 = false, clip_distance_plane_9 = true, clip_distance_plane_10 = false, clip_distance_plane_11 = true, clip_distance_plane_12 = true, clip_distance_plane_13 = false, clip_distance_plane_14 = false, clip_distance_plane_15 = true, varyings = false, point_size = false, viewport_target = true, render_target = false, frag_coord_z = true, barycentric_coordinates = false}
agx.output_size {count = 0x6d8a1848}
agx.output_unknown {}
agx.pbe {dimension = 0x3, layout = 0x2, channels = 0x2c, type = 0x3, swizzle_r = 0x0, swizzle_g = 0x1, swizzle_b = 0x1, swizzle_a = 0x1, width = 0x58e, height = 0x464, unk_52 = true, rotate_90 = true, flip_vertical = false, samples = 0x0, unk_mipmapped = false, compressed = false, mode = 0x3, buffer = 0x68dfc23070, level = 0x5, levels = 0x1, layers = 0x1287, page_aligned_layers = false, srgb = true, extended = true, stride = 0x1ba252, acceleration_buffer = 0x1ca7bd10d770f3c0, depth_linear = 0x2f3, layer_stride_linear = 0xd2d12700, level_offset_sw = 0x28008880, aligned_width_msaa_sw = 0x1bf0, sample_count_log2_sw = 0x1, tile_width_sw = 0x200, tile_height_sw = 0x1000, layer_stride_sw = 0x4a7a5c00, buffer_offset_sw = 0x88b3e9e}
agx.ppp_header {fragment_control = false, fragment_control_2 = true, fragment_front_face = true, fragment_front_face_2 = false, fragment_front_stencil = false, fragment_back_face = false, fragment_back_face_2 = false, fragment_back_stencil = true, depth_bias_scissor = false, region_clip = false, viewport = true, viewport_count = 0x10, w_clamp = true, output_select = false, varying_counts_32 = true, varying_counts_16 = true, cull = true, cull_2 = true, fragment_shader = true, occlusion_query = true, occlusion_query_2 = false, output_unknown = false, output_size = true, varying_word_2 = false}
agx.ppp_state {pointer_hi = 0x43, size_words = 0xcd, pointer_lo = 0xd24f0724}
agx.region_clip {max_x = 0x6e, min_x = 0x18, enable = true, max_y = 0x156, min_y = 0x1a7}
agx.sampler {minimum_lod = 7.38671875, maximum_lod = 13.84375, maximum_anisotropy = 0x8, magnify = 0x2, minify = 0x1, mip_filter = 0x2, wrap_s = 0x0, wrap_t = 0x6, wrap_r = 0x4, pixel_coordinates = true, compare_func = 0x0, compare_enable = true, border_colour = 0x3, seamful_cube_maps = false}
agx.scissor {max_x = 0x8899, min_x = 0x6584, max_y = 0x4cac, min_y = 0x2625, min_z = 0.04986574500799179, max_z = 35.33345031738281}
agx.sparse_block {address = 0x2ac29bc000, unknown = true, enabled = true}
agx.texture {dimension = 0x8, layout = 0x2, channels = 0x22, type = 0x6, swizzle_r = 0x0, swizzle_g = 0x7, swizzle_b = 0x2, swizzle_a = 0x6, width = 0x2828, height = 0x1b29, first_level = 0x2, last_level = 0x9, samples = 0x1, address = 0xad54a1bae0, unk_mipmapped = false, compressed = true, mode = 0x0, compression = 0x0, srgb = false, srgb_2_channel = false, stride = 0x3fc0c0, depth = 0x18d0, page_aligned_layers = false, extended = false, acceleration_buffer = 0x269e192448bfe110, depth_linear = 0x648, layer_stride_linear = 0x26456280, buffer_size_sw = 0x733f59ad, buffer_offset_sw = 0x4d0957fb}
agx.usc_fragment_properties {early_z_testing = true, unk_2 = true, unconditional_discard_1 = false, unconditional_discard_2 = false, unk_3 = 0x5, unk_4 = 0x39, unk_5 = 0xef}
agx.usc_no_preshader {}
agx.usc_preshader {code = 0xfe0022c2}
agx.usc_registers {register_count = 0x7e, unk_1 = false, spill_size = 0x6, unk_4 = 0x28}
agx.usc_sampler {start = 0xfe, count = 0x6b, buffer = 0x6618401680}
agx.usc_shader {loads_varyings = false, unk_1 = false, unk_2 = 0x10, code = 0x27b2bdda}
agx.usc_shared {uses_shared_memory = false, layout = 0x25, sample_count = 0x8, sample_stride_in_8_bytes = 0x3, bytes_per_threadgroup = 0xc04a}
agx.usc_texture {start = 0xb6, count = 0x3c, buffer = 0x1ea6b43670}
agx.usc_uniform {start_halfs = 0x7, size_halfs = 0x4, buffer = 0xd1ed801270}
agx.usc_uniform_high {start_halfs = 0x80, size_halfs = 0x16, buffer = 0x1880488a0c}
agx.varying_2 {}
agx.varying_counts {smooth = 0x1, flat = 0x96, linear = 0x22}
agx.vdm_barrier {usc_cache_inval = false, unk_4 = true, unk_5 = false, unk_6 = true, unk_8 = true, unk_11 = false, unk_20 = true, unk_24 = true, unk_26 = true, returns = false}
agx.vdm_state {restart_index_present = true, vertex_shader_word_0_present = true, vertex_shader_word_1_present = false, vertex_outputs_present = false, tessellation_present = true, vertex_unknown_present = false, tessellation_scale_present = true}
agx.vdm_state_restart_index {value = 0x9ba8d551}
agx.vdm_state_tessellation {unknown = 0x3018, step_function = 0x0, factor_type = 0x0, patch_type = 0x1, unknown_3 = 0x2, max_tess_factor = 0x1, counterclockwise_winding = false, partition_mode = 0x3}
agx.vdm_state_tessellation_scale {scale = 1.4408866167068481}
agx.vdm_state_vertex_outputs {output_count_1 = 0x86, output_count_2 = 0xb3}
agx.vdm_state_vertex_shader_word_0 {unknown_0 = 0x1, uniform_register_count = 0x1b5, texture_state_register_count = 0x78, sampler_state_register_count = 0x7, preshader_register_count = 0x6}
agx.vdm_state_vertex_shader_word_1 {unknown_10 = 0x0, pipeline = 0x5e75bd40}
agx.vdm_state_vertex_unknown {flat_shading_control = 0x3, unknown_4 = true, unknown_5 = false, generate_primitive_id = false}
agx.vdm_stream_link {target_hi = 0xd4, with_return = true, target_lo = 0xae6d4bca}
agx.vdm_stream_terminate {}
agx.vdm_tessellate {factor_buffer_hi = 0x58, unknown_0 = 0xb88, unknown_2 = true, factor_buffer_present = false, patch_count_present = true, instance_count_present = false, base_patch_present = true, base_instance_present = true, instance_stride_present = true, indirect_present = true, factor_buffer_size_present = true, unknown_1 = 0x1}
agx.vdm_tessellate_base_instance {base_instance = 0xa4465f14}
agx.vdm_tessellate_base_patch {base_patch = 0x2446b39d}
agx.vdm_tessellate_factor_buffer {factor_buffer_lo = 0x9c2ca931}
agx.vdm_tessellate_factor_buffer_size {size_words = 0xbc3f67cd}
agx.vdm_tessellate_indirect {address_hi = 0x82, address_lo = 0x6ab1f24, size = 0xc6685080}
agx.vdm_tessellate_instance_count {instance_count = 0x76427709}
agx.vdm_tessellate_instance_stride {instance_stride = 0xe057776c}
agx.vdm_tessellate_patch_count {patch_count = 0x5b36d6af}
agx.viewport {translate_x = -15.988232612609863, scale_x = -0.9444540143013, translate_y = 3.518246650695801, scale_y = 0.20684048533439636, translate_z = 0.05714362859725952, scale_z = -0.22238439321517944}
agx.viewport_control {}
agx.w_clamp {w_clamp = 0.0362451933324337}
agx.zls_control {unknown_0 = true, z_load_tiling = 0x0, z_load_compress = false, s_load_tiling = 0x1, s_load_compress = false, z_store_tiling = 0x1, z_store_compress = true, s_store_tiling = 0x0, s_store_compress = false, s_load = true, z_load = true, s_store = true, z_store = true, z_format = 0x2, z_resolve = true, s_resolve = true}
