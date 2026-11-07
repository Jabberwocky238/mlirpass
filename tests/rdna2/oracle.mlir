// Every gfx103 register / packet dword with fields, each field a random value of its width (scripts/amd-reg-oracle.sh);
// oracle.expected is what Mesa's S_* macros pack from the same values.
rdna2.reg.cb_blend0_control {color_srcblend = 0x1f, color_comb_fcn = 0x5, color_destblend = 0xe, alpha_srcblend = 0x1d, alpha_comb_fcn = 0x5, alpha_destblend = 0x16, separate_alpha_blend = 0x1, enable = 0x1, disable_rop3 = 0x0}
rdna2.reg.cb_blend1_control {color_srcblend = 0x16, color_comb_fcn = 0x0, color_destblend = 0x1d, alpha_srcblend = 0x13, alpha_comb_fcn = 0x5, alpha_destblend = 0x3, separate_alpha_blend = 0x1, enable = 0x0, disable_rop3 = 0x0}
rdna2.reg.cb_blend2_control {color_srcblend = 0x1c, color_comb_fcn = 0x2, color_destblend = 0x1b, alpha_srcblend = 0x15, alpha_comb_fcn = 0x0, alpha_destblend = 0xf, separate_alpha_blend = 0x0, enable = 0x0, disable_rop3 = 0x0}
rdna2.reg.cb_blend3_control {color_srcblend = 0x12, color_comb_fcn = 0x6, color_destblend = 0x1f, alpha_srcblend = 0x0, alpha_comb_fcn = 0x0, alpha_destblend = 0x7, separate_alpha_blend = 0x1, enable = 0x0, disable_rop3 = 0x1}
rdna2.reg.cb_blend4_control {color_srcblend = 0x4, color_comb_fcn = 0x4, color_destblend = 0x10, alpha_srcblend = 0x9, alpha_comb_fcn = 0x1, alpha_destblend = 0x17, separate_alpha_blend = 0x0, enable = 0x1, disable_rop3 = 0x1}
rdna2.reg.cb_blend5_control {color_srcblend = 0x12, color_comb_fcn = 0x5, color_destblend = 0x15, alpha_srcblend = 0xd, alpha_comb_fcn = 0x1, alpha_destblend = 0x19, separate_alpha_blend = 0x1, enable = 0x1, disable_rop3 = 0x1}
rdna2.reg.cb_blend6_control {color_srcblend = 0x1a, color_comb_fcn = 0x4, color_destblend = 0x7, alpha_srcblend = 0x2, alpha_comb_fcn = 0x2, alpha_destblend = 0x6, separate_alpha_blend = 0x1, enable = 0x0, disable_rop3 = 0x1}
rdna2.reg.cb_blend7_control {color_srcblend = 0x16, color_comb_fcn = 0x4, color_destblend = 0x10, alpha_srcblend = 0xf, alpha_comb_fcn = 0x6, alpha_destblend = 0x8, separate_alpha_blend = 0x1, enable = 0x0, disable_rop3 = 0x1}
rdna2.reg.cb_color0_attrib {tile_mode_index = 0x6, fmask_tile_mode_index = 0x18, fmask_bank_height = 0x3, num_samples = 0x4, num_fragments = 0x3, force_dst_alpha_1 = 0x1, disable_fmask_nofetch_opt = 0x1, limit_color_fetch_to_256b_max = 0x0}
rdna2.reg.cb_color0_attrib2 {mip0_height = 0x21d4, mip0_width = 0xc5b, max_mip = 0xb}
rdna2.reg.cb_color0_attrib3 {mip0_depth = 0x10c0, meta_linear = 0x0, color_sw_mode = 0x1, fmask_sw_mode = 0xf, resource_type = 0x3, cmask_pipe_aligned = 0x0, resource_level = 0x1, dcc_pipe_aligned = 0x0, vrs_rate_hint_enable = 0x1}
rdna2.reg.cb_color0_base_ext {base_256b = 0x40}
rdna2.reg.cb_color0_cmask_base_ext {base_256b = 0xeb}
rdna2.reg.cb_color0_cmask_slice {tile_max = 0x666}
rdna2.reg.cb_color0_dcc_base_ext {base_256b = 0x7b}
rdna2.reg.cb_color0_dcc_control {overwrite_combiner_disable = 0x1, key_clear_enable = 0x0, max_uncompressed_block_size = 0x0, min_compressed_block_size = 0x1, max_compressed_block_size = 0x3, color_transform = 0x2, independent_64b_blocks = 0x1, lossy_rgb_precision = 0xd, lossy_alpha_precision = 0x1, disable_constant_encode_reg = 0x0, enable_constant_encode_reg_write = 0x0, independent_128b_blocks = 0x1, skip_low_comp_ratio = 0x1, dcc_compress_disable = 0x0}
rdna2.reg.cb_color0_fmask_base_ext {base_256b = 0xfc}
rdna2.reg.cb_color0_fmask_slice {tile_max = 0x3a6f27}
rdna2.reg.cb_color0_info {endian = 0x2, format = 0x18, linear_general = 0x1, number_type = 0x0, comp_swap = 0x2, fast_clear = 0x0, compression = 0x0, blend_clamp = 0x0, blend_bypass = 0x1, simple_float = 0x0, round_mode = 0x1, cmask_is_linear = 0x1, blend_opt_dont_rd_dst = 0x3, blend_opt_discard_pixel = 0x3, fmask_compression_disable = 0x1, fmask_compress_1frag_only = 0x1, dcc_enable = 0x0, cmask_addr_type = 0x1, nbc_tiling = 0x1}
rdna2.reg.cb_color0_pitch {tile_max = 0x71c, fmask_tile_max = 0x84}
rdna2.reg.cb_color0_slice {tile_max = 0xb4ca1}
rdna2.reg.cb_color0_view {slice_start = 0xe3c, slice_max = 0x18eb, mip_level = 0x0}
rdna2.reg.cb_color1_attrib {tile_mode_index = 0xa, fmask_tile_mode_index = 0x14, fmask_bank_height = 0x1, num_samples = 0x6, num_fragments = 0x0, force_dst_alpha_1 = 0x1, disable_fmask_nofetch_opt = 0x0, limit_color_fetch_to_256b_max = 0x1}
rdna2.reg.cb_color1_attrib2 {mip0_height = 0xf37, mip0_width = 0x27d6, max_mip = 0x3}
rdna2.reg.cb_color1_attrib3 {mip0_depth = 0x754, meta_linear = 0x1, color_sw_mode = 0xc, fmask_sw_mode = 0x4, resource_type = 0x2, cmask_pipe_aligned = 0x0, resource_level = 0x5, dcc_pipe_aligned = 0x1, vrs_rate_hint_enable = 0x0}
rdna2.reg.cb_color1_base_ext {base_256b = 0x7}
rdna2.reg.cb_color1_cmask_base_ext {base_256b = 0x7a}
rdna2.reg.cb_color1_cmask_slice {tile_max = 0x1d13}
rdna2.reg.cb_color1_dcc_base_ext {base_256b = 0x54}
rdna2.reg.cb_color1_dcc_control {overwrite_combiner_disable = 0x0, key_clear_enable = 0x1, max_uncompressed_block_size = 0x0, min_compressed_block_size = 0x1, max_compressed_block_size = 0x0, color_transform = 0x1, independent_64b_blocks = 0x0, lossy_rgb_precision = 0xa, lossy_alpha_precision = 0xa, disable_constant_encode_reg = 0x1, enable_constant_encode_reg_write = 0x0, independent_128b_blocks = 0x1, skip_low_comp_ratio = 0x0, dcc_compress_disable = 0x1}
rdna2.reg.cb_color1_fmask_base_ext {base_256b = 0x74}
rdna2.reg.cb_color1_fmask_slice {tile_max = 0x13ced8}
rdna2.reg.cb_color1_info {endian = 0x1, format = 0x1d, linear_general = 0x0, number_type = 0x1, comp_swap = 0x1, fast_clear = 0x0, compression = 0x1, blend_clamp = 0x1, blend_bypass = 0x1, simple_float = 0x0, round_mode = 0x1, cmask_is_linear = 0x1, blend_opt_dont_rd_dst = 0x5, blend_opt_discard_pixel = 0x6, fmask_compression_disable = 0x1, fmask_compress_1frag_only = 0x1, dcc_enable = 0x1, cmask_addr_type = 0x2, nbc_tiling = 0x0}
rdna2.reg.cb_color1_pitch {tile_max = 0x2c3, fmask_tile_max = 0x111}
rdna2.reg.cb_color1_slice {tile_max = 0x15444b}
rdna2.reg.cb_color1_view {slice_start = 0x14b6, slice_max = 0x1432, mip_level = 0xb}
rdna2.reg.cb_color2_attrib {tile_mode_index = 0x2, fmask_tile_mode_index = 0x1b, fmask_bank_height = 0x0, num_samples = 0x4, num_fragments = 0x3, force_dst_alpha_1 = 0x0, disable_fmask_nofetch_opt = 0x1, limit_color_fetch_to_256b_max = 0x1}
rdna2.reg.cb_color2_attrib2 {mip0_height = 0xa6c, mip0_width = 0x1a43, max_mip = 0x6}
rdna2.reg.cb_color2_attrib3 {mip0_depth = 0x1a63, meta_linear = 0x0, color_sw_mode = 0x18, fmask_sw_mode = 0x1b, resource_type = 0x3, cmask_pipe_aligned = 0x0, resource_level = 0x4, dcc_pipe_aligned = 0x1, vrs_rate_hint_enable = 0x1}
rdna2.reg.cb_color2_base_ext {base_256b = 0xbe}
rdna2.reg.cb_color2_cmask_base_ext {base_256b = 0x8a}
rdna2.reg.cb_color2_cmask_slice {tile_max = 0x1466}
rdna2.reg.cb_color2_dcc_base_ext {base_256b = 0x6a}
rdna2.reg.cb_color2_dcc_control {overwrite_combiner_disable = 0x0, key_clear_enable = 0x0, max_uncompressed_block_size = 0x2, min_compressed_block_size = 0x0, max_compressed_block_size = 0x1, color_transform = 0x3, independent_64b_blocks = 0x1, lossy_rgb_precision = 0x7, lossy_alpha_precision = 0x5, disable_constant_encode_reg = 0x1, enable_constant_encode_reg_write = 0x1, independent_128b_blocks = 0x1, skip_low_comp_ratio = 0x0, dcc_compress_disable = 0x0}
rdna2.reg.cb_color2_fmask_base_ext {base_256b = 0x22}
rdna2.reg.cb_color2_fmask_slice {tile_max = 0x1d57f6}
rdna2.reg.cb_color2_info {endian = 0x3, format = 0xe, linear_general = 0x1, number_type = 0x7, comp_swap = 0x2, fast_clear = 0x1, compression = 0x1, blend_clamp = 0x1, blend_bypass = 0x1, simple_float = 0x1, round_mode = 0x1, cmask_is_linear = 0x1, blend_opt_dont_rd_dst = 0x0, blend_opt_discard_pixel = 0x0, fmask_compression_disable = 0x0, fmask_compress_1frag_only = 0x1, dcc_enable = 0x0, cmask_addr_type = 0x3, nbc_tiling = 0x0}
rdna2.reg.cb_color2_pitch {tile_max = 0x136, fmask_tile_max = 0x1ef}
rdna2.reg.cb_color2_slice {tile_max = 0x2665bb}
rdna2.reg.cb_color2_view {slice_start = 0xec3, slice_max = 0x16a4, mip_level = 0xa}
rdna2.reg.cb_color3_attrib {tile_mode_index = 0xc, fmask_tile_mode_index = 0x1b, fmask_bank_height = 0x0, num_samples = 0x2, num_fragments = 0x2, force_dst_alpha_1 = 0x0, disable_fmask_nofetch_opt = 0x1, limit_color_fetch_to_256b_max = 0x1}
rdna2.reg.cb_color3_attrib2 {mip0_height = 0x2628, mip0_width = 0x320e, max_mip = 0xa}
rdna2.reg.cb_color3_attrib3 {mip0_depth = 0x119c, meta_linear = 0x1, color_sw_mode = 0x3, fmask_sw_mode = 0x13, resource_type = 0x0, cmask_pipe_aligned = 0x0, resource_level = 0x7, dcc_pipe_aligned = 0x0, vrs_rate_hint_enable = 0x1}
rdna2.reg.cb_color3_base_ext {base_256b = 0x59}
rdna2.reg.cb_color3_cmask_base_ext {base_256b = 0xdc}
rdna2.reg.cb_color3_cmask_slice {tile_max = 0x3345}
rdna2.reg.cb_color3_dcc_base_ext {base_256b = 0xc8}
rdna2.reg.cb_color3_dcc_control {overwrite_combiner_disable = 0x0, key_clear_enable = 0x1, max_uncompressed_block_size = 0x3, min_compressed_block_size = 0x1, max_compressed_block_size = 0x2, color_transform = 0x1, independent_64b_blocks = 0x1, lossy_rgb_precision = 0x3, lossy_alpha_precision = 0x4, disable_constant_encode_reg = 0x0, enable_constant_encode_reg_write = 0x1, independent_128b_blocks = 0x1, skip_low_comp_ratio = 0x0, dcc_compress_disable = 0x1}
rdna2.reg.cb_color3_fmask_base_ext {base_256b = 0x4b}
rdna2.reg.cb_color3_fmask_slice {tile_max = 0x307a08}
rdna2.reg.cb_color3_info {endian = 0x1, format = 0x12, linear_general = 0x1, number_type = 0x3, comp_swap = 0x1, fast_clear = 0x0, compression = 0x0, blend_clamp = 0x1, blend_bypass = 0x1, simple_float = 0x1, round_mode = 0x1, cmask_is_linear = 0x1, blend_opt_dont_rd_dst = 0x3, blend_opt_discard_pixel = 0x5, fmask_compression_disable = 0x1, fmask_compress_1frag_only = 0x1, dcc_enable = 0x0, cmask_addr_type = 0x3, nbc_tiling = 0x0}
rdna2.reg.cb_color3_pitch {tile_max = 0xdb, fmask_tile_max = 0x2d8}
rdna2.reg.cb_color3_slice {tile_max = 0x1265b9}
rdna2.reg.cb_color3_view {slice_start = 0x157f, slice_max = 0x139d, mip_level = 0xf}
rdna2.reg.cb_color4_attrib {tile_mode_index = 0x16, fmask_tile_mode_index = 0x10, fmask_bank_height = 0x1, num_samples = 0x0, num_fragments = 0x3, force_dst_alpha_1 = 0x0, disable_fmask_nofetch_opt = 0x0, limit_color_fetch_to_256b_max = 0x0}
rdna2.reg.cb_color4_attrib2 {mip0_height = 0x30f9, mip0_width = 0x2d6f, max_mip = 0x0}
rdna2.reg.cb_color4_attrib3 {mip0_depth = 0x151b, meta_linear = 0x0, color_sw_mode = 0xf, fmask_sw_mode = 0x0, resource_type = 0x0, cmask_pipe_aligned = 0x1, resource_level = 0x1, dcc_pipe_aligned = 0x1, vrs_rate_hint_enable = 0x1}
rdna2.reg.cb_color4_base_ext {base_256b = 0xf3}
rdna2.reg.cb_color4_cmask_base_ext {base_256b = 0x19}
rdna2.reg.cb_color4_cmask_slice {tile_max = 0x26d5}
rdna2.reg.cb_color4_dcc_base_ext {base_256b = 0x3d}
rdna2.reg.cb_color4_dcc_control {overwrite_combiner_disable = 0x0, key_clear_enable = 0x0, max_uncompressed_block_size = 0x1, min_compressed_block_size = 0x1, max_compressed_block_size = 0x1, color_transform = 0x1, independent_64b_blocks = 0x0, lossy_rgb_precision = 0x1, lossy_alpha_precision = 0x1, disable_constant_encode_reg = 0x0, enable_constant_encode_reg_write = 0x1, independent_128b_blocks = 0x1, skip_low_comp_ratio = 0x0, dcc_compress_disable = 0x1}
rdna2.reg.cb_color4_fmask_base_ext {base_256b = 0x74}
rdna2.reg.cb_color4_fmask_slice {tile_max = 0x34e957}
rdna2.reg.cb_color4_info {endian = 0x2, format = 0x1d, linear_general = 0x0, number_type = 0x1, comp_swap = 0x1, fast_clear = 0x1, compression = 0x0, blend_clamp = 0x1, blend_bypass = 0x0, simple_float = 0x1, round_mode = 0x1, cmask_is_linear = 0x0, blend_opt_dont_rd_dst = 0x0, blend_opt_discard_pixel = 0x4, fmask_compression_disable = 0x0, fmask_compress_1frag_only = 0x1, dcc_enable = 0x0, cmask_addr_type = 0x1, nbc_tiling = 0x1}
rdna2.reg.cb_color4_pitch {tile_max = 0x7f4, fmask_tile_max = 0x262}
rdna2.reg.cb_color4_slice {tile_max = 0xa0e3c}
rdna2.reg.cb_color4_view {slice_start = 0x1ee1, slice_max = 0x1775, mip_level = 0x7}
rdna2.reg.cb_color5_attrib {tile_mode_index = 0xa, fmask_tile_mode_index = 0x15, fmask_bank_height = 0x2, num_samples = 0x4, num_fragments = 0x1, force_dst_alpha_1 = 0x1, disable_fmask_nofetch_opt = 0x0, limit_color_fetch_to_256b_max = 0x1}
rdna2.reg.cb_color5_attrib2 {mip0_height = 0x2344, mip0_width = 0x2907, max_mip = 0x4}
rdna2.reg.cb_color5_attrib3 {mip0_depth = 0x106, meta_linear = 0x1, color_sw_mode = 0x4, fmask_sw_mode = 0xf, resource_type = 0x3, cmask_pipe_aligned = 0x0, resource_level = 0x3, dcc_pipe_aligned = 0x0, vrs_rate_hint_enable = 0x1}
rdna2.reg.cb_color5_base_ext {base_256b = 0x44}
rdna2.reg.cb_color5_cmask_base_ext {base_256b = 0xa2}
rdna2.reg.cb_color5_cmask_slice {tile_max = 0x3916}
rdna2.reg.cb_color5_dcc_base_ext {base_256b = 0xd2}
rdna2.reg.cb_color5_dcc_control {overwrite_combiner_disable = 0x1, key_clear_enable = 0x1, max_uncompressed_block_size = 0x3, min_compressed_block_size = 0x1, max_compressed_block_size = 0x2, color_transform = 0x2, independent_64b_blocks = 0x0, lossy_rgb_precision = 0xf, lossy_alpha_precision = 0xf, disable_constant_encode_reg = 0x0, enable_constant_encode_reg_write = 0x0, independent_128b_blocks = 0x0, skip_low_comp_ratio = 0x0, dcc_compress_disable = 0x0}
rdna2.reg.cb_color5_fmask_base_ext {base_256b = 0xb8}
rdna2.reg.cb_color5_fmask_slice {tile_max = 0x1029aa}
rdna2.reg.cb_color5_info {endian = 0x2, format = 0x1c, linear_general = 0x1, number_type = 0x5, comp_swap = 0x3, fast_clear = 0x0, compression = 0x1, blend_clamp = 0x0, blend_bypass = 0x1, simple_float = 0x0, round_mode = 0x1, cmask_is_linear = 0x1, blend_opt_dont_rd_dst = 0x1, blend_opt_discard_pixel = 0x2, fmask_compression_disable = 0x0, fmask_compress_1frag_only = 0x0, dcc_enable = 0x0, cmask_addr_type = 0x1, nbc_tiling = 0x0}
rdna2.reg.cb_color5_pitch {tile_max = 0x703, fmask_tile_max = 0x2f2}
rdna2.reg.cb_color5_slice {tile_max = 0x2e6bed}
rdna2.reg.cb_color5_view {slice_start = 0x3b, slice_max = 0x1a30, mip_level = 0x9}
rdna2.reg.cb_color6_attrib {tile_mode_index = 0x8, fmask_tile_mode_index = 0xb, fmask_bank_height = 0x2, num_samples = 0x1, num_fragments = 0x0, force_dst_alpha_1 = 0x0, disable_fmask_nofetch_opt = 0x0, limit_color_fetch_to_256b_max = 0x0}
rdna2.reg.cb_color6_attrib2 {mip0_height = 0x3d33, mip0_width = 0xd96, max_mip = 0x3}
rdna2.reg.cb_color6_attrib3 {mip0_depth = 0x1685, meta_linear = 0x0, color_sw_mode = 0x12, fmask_sw_mode = 0x6, resource_type = 0x3, cmask_pipe_aligned = 0x1, resource_level = 0x7, dcc_pipe_aligned = 0x1, vrs_rate_hint_enable = 0x1}
rdna2.reg.cb_color6_base_ext {base_256b = 0x97}
rdna2.reg.cb_color6_cmask_base_ext {base_256b = 0xcf}
rdna2.reg.cb_color6_cmask_slice {tile_max = 0x3676}
rdna2.reg.cb_color6_dcc_base_ext {base_256b = 0xce}
rdna2.reg.cb_color6_dcc_control {overwrite_combiner_disable = 0x0, key_clear_enable = 0x0, max_uncompressed_block_size = 0x3, min_compressed_block_size = 0x0, max_compressed_block_size = 0x3, color_transform = 0x0, independent_64b_blocks = 0x0, lossy_rgb_precision = 0x6, lossy_alpha_precision = 0x3, disable_constant_encode_reg = 0x0, enable_constant_encode_reg_write = 0x1, independent_128b_blocks = 0x0, skip_low_comp_ratio = 0x0, dcc_compress_disable = 0x1}
rdna2.reg.cb_color6_fmask_base_ext {base_256b = 0xca}
rdna2.reg.cb_color6_fmask_slice {tile_max = 0x319160}
rdna2.reg.cb_color6_info {endian = 0x2, format = 0x1c, linear_general = 0x1, number_type = 0x2, comp_swap = 0x2, fast_clear = 0x1, compression = 0x0, blend_clamp = 0x1, blend_bypass = 0x1, simple_float = 0x1, round_mode = 0x1, cmask_is_linear = 0x1, blend_opt_dont_rd_dst = 0x5, blend_opt_discard_pixel = 0x1, fmask_compression_disable = 0x1, fmask_compress_1frag_only = 0x0, dcc_enable = 0x0, cmask_addr_type = 0x2, nbc_tiling = 0x0}
rdna2.reg.cb_color6_pitch {tile_max = 0x501, fmask_tile_max = 0x395}
rdna2.reg.cb_color6_slice {tile_max = 0x277057}
rdna2.reg.cb_color6_view {slice_start = 0x12fe, slice_max = 0x190b, mip_level = 0xb}
rdna2.reg.cb_color7_attrib {tile_mode_index = 0x19, fmask_tile_mode_index = 0xf, fmask_bank_height = 0x2, num_samples = 0x4, num_fragments = 0x1, force_dst_alpha_1 = 0x0, disable_fmask_nofetch_opt = 0x0, limit_color_fetch_to_256b_max = 0x0}
rdna2.reg.cb_color7_attrib2 {mip0_height = 0x2d14, mip0_width = 0x7c8, max_mip = 0x0}
rdna2.reg.cb_color7_attrib3 {mip0_depth = 0xa33, meta_linear = 0x1, color_sw_mode = 0x7, fmask_sw_mode = 0xc, resource_type = 0x0, cmask_pipe_aligned = 0x1, resource_level = 0x2, dcc_pipe_aligned = 0x0, vrs_rate_hint_enable = 0x0}
rdna2.reg.cb_color7_base_ext {base_256b = 0xfc}
rdna2.reg.cb_color7_cmask_base_ext {base_256b = 0xd2}
rdna2.reg.cb_color7_cmask_slice {tile_max = 0x372f}
rdna2.reg.cb_color7_dcc_base_ext {base_256b = 0xef}
rdna2.reg.cb_color7_dcc_control {overwrite_combiner_disable = 0x1, key_clear_enable = 0x1, max_uncompressed_block_size = 0x3, min_compressed_block_size = 0x1, max_compressed_block_size = 0x1, color_transform = 0x0, independent_64b_blocks = 0x0, lossy_rgb_precision = 0x3, lossy_alpha_precision = 0x1, disable_constant_encode_reg = 0x1, enable_constant_encode_reg_write = 0x1, independent_128b_blocks = 0x1, skip_low_comp_ratio = 0x1, dcc_compress_disable = 0x1}
rdna2.reg.cb_color7_fmask_base_ext {base_256b = 0x63}
rdna2.reg.cb_color7_fmask_slice {tile_max = 0xcc808}
rdna2.reg.cb_color7_info {endian = 0x3, format = 0x7, linear_general = 0x0, number_type = 0x0, comp_swap = 0x2, fast_clear = 0x1, compression = 0x0, blend_clamp = 0x0, blend_bypass = 0x1, simple_float = 0x0, round_mode = 0x1, cmask_is_linear = 0x0, blend_opt_dont_rd_dst = 0x4, blend_opt_discard_pixel = 0x0, fmask_compression_disable = 0x1, fmask_compress_1frag_only = 0x0, dcc_enable = 0x0, cmask_addr_type = 0x3, nbc_tiling = 0x0}
rdna2.reg.cb_color7_pitch {tile_max = 0x538, fmask_tile_max = 0x51f}
rdna2.reg.cb_color7_slice {tile_max = 0x24959a}
rdna2.reg.cb_color7_view {slice_start = 0x12a6, slice_max = 0x204, mip_level = 0x7}
rdna2.reg.cb_color_control {disable_dual_quad = 0x0, enable_1frag_ps_invoke = 0x1, degamma_enable = 0x0, mode = 0x1, rop3 = 0xa1}
rdna2.reg.cb_coverage_out_control {coverage_out_enable = 0x0, coverage_out_mrt = 0x3, coverage_out_channel = 0x0, coverage_out_samples = 0xc}
rdna2.reg.cb_dcc_control {overwrite_combiner_disable = 0x0, overwrite_combiner_watermark = 0x8, disable_constant_encode_ac01 = 0x0, disable_constant_encode_single = 0x1, disable_constant_encode_reg = 0x1, disable_elimfc_skip_of_ac01 = 0x0, disable_elimfc_skip_of_single = 0x0, enable_elimfc_skip_of_reg = 0x0}
rdna2.reg.cb_perfcounter0_select {perf_sel = 0x162, perf_sel1 = 0x198, cntr_mode = 0x1, perf_mode1 = 0xd, perf_mode = 0x9}
rdna2.reg.cb_perfcounter0_select1 {perf_sel2 = 0x9b, perf_sel3 = 0x19d, perf_mode3 = 0x3, perf_mode2 = 0xf}
rdna2.reg.cb_perfcounter1_select {perf_sel = 0x1ec, perf_mode = 0xb}
rdna2.reg.cb_perfcounter2_select {perf_sel = 0x12f, perf_mode = 0x0}
rdna2.reg.cb_perfcounter3_select {perf_sel = 0x2d, perf_mode = 0xc}
rdna2.reg.cb_perfcounter_filter {op_filter_enable = 0x1, op_filter_sel = 0x5, format_filter_enable = 0x1, format_filter_sel = 0xf, clear_filter_enable = 0x0, clear_filter_sel = 0x0, mrt_filter_enable = 0x1, mrt_filter_sel = 0x4, num_samples_filter_enable = 0x0, num_samples_filter_sel = 0x0, num_fragments_filter_enable = 0x1, num_fragments_filter_sel = 0x2}
rdna2.reg.cb_rmi_gl2_cache_control {cmask_wr_policy = 0x1, fmask_wr_policy = 0x2, dcc_wr_policy = 0x1, color_wr_policy = 0x3, cmask_rd_policy = 0x2, fmask_rd_policy = 0x2, dcc_rd_policy = 0x1, color_rd_policy = 0x0, cmask_l3_bypass = 0x1, fmask_l3_bypass = 0x0, dcc_l3_bypass = 0x1, color_l3_bypass = 0x1, fmask_big_page = 0x1, color_big_page = 0x0}
rdna2.reg.cb_shader_mask {output0_enable = 0x2, output1_enable = 0xd, output2_enable = 0xd, output3_enable = 0x6, output4_enable = 0xb, output5_enable = 0x7, output6_enable = 0x2, output7_enable = 0xf}
rdna2.reg.cb_target_mask {target0_enable = 0xe, target1_enable = 0x8, target2_enable = 0x8, target3_enable = 0x9, target4_enable = 0x2, target5_enable = 0x1, target6_enable = 0x3, target7_enable = 0xb}
rdna2.reg.cha_perfcounter0_select {perf_sel = 0x3ff, perf_sel1 = 0x19e, cntr_mode = 0xc, perf_mode1 = 0x2, perf_mode = 0x3}
rdna2.reg.cha_perfcounter0_select1 {perf_sel2 = 0x162, perf_sel3 = 0x391, perf_mode2 = 0x7, perf_mode3 = 0x0}
rdna2.reg.cha_perfcounter1_select {perf_sel = 0x1d4, cntr_mode = 0xb, perf_mode = 0x0}
rdna2.reg.cha_perfcounter2_select {perf_sel = 0x288, cntr_mode = 0x4, perf_mode = 0xd}
rdna2.reg.cha_perfcounter3_select {perf_sel = 0x15c, cntr_mode = 0xe, perf_mode = 0x1}
rdna2.reg.chcg_perfcounter0_select {perf_sel = 0x2ed, perf_sel1 = 0x2a2, cntr_mode = 0xd, perf_mode1 = 0x2, perf_mode = 0x7}
rdna2.reg.chcg_perfcounter0_select1 {perf_sel2 = 0x2c8, perf_sel3 = 0x3bb, perf_mode2 = 0xb, perf_mode3 = 0x6}
rdna2.reg.chcg_perfcounter1_select {perf_sel = 0x37a, cntr_mode = 0xb, perf_mode = 0xc}
rdna2.reg.chcg_perfcounter2_select {perf_sel = 0x300, cntr_mode = 0xb, perf_mode = 0x6}
rdna2.reg.chcg_perfcounter3_select {perf_sel = 0x2b9, cntr_mode = 0xd, perf_mode = 0xf}
rdna2.reg.chc_perfcounter0_select {perf_sel = 0x2df, perf_sel1 = 0x1bb, cntr_mode = 0x2, perf_mode1 = 0x0, perf_mode = 0x9}
rdna2.reg.chc_perfcounter0_select1 {perf_sel2 = 0x37f, perf_sel3 = 0x1f1, perf_mode2 = 0xa, perf_mode3 = 0x9}
rdna2.reg.chc_perfcounter1_select {perf_sel = 0x144, cntr_mode = 0x0, perf_mode = 0x9}
rdna2.reg.chc_perfcounter2_select {perf_sel = 0x2cd, cntr_mode = 0xe, perf_mode = 0x6}
rdna2.reg.chc_perfcounter3_select {perf_sel = 0x39a, cntr_mode = 0xb, perf_mode = 0xf}
rdna2.reg.coher_dest_base_hi_0 {dest_base_hi_256b = 0x3d}
rdna2.reg.coher_dest_base_hi_1 {dest_base_hi_256b = 0x55}
rdna2.reg.coher_dest_base_hi_2 {dest_base_hi_256b = 0x5}
rdna2.reg.coher_dest_base_hi_3 {dest_base_hi_256b = 0x9b}
rdna2.reg.compute_ddid_index {index = 0x3b9}
rdna2.reg.compute_dispatch_initiator {compute_shader_en = 0x1, partial_tg_en = 0x1, force_start_at_000 = 0x1, ordered_append_enbl = 0x1, ordered_append_mode = 0x0, use_thread_dimensions = 0x1, order_mode = 0x1, scalar_l1_inv_vol = 0x1, vector_l1_inv_vol = 0x1, tunnel_enable = 0x0, restore = 0x1, cs_w32_en = 0x0}
rdna2.reg.compute_dispatch_pkt_addr_hi {data = 0x1a}
rdna2.reg.compute_dispatch_scratch_base_hi {data = 0x67}
rdna2.reg.compute_dispatch_tunnel {off_delay = 0x2c4, immediate = 0x1}
rdna2.reg.compute_misc_reserved {send_seid = 0x3, reserved2 = 0x1, reserved3 = 0x0, reserved4 = 0x0, wave_id_base = 0xe0e}
rdna2.reg.compute_num_thread_x {num_thread_full = 0x992b, num_thread_partial = 0xb310}
rdna2.reg.compute_num_thread_y {num_thread_full = 0x5983, num_thread_partial = 0xd22a}
rdna2.reg.compute_num_thread_z {num_thread_full = 0x8737, num_thread_partial = 0x9e3f}
rdna2.reg.compute_perfcount_enable {perfcount_enable = 0x0}
rdna2.reg.compute_pgm_hi {data = 0x60}
rdna2.reg.compute_pgm_rsrc1 {vgprs = 0xa, sgprs = 0xf, priority = 0x2, float_mode = 0xeb, priv = 0x0, dx10_clamp = 0x1, ieee_mode = 0x1, bulky = 0x1, fp16_ovfl = 0x1, wgp_mode = 0x1, mem_ordered = 0x0, fwd_progress = 0x1}
rdna2.reg.compute_pgm_rsrc2 {scratch_en = 0x0, user_sgpr = 0x1e, trap_present = 0x1, tgid_x_en = 0x0, tgid_y_en = 0x1, tgid_z_en = 0x0, tg_size_en = 0x0, tidig_comp_cnt = 0x2, excp_en_msb = 0x3, lds_size = 0xc5, excp_en = 0x41}
rdna2.reg.compute_pgm_rsrc3 {shared_vgpr_cnt = 0xd}
rdna2.reg.compute_pipelinestat_enable {pipelinestat_enable = 0x1}
rdna2.reg.compute_relaunch {payload = 0x1d94e6c0, is_event = 0x1, is_state = 0x1}
rdna2.reg.compute_relaunch2 {payload = 0x354413ce, is_event = 0x0, is_state = 0x0}
rdna2.reg.compute_req_ctrl {soft_grouping_en = 0x0, number_of_requests_per_cu = 0xf, soft_grouping_allocation_timeout = 0x2, hard_lock_hysteresis = 0x1, hard_lock_low_threshold = 0x1f, producer_request_lockout = 0x0, global_scanning_en = 0x0, allocation_rate_throttling_threshold = 0x4, dedicated_preallocation_buffer_limit = 0x3}
rdna2.reg.compute_resource_limits {waves_per_sh = 0x3a, tg_per_cu = 0x8, lock_threshold = 0x1b, simd_dest_cntl = 0x1, force_simd_dist = 0x0, cu_group_count = 0x2}
rdna2.reg.compute_thread_trace_enable {thread_trace_enable = 0x0}
rdna2.reg.compute_tmpring_size {waves = 0xa2b, wavesize = 0xe68}
rdna2.reg.compute_user_accum_0 {contribution = 0x12}
rdna2.reg.compute_user_accum_1 {contribution = 0x6b}
rdna2.reg.compute_user_accum_2 {contribution = 0x77}
rdna2.reg.compute_user_accum_3 {contribution = 0x61}
rdna2.reg.compute_vmid {data = 0x4}
rdna2.reg.compute_wave_restore_addr_hi {addr = 0xef7b}
rdna2.reg.cpc_latency_stats_select {index = 0x1, clear = 0x1, enable = 0x0}
rdna2.reg.cpc_perfcounter0_select {perf_sel = 0x278, perf_sel1 = 0x143, spm_mode = 0x9, cntr_mode1 = 0x5, cntr_mode0 = 0xf}
rdna2.reg.cpc_perfcounter0_select1 {perf_sel2 = 0x30, perf_sel3 = 0x84, cntr_mode3 = 0x8, cntr_mode2 = 0x8}
rdna2.reg.cpc_perfcounter1_select {perf_sel = 0x3e8, perf_sel1 = 0x22d, spm_mode = 0xf, cntr_mode1 = 0x0, cntr_mode0 = 0x3}
rdna2.reg.cpf_latency_stats_select {index = 0xe, clear = 0x1, enable = 0x1}
rdna2.reg.cpf_perfcounter0_select {perf_sel = 0x3c8, perf_sel1 = 0x15b, spm_mode = 0x7, cntr_mode1 = 0xc, cntr_mode0 = 0x2}
rdna2.reg.cpf_perfcounter0_select1 {perf_sel2 = 0x1e8, perf_sel3 = 0x2a5, cntr_mode3 = 0xb, cntr_mode2 = 0xb}
rdna2.reg.cpf_perfcounter1_select {perf_sel = 0x232, perf_sel1 = 0x7b, spm_mode = 0xd, cntr_mode1 = 0x8, cntr_mode0 = 0x8}
rdna2.reg.cpf_tc_perf_counter_window_select {index = 0x6, always = 0x0, enable = 0x0}
rdna2.reg.cpg_latency_stats_select {index = 0x18, clear = 0x0, enable = 0x0}
rdna2.reg.cpg_perfcounter0_select {perf_sel = 0x1bf, perf_sel1 = 0x249, spm_mode = 0xd, cntr_mode1 = 0xe, cntr_mode0 = 0x5}
rdna2.reg.cpg_perfcounter0_select1 {perf_sel2 = 0x2e5, perf_sel3 = 0x1d6, cntr_mode3 = 0x1, cntr_mode2 = 0xc}
rdna2.reg.cpg_perfcounter1_select {perf_sel = 0x35a, perf_sel1 = 0x1bb, spm_mode = 0xf, cntr_mode1 = 0x3, cntr_mode0 = 0x7}
rdna2.reg.cpg_tc_perf_counter_window_select {index = 0x1a, always = 0x0, enable = 0x1}
rdna2.reg.cp_append_addr_hi {mem_addr_hi = 0x76a8, cs_ps_sel = 0x1, cache_policy = 0x2, command = 0x3}
rdna2.reg.cp_append_addr_lo {mem_addr_lo = 0x2f8230b}
rdna2.reg.cp_append_cmd_addr_hi {addr_hi = 0x681d, rsvd = 0xd8d9}
rdna2.reg.cp_append_cmd_addr_lo {rsvd = 0x1, addr_lo = 0x29226624}
rdna2.reg.cp_append_ddid_cnt {data = 0x80}
rdna2.reg.cp_ce_completion_status {status = 0x1}
rdna2.reg.cp_ce_db_base_hi {db_base_hi = 0xf279}
rdna2.reg.cp_ce_db_base_lo {db_base_lo = 0x3423925b}
rdna2.reg.cp_ce_db_bufsz {db_bufsz = 0xb9218}
rdna2.reg.cp_ce_db_cmd_bufsz {db_cmd_reqsz = 0x2c59a}
rdna2.reg.cp_ce_ib1_base_hi {ib1_base_hi = 0x271b}
rdna2.reg.cp_ce_ib1_base_lo {ib1_base_lo = 0x38f2021b}
rdna2.reg.cp_ce_ib1_bufsz {ib1_bufsz = 0x27216}
rdna2.reg.cp_ce_ib1_cmd_bufsz {ib1_cmd_reqsz = 0xdbe84}
rdna2.reg.cp_ce_ib1_offset {ib1_offset = 0x5f222}
rdna2.reg.cp_ce_ib2_base_hi {ib2_base_hi = 0x798f}
rdna2.reg.cp_ce_ib2_base_lo {ib2_base_lo = 0x33107e53}
rdna2.reg.cp_ce_ib2_bufsz {ib2_bufsz = 0x1cdc0}
rdna2.reg.cp_ce_ib2_cmd_bufsz {ib2_cmd_reqsz = 0xe42b2}
rdna2.reg.cp_ce_ib2_offset {ib2_offset = 0x72c80}
rdna2.reg.cp_ce_init_base_hi {init_base_hi = 0x6453}
rdna2.reg.cp_ce_init_base_lo {init_base_lo = 0xd8973d}
rdna2.reg.cp_ce_init_bufsz {init_bufsz = 0xe06}
rdna2.reg.cp_ce_init_cmd_bufsz {init_cmd_reqsz = 0x8c5}
rdna2.reg.cp_ce_metadata_base_addr_hi {addr_hi = 0x3692}
rdna2.reg.cp_coher_base_hi {coher_base_hi_256b = 0x24}
rdna2.reg.cp_coher_cntl {tc_nc_action_ena = 0x1, tc_wc_action_ena = 0x1, tc_inv_metadata_action_ena = 0x0, tcl1_vol_action_ena = 0x0, tc_wb_action_ena = 0x1, tcl1_action_ena = 0x0, tc_action_ena = 0x0, cb_action_ena = 0x1, db_action_ena = 0x0, sh_kcache_action_ena = 0x1, sh_kcache_vol_action_ena = 0x0, sh_icache_action_ena = 0x1, sh_kcache_wb_action_ena = 0x1}
rdna2.reg.cp_coher_size_hi {coher_size_hi_256b = 0x72}
rdna2.reg.cp_coher_start_delay {start_delay_count = 0x17}
rdna2.reg.cp_coher_status {meid = 0x2, status = 0x0}
rdna2.reg.cp_cpc_busy_stat {mec1_load_busy = 0x1, mec1_semapohre_busy = 0x1, mec1_mutex_busy = 0x0, mec1_message_busy = 0x1, mec1_eop_queue_busy = 0x1, mec1_iq_queue_busy = 0x1, mec1_ib_queue_busy = 0x0, mec1_tc_busy = 0x1, mec1_dma_busy = 0x0, mec1_partial_flush_busy = 0x0, mec1_pipe0_busy = 0x1, mec1_pipe1_busy = 0x1, mec1_pipe2_busy = 0x1, mec1_pipe3_busy = 0x0, mec2_load_busy = 0x1, mec2_semapohre_busy = 0x0, mec2_mutex_busy = 0x0, mec2_message_busy = 0x1, mec2_eop_queue_busy = 0x1, mec2_iq_queue_busy = 0x1, mec2_ib_queue_busy = 0x0, mec2_tc_busy = 0x1, mec2_dma_busy = 0x0, mec2_partial_flush_busy = 0x1, mec2_pipe0_busy = 0x1, mec2_pipe1_busy = 0x0, mec2_pipe2_busy = 0x0, mec2_pipe3_busy = 0x1}
rdna2.reg.cp_cpc_busy_stat2 {mes_load_busy = 0x1, mes_mutex_busy = 0x1, mes_message_busy = 0x1, mes_tc_busy = 0x0, mes_dma_busy = 0x0, mes_pipe0_busy = 0x1, mes_pipe1_busy = 0x1, mes_pipe2_busy = 0x0, mes_pipe3_busy = 0x1}
rdna2.reg.cp_cpc_grbm_free_count {free_count = 0x30}
rdna2.reg.cp_cpc_halt_hyst_count {count = 0x2}
rdna2.reg.cp_cpc_priv_violation_addr {priv_violation_addr = 0xafe0}
rdna2.reg.cp_cpc_scratch_index {scratch_index = 0x151, scratch_index_64bit_mode = 0x1}
rdna2.reg.cp_cpc_stalled_stat1 {rciu_tx_free_stall = 0x1, rciu_priv_violation = 0x0, tciu_tx_free_stall = 0x0, mec1_decoding_packet = 0x0, mec1_wait_on_rciu = 0x1, mec1_wait_on_rciu_read = 0x1, mec1_wait_on_roq_data = 0x0, mec2_decoding_packet = 0x0, mec2_wait_on_rciu = 0x0, mec2_wait_on_rciu_read = 0x1, mec2_wait_on_roq_data = 0x1, utcl2iu_waiting_on_free = 0x0, utcl2iu_waiting_on_tags = 0x1, utcl1_waiting_on_trans = 0x0, gcriu_waiting_on_free = 0x0}
rdna2.reg.cp_cpc_status {mec1_busy = 0x1, mec2_busy = 0x0, dc0_busy = 0x1, dc1_busy = 0x0, rciu1_busy = 0x0, rciu2_busy = 0x1, roq1_busy = 0x1, roq2_busy = 0x0, tciu_busy = 0x0, scratch_ram_busy = 0x0, qu_busy = 0x1, utcl2iu_busy = 0x1, save_restore_busy = 0x1, gcriu_busy = 0x0, mes_busy = 0x0, mes_scratch_ram_busy = 0x0, rciu3_busy = 0x1, mes_instruction_cache_busy = 0x0, cpg_cpc_busy = 0x0, cpf_cpc_busy = 0x1, cpc_busy = 0x0}
rdna2.reg.cp_cpf_busy_stat {reg_bus_fifo_busy = 0x0, csf_ring_busy = 0x0, csf_indirect1_busy = 0x1, csf_indirect2_busy = 0x1, csf_state_busy = 0x1, csf_ce_indr1_busy = 0x1, csf_ce_indr2_busy = 0x0, csf_arbiter_busy = 0x0, csf_input_busy = 0x1, csf_data_busy = 0x0, csf_ce_data_busy = 0x0, hpd_processing_eop_busy = 0x1, hqd_dispatch_busy = 0x0, hqd_iq_timer_busy = 0x0, hqd_dma_offload_busy = 0x0, hqd_wait_semaphore_busy = 0x0, hqd_signal_semaphore_busy = 0x1, hqd_message_busy = 0x0, hqd_pq_fetcher_busy = 0x0, hqd_ib_fetcher_busy = 0x1, hqd_iq_fetcher_busy = 0x1, hqd_eop_fetcher_busy = 0x0, hqd_consumed_rptr_busy = 0x1, hqd_fetcher_arb_busy = 0x0, hqd_roq_align_busy = 0x0, hqd_roq_eop_busy = 0x1, hqd_roq_iq_busy = 0x1, hqd_roq_pq_busy = 0x1, hqd_roq_ib_busy = 0x0, hqd_wptr_poll_busy = 0x1, hqd_pq_busy = 0x0, hqd_ib_busy = 0x1}
rdna2.reg.cp_cpf_busy_stat2 {mes_hqd_dispatch_busy = 0x1, mes_hqd_dma_offload_busy = 0x1, mes_hqd_message_busy = 0x0, mes_hqd_pq_fetcher_busy = 0x1, mes_hqd_consumed_rptr_busy = 0x1, mes_hqd_fetcher_arb_busy = 0x1, mes_hqd_roq_align_busy = 0x1, mes_hqd_roq_pq_busy = 0x0, mes_hqd_pq_busy = 0x1}
rdna2.reg.cp_cpf_grbm_free_count {free_count = 0x0}
rdna2.reg.cp_cpf_stalled_stat1 {ring_fetching_data = 0x0, indr1_fetching_data = 0x1, indr2_fetching_data = 0x0, state_fetching_data = 0x0, tciu_waiting_on_free = 0x0, tciu_waiting_on_tags = 0x0, utcl2iu_waiting_on_free = 0x1, utcl2iu_waiting_on_tags = 0x0, gfx_utcl1_waiting_on_trans = 0x0, cmp_utcl1_waiting_on_trans = 0x1, rciu_waiting_on_free = 0x0, data_fetching_data = 0x1, gcriu_wait_on_free = 0x0}
rdna2.reg.cp_cpf_status {post_wptr_gfx_busy = 0x0, csf_busy = 0x0, roq_align_busy = 0x0, roq_ring_busy = 0x1, roq_indirect1_busy = 0x1, roq_indirect2_busy = 0x1, roq_state_busy = 0x0, roq_ce_ring_busy = 0x1, roq_ce_indirect1_busy = 0x0, roq_ce_indirect2_busy = 0x0, semaphore_busy = 0x0, interrupt_busy = 0x0, tciu_busy = 0x1, hqd_busy = 0x1, prt_busy = 0x1, utcl2iu_busy = 0x1, rciu_busy = 0x1, rciu_gfx_busy = 0x1, rciu_cmp_busy = 0x1, roq_data_busy = 0x1, roq_ce_data_busy = 0x1, gcriu_busy = 0x1, mes_hqd_busy = 0x0, cpf_gfx_busy = 0x1, cpf_cmp_busy = 0x1, grbm_cpf_stat_busy = 0x0, cpc_cpf_busy = 0x1, cpf_busy = 0x1}
rdna2.reg.cp_db_base_hi {db_base_hi = 0x53fe}
rdna2.reg.cp_db_base_lo {db_base_lo = 0x2d15576}
rdna2.reg.cp_db_bufsz {db_bufsz = 0xafc63}
rdna2.reg.cp_db_cmd_bufsz {db_cmd_reqsz = 0x23b9a}
rdna2.reg.cp_dispatch_indr_addr_hi {addr_hi = 0xcfa8}
rdna2.reg.cp_dma_cntl {utcl1_fault_control = 0x0, watch_control = 0x1, min_availsz = 0x1, buffer_depth = 0x173, pio_fifo_empty = 0x1, pio_fifo_full = 0x1, pio_count = 0x3}
rdna2.reg.cp_dma_me_cmd_addr_hi {addr_hi = 0x8aba, rsvd = 0x4123}
rdna2.reg.cp_dma_me_cmd_addr_lo {rsvd = 0x3, addr_lo = 0x380d4813}
rdna2.reg.cp_dma_me_command {byte_count = 0x346708a, sas = 0x1, das = 0x1, saic = 0x1, daic = 0x1, raw_wait = 0x1, dis_wc = 0x0}
rdna2.reg.cp_dma_me_control {memlog_clear = 0x1, src_cache_policy = 0x1, src_volatle = 0x0, dst_select = 0x3, dst_cache_policy = 0x0, dst_volatle = 0x0, src_select = 0x1}
rdna2.reg.cp_dma_me_dst_addr_hi {dst_addr_hi = 0x98c4}
rdna2.reg.cp_dma_me_src_addr_hi {src_addr_hi = 0x3965}
rdna2.reg.cp_dma_pfp_cmd_addr_hi {addr_hi = 0x666d, rsvd = 0x5c62}
rdna2.reg.cp_dma_pfp_cmd_addr_lo {rsvd = 0x1, addr_lo = 0x4791caa}
rdna2.reg.cp_dma_pfp_command {byte_count = 0x1e37a1, sas = 0x1, das = 0x1, saic = 0x0, daic = 0x0, raw_wait = 0x0, dis_wc = 0x1}
rdna2.reg.cp_dma_pfp_control {memlog_clear = 0x0, src_cache_policy = 0x1, src_volatle = 0x0, dst_select = 0x3, dst_cache_policy = 0x0, dst_volatle = 0x0, src_select = 0x2}
rdna2.reg.cp_dma_pfp_dst_addr_hi {dst_addr_hi = 0x2c6a}
rdna2.reg.cp_dma_pfp_src_addr_hi {src_addr_hi = 0x4e8f}
rdna2.reg.cp_dma_read_tags {dma_read_tag = 0x7dd3a1, dma_read_tag_valid = 0x1}
rdna2.reg.cp_draw_indx_indr_addr_hi {addr_hi = 0x3054}
rdna2.reg.cp_draw_object_counter {count = 0x5714}
rdna2.reg.cp_draw_window_cntl {disable_draw_window_lo_max = 0x1, disable_draw_window_lo_min = 0x0, disable_draw_window_hi = 0x1, mode = 0x1}
rdna2.reg.cp_draw_window_lo {min = 0xce50, max = 0x751e}
rdna2.reg.cp_eop_done_addr_hi {addr_hi = 0x21e2}
rdna2.reg.cp_eop_done_addr_lo {addr_lo = 0x3a6bd56f}
rdna2.reg.cp_eop_done_data_cntl {dst_sel = 0x0, action_pipe_id = 0x2, action_id = 0x0, int_sel = 0x5, data_sel = 0x5}
rdna2.reg.cp_eop_done_event_cntl {gcr_cntl = 0xbba, cache_policy = 0x3, eop_volatile = 0x1, execute = 0x1}
rdna2.reg.cp_gds_bkup_addr_hi {addr_hi = 0x5056}
rdna2.reg.cp_ib1_base_hi {ib1_base_hi = 0xaf95}
rdna2.reg.cp_ib1_base_lo {ib1_base_lo = 0x2b954fbb}
rdna2.reg.cp_ib1_bufsz {ib1_bufsz = 0x20ae}
rdna2.reg.cp_ib2_base_hi {ib2_base_hi = 0x94a}
rdna2.reg.cp_ib2_base_lo {ib2_base_lo = 0xefc5fdf}
rdna2.reg.cp_ib2_bufsz {ib2_bufsz = 0x3f543}
rdna2.reg.cp_ib2_cmd_bufsz {ib2_cmd_reqsz = 0x2c295}
rdna2.reg.cp_ib2_offset {ib2_offset = 0xce06e}
rdna2.reg.cp_ib2_preamble_begin {ib2_preamble_begin = 0x90f30}
rdna2.reg.cp_ib2_preamble_end {ib2_preamble_end = 0xd8302}
rdna2.reg.cp_index_base_addr_hi {addr_hi = 0xe2db}
rdna2.reg.cp_index_type {index_type = 0x0}
rdna2.reg.cp_me_coher_base_hi {coher_base_hi_256b = 0xb2}
rdna2.reg.cp_me_coher_cntl {dest_base_0_ena = 0x1, dest_base_1_ena = 0x1, cb0_dest_base_ena = 0x0, cb1_dest_base_ena = 0x0, cb2_dest_base_ena = 0x0, cb3_dest_base_ena = 0x1, cb4_dest_base_ena = 0x1, cb5_dest_base_ena = 0x1, cb6_dest_base_ena = 0x1, cb7_dest_base_ena = 0x1, db_dest_base_ena = 0x0, dest_base_2_ena = 0x1, dest_base_3_ena = 0x1}
rdna2.reg.cp_me_coher_size_hi {coher_size_hi_256b = 0xbc}
rdna2.reg.cp_me_coher_status {matching_gfx_cntx = 0x10, status = 0x1}
rdna2.reg.cp_me_mc_raddr_hi {me_mc_raddr_hi = 0xb4d5, cache_policy = 0x3}
rdna2.reg.cp_me_mc_raddr_lo {me_mc_raddr_lo = 0x2e82c045}
rdna2.reg.cp_me_mc_waddr_hi {me_mc_waddr_hi = 0xfd48, cache_policy = 0x2}
rdna2.reg.cp_me_mc_waddr_lo {me_mc_waddr_lo = 0x774fc5d}
rdna2.reg.cp_perfmon_cntl {perfmon_state = 0x7, spm_perfmon_state = 0x9, perfmon_enable_mode = 0x1, perfmon_sample_enable = 0x0}
rdna2.reg.cp_perfmon_cntx_cntl {perfmon_enable = 0x0}
rdna2.reg.cp_pfp_completion_status {status = 0x0}
rdna2.reg.cp_pfp_ib_control {ib_en = 0xc2}
rdna2.reg.cp_pfp_load_control {config_reg_en = 0x1, cntx_reg_en = 0x1, uconfig_reg_en = 0x1, sh_gfx_reg_en = 0x0, sh_cs_reg_en = 0x1}
rdna2.reg.cp_pfp_metadata_base_addr_hi {addr_hi = 0xb1be}
rdna2.reg.cp_pipeid {pipe_id = 0x1}
rdna2.reg.cp_pipe_stats_addr_hi {pipe_stats_addr_hi = 0xba97}
rdna2.reg.cp_pipe_stats_addr_lo {pipe_stats_addr_lo = 0x1048882}
rdna2.reg.cp_pipe_stats_control {cache_policy = 0x3}
rdna2.reg.cp_pred_not_visible {not_visible = 0x0}
rdna2.reg.cp_rb_offset {rb_offset = 0x79cc8}
rdna2.reg.cp_sample_status {z_pass_acitve = 0x1, streamout_active = 0x1, pipeline_active = 0x0, stipple_active = 0x1, vgt_buffers_active = 0x1, screen_ext_active = 0x1, draw_indirect_active = 0x1, disp_indirect_active = 0x0}
rdna2.reg.cp_scratch_index {scratch_index = 0x29, scratch_index_64bit_mode = 0x0}
rdna2.reg.cp_sig_sem_addr_hi {sem_addr_hi = 0x6d, sem_use_mailbox = 0x1, sem_signal_type = 0x0, sem_client_code = 0x1, sem_select = 0x3}
rdna2.reg.cp_sig_sem_addr_lo {sem_priv = 0x0, sem_addr_lo = 0x13c04b8}
rdna2.reg.cp_stream_out_addr_hi {stream_out_addr_hi = 0xae25}
rdna2.reg.cp_stream_out_addr_lo {stream_out_addr_lo = 0x3e60350c}
rdna2.reg.cp_stream_out_control {cache_policy = 0x3}
rdna2.reg.cp_strmout_cntl {offset_update_done = 0x1}
rdna2.reg.cp_st_base_hi {st_base_hi = 0xdd6d}
rdna2.reg.cp_st_base_lo {st_base_lo = 0x15dfec7e}
rdna2.reg.cp_st_bufsz {st_bufsz = 0xfbc5d}
rdna2.reg.cp_st_cmd_bufsz {st_cmd_reqsz = 0x651f6}
rdna2.reg.cp_vmid {vmid = 0x1}
rdna2.reg.cp_wait_sem_addr_hi {sem_addr_hi = 0x7495, sem_use_mailbox = 0x1, sem_signal_type = 0x0, sem_client_code = 0x1, sem_select = 0x6}
rdna2.reg.cp_wait_sem_addr_lo {sem_priv = 0x0, sem_addr_lo = 0x938f9d7}
rdna2.reg.cs_copy_state {src_state_id = 0x2}
rdna2.reg.db_alpha_to_mask {alpha_to_mask_enable = 0x0, alpha_to_mask_offset0 = 0x0, alpha_to_mask_offset1 = 0x1, alpha_to_mask_offset2 = 0x0, alpha_to_mask_offset3 = 0x3, offset_round = 0x0}
rdna2.reg.db_count_control {zpass_increment_disable = 0x0, perfect_zpass_counts = 0x1, disable_conservative_zpass_counts = 0x1, enhanced_conservative_zpass_counts = 0x0, sample_rate = 0x5, zpass_enable = 0xc, zfail_enable = 0xf, sfail_enable = 0x0, dbfail_enable = 0xf, slice_even_enable = 0x3, slice_odd_enable = 0x2}
rdna2.reg.db_depth_control {stencil_enable = 0x0, z_enable = 0x1, z_write_enable = 0x0, depth_bounds_enable = 0x0, zfunc = 0x0, backface_enable = 0x0, stencilfunc = 0x4, stencilfunc_bf = 0x3, enable_color_writes_on_depth_fail = 0x0, disable_color_writes_on_depth_pass = 0x1}
rdna2.reg.db_depth_size_xy {x_max = 0x780, y_max = 0x160}
rdna2.reg.db_depth_view {slice_start = 0x2, slice_start_hi = 0x2, slice_max = 0x6a9, z_read_only = 0x1, stencil_read_only = 0x0, mipid = 0xa, slice_max_hi = 0x1}
rdna2.reg.db_dfsm_control {punchout_mode = 0x2, pops_drain_ps_on_overlap = 0x1, disallow_overflow = 0x1}
rdna2.reg.db_eqaa {max_anchor_samples = 0x1, ps_iter_samples = 0x6, mask_export_num_samples = 0x2, alpha_to_mask_num_samples = 0x4, high_quality_intersections = 0x1, incoherent_eqaa_reads = 0x1, interpolate_comp_z = 0x1, interpolate_src_z = 0x0, static_anchor_associations = 0x0, alpha_to_mask_eqaa_disable = 0x0, overrasterization_amount = 0x4, enable_postz_overrasterization = 0x1}
rdna2.reg.db_htile_data_base_hi {base_hi = 0xd5}
rdna2.reg.db_htile_surface {reserved_field_1 = 0x1, full_cache = 0x1, reserved_field_2 = 0x1, reserved_field_3 = 0x0, reserved_field_4 = 0x29, reserved_field_5 = 0xd, dst_outside_zero_to_one = 0x0, reserved_field_6 = 0x1, pipe_aligned = 0x0, vrs_htile_encoding = 0x1}
rdna2.reg.db_occlusion_count0_hi {count_hi = 0x73de463a}
rdna2.reg.db_occlusion_count1_hi {count_hi = 0x191e72e2}
rdna2.reg.db_occlusion_count2_hi {count_hi = 0x7b7f1854}
rdna2.reg.db_occlusion_count3_hi {count_hi = 0x2337b00e}
rdna2.reg.db_perfcounter0_select {perf_sel = 0x33e, perf_sel1 = 0x263, cntr_mode = 0xc, perf_mode1 = 0xd, perf_mode = 0x6}
rdna2.reg.db_perfcounter0_select1 {perf_sel2 = 0x2a3, perf_sel3 = 0x222, perf_mode3 = 0x9, perf_mode2 = 0xb}
rdna2.reg.db_perfcounter1_select {perf_sel = 0x167, perf_sel1 = 0x38b, cntr_mode = 0x3, perf_mode1 = 0x8, perf_mode = 0xa}
rdna2.reg.db_perfcounter1_select1 {perf_sel2 = 0x1a1, perf_sel3 = 0x16e, perf_mode3 = 0x8, perf_mode2 = 0x4}
rdna2.reg.db_perfcounter2_select {perf_sel = 0x120, perf_sel1 = 0x2f8, cntr_mode = 0x4, perf_mode1 = 0xe, perf_mode = 0x8}
rdna2.reg.db_perfcounter3_select {perf_sel = 0x363, perf_sel1 = 0x152, cntr_mode = 0x1, perf_mode1 = 0xe, perf_mode = 0xc}
rdna2.reg.db_preload_control {start_x = 0x7e, start_y = 0x8a, max_x = 0x17, max_y = 0x11}
rdna2.reg.db_render_control {depth_clear_enable = 0x1, stencil_clear_enable = 0x1, depth_copy = 0x0, stencil_copy = 0x1, resummarize_enable = 0x1, stencil_compress_disable = 0x0, depth_compress_disable = 0x1, copy_centroid = 0x0, copy_sample = 0xf, decompress_enable = 0x1, ps_invoke_disable = 0x0}
rdna2.reg.db_render_override {force_hiz_enable = 0x1, force_his_enable0 = 0x2, force_his_enable1 = 0x3, force_shader_z_order = 0x1, fast_z_disable = 0x1, fast_stencil_disable = 0x1, noop_cull_disable = 0x0, force_color_kill = 0x1, force_z_read = 0x1, force_stencil_read = 0x0, force_full_z_range = 0x1, force_qc_smask_conflict = 0x0, disable_viewport_clamp = 0x0, ignore_sc_zrange = 0x1, disable_fully_covered = 0x1, force_z_limit_summ = 0x2, max_tiles_in_dtt = 0x19, disable_tile_rate_tiles = 0x0, force_z_dirty = 0x1, force_stencil_dirty = 0x1, force_z_valid = 0x0, force_stencil_valid = 0x0, preserve_compression = 0x1}
rdna2.reg.db_render_override2 {partial_squad_launch_control = 0x3, partial_squad_launch_countdown = 0x7, disable_zmask_expclear_optimization = 0x1, disable_smem_expclear_optimization = 0x1, disable_color_on_validation = 0x0, decompress_z_on_flush = 0x0, disable_reg_snoop = 0x0, depth_bounds_hier_depth_disable = 0x1, separate_hizs_func_enable = 0x0, hiz_zfunc = 0x0, his_sfunc_ff = 0x0, his_sfunc_bf = 0x7, preserve_zrange = 0x0, preserve_sresults = 0x1, disable_fast_pass = 0x0, allow_partial_res_hier_kill = 0x1, force_vrs_rate_fine = 0x1, centroid_computation_mode = 0x3}
rdna2.reg.db_reserved_reg_1 {field_1 = 0x2a3, field_2 = 0x212}
rdna2.reg.db_reserved_reg_2 {field_1 = 0x4, field_2 = 0x3, field_3 = 0x1d, field_4 = 0x0, field_5 = 0x0, field_6 = 0x2, field_7 = 0x3, resource_level = 0x0}
rdna2.reg.db_reserved_reg_3 {field_1 = 0x3bf09f}
rdna2.reg.db_rmi_l2_cache_control {z_wr_policy = 0x0, s_wr_policy = 0x0, htile_wr_policy = 0x2, zpcpsd_wr_policy = 0x0, z_rd_policy = 0x1, s_rd_policy = 0x2, htile_rd_policy = 0x3, z_big_page = 0x0, s_big_page = 0x0, z_noalloc = 0x1, s_noalloc = 0x1, htile_noalloc = 0x0, zpcpsd_noalloc = 0x0}
rdna2.reg.db_shader_control {z_export_enable = 0x0, stencil_test_val_export_enable = 0x1, stencil_op_val_export_enable = 0x1, z_order = 0x3, kill_enable = 0x1, coverage_to_mask_enable = 0x1, mask_export_enable = 0x1, exec_on_hier_fail = 0x0, exec_on_noop = 0x1, alpha_to_mask_disable = 0x1, depth_before_shader = 0x0, conservative_z_export = 0x2, dual_quad_disable = 0x0, primitive_ordered_pixel_shader = 0x0, exec_if_overlapped = 0x1, pops_overlap_num_samples = 0x3, pre_shader_depth_coverage_enable = 0x1}
rdna2.reg.db_sresults_compare_state0 {comparefunc0 = 0x5, comparevalue0 = 0xa0, comparemask0 = 0xb8, enable0 = 0x0}
rdna2.reg.db_sresults_compare_state1 {comparefunc1 = 0x3, comparevalue1 = 0xe4, comparemask1 = 0x15, enable1 = 0x0}
rdna2.reg.db_stencilrefmask {stenciltestval = 0x61, stencilmask = 0x26, stencilwritemask = 0x52, stencilopval = 0xb1}
rdna2.reg.db_stencilrefmask_bf {stenciltestval_bf = 0x59, stencilmask_bf = 0x39, stencilwritemask_bf = 0xf3, stencilopval_bf = 0x2f}
rdna2.reg.db_stencil_clear {clear = 0x9d}
rdna2.reg.db_stencil_control {stencilfail = 0x5, stencilzpass = 0xa, stencilzfail = 0xb, stencilfail_bf = 0x0, stencilzpass_bf = 0x2, stencilzfail_bf = 0x5}
rdna2.reg.db_stencil_info {format = 0x1, sw_mode = 0x18, fault_behavior = 0x2, iterate_flush = 0x0, partially_resident = 0x1, reserved_field_1 = 0x0, iterate_256 = 0x1, allow_expclear = 0x0, tile_stencil_disable = 0x1}
rdna2.reg.db_stencil_read_base_hi {base_hi = 0x23}
rdna2.reg.db_stencil_write_base_hi {base_hi = 0xe8}
rdna2.reg.db_vrs_override_cntl {vrs_override_rate_combiner_mode = 0x4, vrs_override_rate_x = 0x2, vrs_override_rate_y = 0x1}
rdna2.reg.db_zpass_count_hi {count_hi = 0x329ed7e7}
rdna2.reg.db_z_info {format = 0x3, num_samples = 0x1, sw_mode = 0x18, fault_behavior = 0x1, iterate_flush = 0x0, partially_resident = 0x0, reserved_field_1 = 0x7, maxmip = 0x6, iterate_256 = 0x1, decompress_on_n_zplanes = 0x7, allow_expclear = 0x1, read_size = 0x0, tile_surface_enable = 0x1, zrange_precision = 0x0}
rdna2.reg.db_z_read_base_hi {base_hi = 0xe5}
rdna2.reg.db_z_write_base_hi {base_hi = 0x68}
rdna2.reg.gb_addr_config {num_pipes = 0x7, pipe_interleave_size = 0x2, max_compressed_frags = 0x1, num_pkrs = 0x5, num_shader_engines = 0x3, num_rb_per_se = 0x3}
rdna2.reg.gcea_perfcounter0_cfg {perf_sel = 0x45, perf_sel_end = 0x47, perf_mode = 0xa, enable = 0x0, clear = 0x0}
rdna2.reg.gcea_perfcounter1_cfg {perf_sel = 0xce, perf_sel_end = 0xfe, perf_mode = 0x3, enable = 0x1, clear = 0x0}
rdna2.reg.gcea_perfcounter2_mode {compare_mode0 = 0x0, compare_mode1 = 0x0, compare_mode2 = 0x3, compare_mode3 = 0x1, compare_value0 = 0xa, compare_value1 = 0xd, compare_value2 = 0x6, compare_value3 = 0xd}
rdna2.reg.gcea_perfcounter2_select {perf_sel = 0x1fa, perf_sel1 = 0x246, cntr_mode = 0xf, perf_mode1 = 0x9, perf_mode = 0xe}
rdna2.reg.gcea_perfcounter2_select1 {perf_sel2 = 0x3f9, perf_sel3 = 0x81, perf_mode3 = 0xa, perf_mode2 = 0x3}
rdna2.reg.gcea_perfcounter_hi {counter_hi = 0x135c, compare_value = 0x2d0c}
rdna2.reg.gcea_perfcounter_rslt_cntl {perf_counter_select = 0xa, start_trigger = 0x8, stop_trigger = 0x91, enable_any = 0x0, clear_all = 0x1, stop_all_on_saturate = 0x1}
rdna2.reg.gcmc_vm_l2_perfcounter0_cfg {perf_sel = 0xaf, perf_sel_end = 0xa6, perf_mode = 0x0, enable = 0x1, clear = 0x0}
rdna2.reg.gcmc_vm_l2_perfcounter1_cfg {perf_sel = 0xd5, perf_sel_end = 0xcf, perf_mode = 0xb, enable = 0x1, clear = 0x1}
rdna2.reg.gcmc_vm_l2_perfcounter2_cfg {perf_sel = 0xb3, perf_sel_end = 0x5, perf_mode = 0xe, enable = 0x1, clear = 0x1}
rdna2.reg.gcmc_vm_l2_perfcounter3_cfg {perf_sel = 0x71, perf_sel_end = 0x8a, perf_mode = 0xc, enable = 0x1, clear = 0x1}
rdna2.reg.gcmc_vm_l2_perfcounter4_cfg {perf_sel = 0x67, perf_sel_end = 0xc4, perf_mode = 0x5, enable = 0x1, clear = 0x0}
rdna2.reg.gcmc_vm_l2_perfcounter5_cfg {perf_sel = 0x27, perf_sel_end = 0x96, perf_mode = 0x8, enable = 0x1, clear = 0x0}
rdna2.reg.gcmc_vm_l2_perfcounter6_cfg {perf_sel = 0xc3, perf_sel_end = 0xe0, perf_mode = 0x1, enable = 0x1, clear = 0x1}
rdna2.reg.gcmc_vm_l2_perfcounter7_cfg {perf_sel = 0x4d, perf_sel_end = 0x1, perf_mode = 0x5, enable = 0x0, clear = 0x0}
rdna2.reg.gcmc_vm_l2_perfcounter_hi {counter_hi = 0xd71b, compare_value = 0x1e74}
rdna2.reg.gcmc_vm_l2_perfcounter_rslt_cntl {perf_counter_select = 0xa, start_trigger = 0x8a, stop_trigger = 0x14, enable_any = 0x1, clear_all = 0x1, stop_all_on_saturate = 0x0}
rdna2.reg.gcr_perfcounter0_select {perf_sel = 0x1d7, perf_sel1 = 0xdc, cntr_mode = 0x5, perf_mode1 = 0xd, perf_mode = 0x2}
rdna2.reg.gcr_perfcounter0_select1 {perf_sel2 = 0x165, perf_sel3 = 0x2a, perf_mode3 = 0x2, perf_mode2 = 0x3}
rdna2.reg.gcr_perfcounter1_select {perf_sel = 0x73, perf_mode = 0xd, cntl_mode = 0xe}
rdna2.reg.gcutcl2_perfcounter0_cfg {perf_sel = 0x5a, perf_sel_end = 0xa3, perf_mode = 0xe, enable = 0x0, clear = 0x1}
rdna2.reg.gcutcl2_perfcounter1_cfg {perf_sel = 0x78, perf_sel_end = 0x9c, perf_mode = 0x5, enable = 0x1, clear = 0x1}
rdna2.reg.gcutcl2_perfcounter2_cfg {perf_sel = 0xd3, perf_sel_end = 0xdb, perf_mode = 0x1, enable = 0x1, clear = 0x1}
rdna2.reg.gcutcl2_perfcounter3_cfg {perf_sel = 0x4d, perf_sel_end = 0x74, perf_mode = 0x3, enable = 0x1, clear = 0x0}
rdna2.reg.gcutcl2_perfcounter_hi {counter_hi = 0x95a8, compare_value = 0x4546}
rdna2.reg.gcutcl2_perfcounter_rslt_cntl {perf_counter_select = 0x6, start_trigger = 0xa6, stop_trigger = 0x7e, enable_any = 0x1, clear_all = 0x0, stop_all_on_saturate = 0x1}
rdna2.reg.gcvml2_perfcounter2_0_mode {compare_mode0 = 0x2, compare_mode1 = 0x2, compare_mode2 = 0x1, compare_mode3 = 0x0, compare_value0 = 0x8, compare_value1 = 0x2, compare_value2 = 0x1, compare_value3 = 0x2}
rdna2.reg.gcvml2_perfcounter2_0_select {perf_sel = 0x214, perf_sel1 = 0x2d7, cntr_mode = 0x4, perf_mode1 = 0xa, perf_mode = 0xc}
rdna2.reg.gcvml2_perfcounter2_0_select1 {perf_sel2 = 0x17f, perf_sel3 = 0x3ed, perf_mode3 = 0xd, perf_mode2 = 0x0}
rdna2.reg.gcvml2_perfcounter2_1_mode {compare_mode0 = 0x1, compare_mode1 = 0x2, compare_mode2 = 0x3, compare_mode3 = 0x0, compare_value0 = 0xe, compare_value1 = 0x9, compare_value2 = 0x2, compare_value3 = 0xe}
rdna2.reg.gcvml2_perfcounter2_1_select {perf_sel = 0x2b5, perf_sel1 = 0x3bf, cntr_mode = 0xa, perf_mode1 = 0xf, perf_mode = 0x4}
rdna2.reg.gcvml2_perfcounter2_1_select1 {perf_sel2 = 0x253, perf_sel3 = 0x107, perf_mode3 = 0x2, perf_mode2 = 0x1}
rdna2.reg.gcvm_l2_protection_fault_status {more_faults = 0x0, walker_error = 0x3, permission_faults = 0xe, mapping_error = 0x1, cid = 0xb7, rw = 0x0, atomic = 0x1, vmid = 0xc, vf = 0x1, vfid = 0xb}
rdna2.reg.gds_atom_base {base = 0xce1, unused = 0xae9a}
rdna2.reg.gds_atom_cntl {ainc = 0x23, unused1 = 0x1, dmode = 0x0, unused2 = 0x26fab7}
rdna2.reg.gds_atom_complete {complete = 0x1, unused = 0x52afa73d}
rdna2.reg.gds_atom_offset0 {offset0 = 0x44, unused = 0x7dfb32}
rdna2.reg.gds_atom_offset1 {offset1 = 0xc9, unused = 0x483bcd}
rdna2.reg.gds_atom_op {op = 0xf, unused = 0x16165d}
rdna2.reg.gds_atom_size {size = 0xaa63, unused = 0x2a63}
rdna2.reg.gds_gws_resource {flag = 0x0, counter = 0x956, type = 0x1, ded = 0x1, release_all = 0x0, head_queue = 0x81, head_valid = 0x1, head_flag = 0x1, halted = 0x0, head_queue1 = 0x0, unused1 = 0x0}
rdna2.reg.gds_gws_resource_cnt {resource_cnt = 0x253c, unused = 0x3467}
rdna2.reg.gds_gws_resource_cntl {index = 0x38, unused = 0x15d5247}
rdna2.reg.gds_oa_address {ds_address = 0x6b3e, crawler_type = 0xf, crawler = 0x6, unused = 0x1c, no_alloc = 0x1, enable = 0x0}
rdna2.reg.gds_oa_cntl {index = 0x7, unused = 0xf566d00}
rdna2.reg.gds_oa_incdec {value = 0x2959c328, incdec = 0x0}
rdna2.reg.gds_perfcounter0_select {perf_sel = 0x3d6, perf_sel1 = 0x1f0, cntr_mode = 0xa, perf_mode1 = 0x8, perf_mode = 0x7}
rdna2.reg.gds_perfcounter0_select1 {perf_sel2 = 0x34f, perf_sel3 = 0x1bf, perf_mode3 = 0xb, perf_mode2 = 0x9}
rdna2.reg.gds_perfcounter1_select {perf_sel = 0x286, perf_sel1 = 0x347, cntr_mode = 0xd, perf_mode1 = 0x6, perf_mode = 0xc}
rdna2.reg.gds_perfcounter1_select1 {perf_sel2 = 0xeb, perf_sel3 = 0x25f, perf_mode3 = 0x1, perf_mode2 = 0x7}
rdna2.reg.gds_perfcounter2_select {perf_sel = 0x396, perf_sel1 = 0x196, cntr_mode = 0xf, perf_mode1 = 0x1, perf_mode = 0xc}
rdna2.reg.gds_perfcounter2_select1 {perf_sel2 = 0x1ad, perf_sel3 = 0x25f, perf_mode3 = 0x6, perf_mode2 = 0xa}
rdna2.reg.gds_perfcounter3_select {perf_sel = 0x134, perf_sel1 = 0x296, cntr_mode = 0x4, perf_mode1 = 0x0, perf_mode = 0xb}
rdna2.reg.gds_perfcounter3_select1 {perf_sel2 = 0x13f, perf_sel3 = 0x171, perf_mode3 = 0x5, perf_mode2 = 0xd}
rdna2.reg.ge1_perfcounter0_select {perf_sel0 = 0xc6, perf_sel1 = 0x28d, cntr_mode = 0x8, perf_mode0 = 0x8, perf_mode1 = 0xe}
rdna2.reg.ge1_perfcounter0_select1 {perf_sel2 = 0x199, perf_sel3 = 0x315, perf_mode2 = 0x6, perf_mode3 = 0x5}
rdna2.reg.ge1_perfcounter1_select {perf_sel0 = 0x290, perf_sel1 = 0x1c8, cntr_mode = 0x8, perf_mode0 = 0xe, perf_mode1 = 0x9}
rdna2.reg.ge1_perfcounter1_select1 {perf_sel2 = 0x243, perf_sel3 = 0x300, perf_mode2 = 0x4, perf_mode3 = 0x4}
rdna2.reg.ge1_perfcounter2_select {perf_sel0 = 0x27b, perf_sel1 = 0x22b, cntr_mode = 0x2, perf_mode0 = 0x3, perf_mode1 = 0xc}
rdna2.reg.ge1_perfcounter2_select1 {perf_sel2 = 0x247, perf_sel3 = 0x189, perf_mode2 = 0xb, perf_mode3 = 0x5}
rdna2.reg.ge1_perfcounter3_select {perf_sel0 = 0xef, perf_sel1 = 0x338, cntr_mode = 0xd, perf_mode0 = 0x2, perf_mode1 = 0x0}
rdna2.reg.ge1_perfcounter3_select1 {perf_sel2 = 0x1ec, perf_sel3 = 0x12d, perf_mode2 = 0x2, perf_mode3 = 0x8}
rdna2.reg.ge2_dist_perfcounter0_select {perf_sel0 = 0x178, perf_sel1 = 0x62, cntr_mode = 0x5, perf_mode0 = 0x7, perf_mode1 = 0xf}
rdna2.reg.ge2_dist_perfcounter0_select1 {perf_sel2 = 0x1e5, perf_sel3 = 0x304, perf_mode2 = 0x4, perf_mode3 = 0x3}
rdna2.reg.ge2_dist_perfcounter1_select {perf_sel0 = 0x2a4, perf_sel1 = 0x8f, cntr_mode = 0xb, perf_mode0 = 0x2, perf_mode1 = 0x5}
rdna2.reg.ge2_dist_perfcounter1_select1 {perf_sel2 = 0x1c5, perf_sel3 = 0x112, perf_mode2 = 0xa, perf_mode3 = 0xc}
rdna2.reg.ge2_dist_perfcounter2_select {perf_sel0 = 0x3a1, perf_sel1 = 0x302, cntr_mode = 0x7, perf_mode0 = 0x7, perf_mode1 = 0x2}
rdna2.reg.ge2_dist_perfcounter2_select1 {perf_sel2 = 0x219, perf_sel3 = 0x51, perf_mode2 = 0x8, perf_mode3 = 0x9}
rdna2.reg.ge2_dist_perfcounter3_select {perf_sel0 = 0x360, perf_sel1 = 0x2cb, cntr_mode = 0xf, perf_mode0 = 0xd, perf_mode1 = 0x4}
rdna2.reg.ge2_dist_perfcounter3_select1 {perf_sel2 = 0x93, perf_sel3 = 0x28f, perf_mode2 = 0x1, perf_mode3 = 0x2}
rdna2.reg.ge2_se_perfcounter0_select {perf_sel0 = 0x6d, perf_sel1 = 0x28d, cntr_mode = 0x8, perf_mode0 = 0x8, perf_mode1 = 0xc}
rdna2.reg.ge2_se_perfcounter0_select1 {perf_sel2 = 0x1c, perf_sel3 = 0x162, perf_mode2 = 0xd, perf_mode3 = 0x3}
rdna2.reg.ge2_se_perfcounter1_select {perf_sel0 = 0x2d5, perf_sel1 = 0x88, cntr_mode = 0x3, perf_mode0 = 0x7, perf_mode1 = 0xf}
rdna2.reg.ge2_se_perfcounter1_select1 {perf_sel2 = 0x117, perf_sel3 = 0x3f, perf_mode2 = 0xa, perf_mode3 = 0x3}
rdna2.reg.ge2_se_perfcounter2_select {perf_sel0 = 0x1dc, perf_sel1 = 0x1d6, cntr_mode = 0xa, perf_mode0 = 0x5, perf_mode1 = 0x2}
rdna2.reg.ge2_se_perfcounter2_select1 {perf_sel2 = 0xd9, perf_sel3 = 0x241, perf_mode2 = 0xc, perf_mode3 = 0x8}
rdna2.reg.ge2_se_perfcounter3_select {perf_sel0 = 0x332, perf_sel1 = 0x2b4, cntr_mode = 0x9, perf_mode0 = 0x4, perf_mode1 = 0x6}
rdna2.reg.ge2_se_perfcounter3_select1 {perf_sel2 = 0x9a, perf_sel3 = 0x36d, perf_mode2 = 0x3, perf_mode3 = 0x6}
rdna2.reg.ge_cntl {prim_grp_size = 0x145, vert_grp_size = 0x64, break_wave_at_eoi = 0x1, packet_to_one_pa = 0x0}
rdna2.reg.ge_max_output_per_subgroup {max_verts_per_subgroup = 0x22e}
rdna2.reg.ge_multi_prim_ib_reset_en {reset_en = 0x1, match_all_bits = 0x1}
rdna2.reg.ge_ngg_subgrp_cntl {prim_amp_factor = 0x19c, thds_per_subgrp = 0x103}
rdna2.reg.ge_pc_alloc {oversub_en = 0x0, num_pc_lines = 0x3bd}
rdna2.reg.ge_stereo_cntl {rt_slice = 0x7, viewport = 0x5, en_stereo = 0x1}
rdna2.reg.ge_user_vgpr_en {en_user_vgpr1 = 0x0, en_user_vgpr2 = 0x1, en_user_vgpr3 = 0x0}
rdna2.reg.gfx_copy_state {src_state_id = 0x6}
rdna2.reg.gl1a_perfcounter0_select {perf_sel = 0x12a, perf_sel1 = 0x386, cntr_mode = 0x3, perf_mode1 = 0x2, perf_mode = 0x5}
rdna2.reg.gl1a_perfcounter0_select1 {perf_sel2 = 0x24e, perf_sel3 = 0x2cf, perf_mode2 = 0xc, perf_mode3 = 0xf}
rdna2.reg.gl1a_perfcounter1_select {perf_sel = 0x254, cntr_mode = 0x0, perf_mode = 0x1}
rdna2.reg.gl1a_perfcounter2_select {perf_sel = 0x98, cntr_mode = 0x6, perf_mode = 0x3}
rdna2.reg.gl1a_perfcounter3_select {perf_sel = 0x71, cntr_mode = 0xb, perf_mode = 0xc}
rdna2.reg.gl1c_perfcounter0_select {perf_sel = 0x12e, perf_sel1 = 0x16d, cntr_mode = 0x4, perf_mode1 = 0x8, perf_mode = 0x8}
rdna2.reg.gl1c_perfcounter0_select1 {perf_sel2 = 0xd9, perf_sel3 = 0xb8, perf_mode2 = 0x5, perf_mode3 = 0x8}
rdna2.reg.gl1c_perfcounter1_select {perf_sel = 0x3a6, cntr_mode = 0x0, perf_mode = 0xd}
rdna2.reg.gl1c_perfcounter2_select {perf_sel = 0x11c, cntr_mode = 0xf, perf_mode = 0xd}
rdna2.reg.gl1c_perfcounter3_select {perf_sel = 0x178, cntr_mode = 0x8, perf_mode = 0xc}
rdna2.reg.gl2a_perfcounter0_select {perf_sel = 0x28a, perf_sel1 = 0x371, cntr_mode = 0x4, perf_mode1 = 0x6, perf_mode = 0x2}
rdna2.reg.gl2a_perfcounter0_select1 {perf_sel2 = 0x1a0, perf_sel3 = 0x34e, perf_mode2 = 0xa, perf_mode3 = 0x7}
rdna2.reg.gl2a_perfcounter1_select {perf_sel = 0x376, perf_sel1 = 0x150, cntr_mode = 0x3, perf_mode1 = 0x9, perf_mode = 0x8}
rdna2.reg.gl2a_perfcounter1_select1 {perf_sel2 = 0x31f, perf_sel3 = 0xed, perf_mode2 = 0xb, perf_mode3 = 0x4}
rdna2.reg.gl2a_perfcounter2_select {perf_sel = 0xf6, cntr_mode = 0xb, perf_mode = 0xe}
rdna2.reg.gl2a_perfcounter3_select {perf_sel = 0xa0, cntr_mode = 0x6, perf_mode = 0x2}
rdna2.reg.gl2c_perfcounter0_select {perf_sel = 0x155, perf_sel1 = 0x306, cntr_mode = 0x1, perf_mode1 = 0x9, perf_mode = 0xf}
rdna2.reg.gl2c_perfcounter0_select1 {perf_sel2 = 0x285, perf_sel3 = 0x234, perf_mode2 = 0xc, perf_mode3 = 0x8}
rdna2.reg.gl2c_perfcounter1_select {perf_sel = 0x264, perf_sel1 = 0x3af, cntr_mode = 0xe, perf_mode1 = 0x1, perf_mode = 0x0}
rdna2.reg.gl2c_perfcounter1_select1 {perf_sel2 = 0x126, perf_sel3 = 0x2f0, perf_mode2 = 0x1, perf_mode3 = 0x8}
rdna2.reg.gl2c_perfcounter2_select {perf_sel = 0x1ee, cntr_mode = 0x0, perf_mode = 0x0}
rdna2.reg.gl2c_perfcounter3_select {perf_sel = 0xe0, cntr_mode = 0xe, perf_mode = 0x1}
rdna2.reg.grbm_gfx_index {instance_index = 0x82, sa_index = 0x11, se_index = 0xd2, sa_broadcast_writes = 0x1, instance_broadcast_writes = 0x1, se_broadcast_writes = 0x0}
rdna2.reg.grbm_perfcounter0_select {perf_sel = 0x3a, db_clean_user_defined_mask = 0x1, cb_clean_user_defined_mask = 0x0, ta_busy_user_defined_mask = 0x1, sx_busy_user_defined_mask = 0x1, spi_busy_user_defined_mask = 0x1, sc_busy_user_defined_mask = 0x1, pa_busy_user_defined_mask = 0x1, grbm_busy_user_defined_mask = 0x1, db_busy_user_defined_mask = 0x1, cb_busy_user_defined_mask = 0x0, cp_busy_user_defined_mask = 0x1, gds_busy_user_defined_mask = 0x1, bci_busy_user_defined_mask = 0x1, rlc_busy_user_defined_mask = 0x1, tcp_busy_user_defined_mask = 0x0, ge_busy_user_defined_mask = 0x1, utcl2_busy_user_defined_mask = 0x0, ea_busy_user_defined_mask = 0x0, rmi_busy_user_defined_mask = 0x0}
rdna2.reg.grbm_perfcounter0_select_hi {utcl1_busy_user_defined_mask = 0x1, gl2cc_busy_user_defined_mask = 0x0, sdma_busy_user_defined_mask = 0x0, ch_busy_user_defined_mask = 0x0, ph_busy_user_defined_mask = 0x0, pmm_busy_user_defined_mask = 0x0, gus_busy_user_defined_mask = 0x0, gl1cc_busy_user_defined_mask = 0x1}
rdna2.reg.grbm_perfcounter1_select {perf_sel = 0x1b, db_clean_user_defined_mask = 0x0, cb_clean_user_defined_mask = 0x1, ta_busy_user_defined_mask = 0x0, sx_busy_user_defined_mask = 0x1, spi_busy_user_defined_mask = 0x1, sc_busy_user_defined_mask = 0x1, pa_busy_user_defined_mask = 0x1, grbm_busy_user_defined_mask = 0x1, db_busy_user_defined_mask = 0x0, cb_busy_user_defined_mask = 0x0, cp_busy_user_defined_mask = 0x1, gds_busy_user_defined_mask = 0x1, bci_busy_user_defined_mask = 0x0, rlc_busy_user_defined_mask = 0x1, tcp_busy_user_defined_mask = 0x1, ge_busy_user_defined_mask = 0x1, utcl2_busy_user_defined_mask = 0x0, ea_busy_user_defined_mask = 0x0, rmi_busy_user_defined_mask = 0x0}
rdna2.reg.grbm_perfcounter1_select_hi {utcl1_busy_user_defined_mask = 0x1, gl2cc_busy_user_defined_mask = 0x1, sdma_busy_user_defined_mask = 0x0, ch_busy_user_defined_mask = 0x1, ph_busy_user_defined_mask = 0x1, pmm_busy_user_defined_mask = 0x1, gus_busy_user_defined_mask = 0x1, gl1cc_busy_user_defined_mask = 0x1}
rdna2.reg.grbm_se0_perfcounter_select {perf_sel = 0x1e, db_clean_user_defined_mask = 0x1, cb_clean_user_defined_mask = 0x1, ta_busy_user_defined_mask = 0x0, sx_busy_user_defined_mask = 0x0, spi_busy_user_defined_mask = 0x1, sc_busy_user_defined_mask = 0x1, db_busy_user_defined_mask = 0x1, cb_busy_user_defined_mask = 0x1, pa_busy_user_defined_mask = 0x1, bci_busy_user_defined_mask = 0x0, rmi_busy_user_defined_mask = 0x1, utcl1_busy_user_defined_mask = 0x0, tcp_busy_user_defined_mask = 0x0, gl1cc_busy_user_defined_mask = 0x0}
rdna2.reg.grbm_se1_perfcounter_select {perf_sel = 0x2e, db_clean_user_defined_mask = 0x1, cb_clean_user_defined_mask = 0x0, ta_busy_user_defined_mask = 0x1, sx_busy_user_defined_mask = 0x1, spi_busy_user_defined_mask = 0x1, sc_busy_user_defined_mask = 0x1, db_busy_user_defined_mask = 0x1, cb_busy_user_defined_mask = 0x1, pa_busy_user_defined_mask = 0x1, bci_busy_user_defined_mask = 0x0, rmi_busy_user_defined_mask = 0x0, utcl1_busy_user_defined_mask = 0x1, tcp_busy_user_defined_mask = 0x0, gl1cc_busy_user_defined_mask = 0x1}
rdna2.reg.grbm_se2_perfcounter_select {perf_sel = 0x26, db_clean_user_defined_mask = 0x0, cb_clean_user_defined_mask = 0x1, ta_busy_user_defined_mask = 0x0, sx_busy_user_defined_mask = 0x0, spi_busy_user_defined_mask = 0x0, sc_busy_user_defined_mask = 0x0, db_busy_user_defined_mask = 0x1, cb_busy_user_defined_mask = 0x0, pa_busy_user_defined_mask = 0x1, bci_busy_user_defined_mask = 0x0, rmi_busy_user_defined_mask = 0x1, utcl1_busy_user_defined_mask = 0x0, tcp_busy_user_defined_mask = 0x1, gl1cc_busy_user_defined_mask = 0x0}
rdna2.reg.grbm_se3_perfcounter_select {perf_sel = 0x1e, db_clean_user_defined_mask = 0x1, cb_clean_user_defined_mask = 0x1, ta_busy_user_defined_mask = 0x0, sx_busy_user_defined_mask = 0x1, spi_busy_user_defined_mask = 0x0, sc_busy_user_defined_mask = 0x0, db_busy_user_defined_mask = 0x0, cb_busy_user_defined_mask = 0x0, pa_busy_user_defined_mask = 0x1, bci_busy_user_defined_mask = 0x0, rmi_busy_user_defined_mask = 0x0, utcl1_busy_user_defined_mask = 0x1, tcp_busy_user_defined_mask = 0x1, gl1cc_busy_user_defined_mask = 0x0}
rdna2.reg.grbm_status {me0pipe0_cmdfifo_avail = 0xc, me0pipe0_cf_rq_pending = 0x1, me0pipe0_pf_rq_pending = 0x1, gds_dma_rq_pending = 0x0, db_clean = 0x0, cb_clean = 0x1, ta_busy = 0x1, gds_busy = 0x1, ge_busy_no_dma = 0x1, sx_busy = 0x0, ge_busy = 0x1, spi_busy = 0x1, bci_busy = 0x0, sc_busy = 0x0, pa_busy = 0x1, db_busy = 0x1, cp_coherency_busy = 0x0, cp_busy = 0x0, cb_busy = 0x1, gui_active = 0x0}
rdna2.reg.grbm_status2 {me0pipe1_cmdfifo_avail = 0x4, me0pipe1_cf_rq_pending = 0x0, me0pipe1_pf_rq_pending = 0x1, me1pipe0_rq_pending = 0x0, me1pipe1_rq_pending = 0x1, me1pipe2_rq_pending = 0x1, me1pipe3_rq_pending = 0x1, me2pipe0_rq_pending = 0x1, me2pipe1_rq_pending = 0x1, me2pipe2_rq_pending = 0x1, me2pipe3_rq_pending = 0x0, rlc_rq_pending = 0x1, utcl2_busy = 0x0, ea_busy = 0x0, rmi_busy = 0x0, utcl2_rq_pending = 0x0, sdma_sch_rq_pending = 0x1, ea_link_busy = 0x1, sdma_busy = 0x1, sdma0_rq_pending = 0x0, sdma1_rq_pending = 0x0, sdma2_rq_pending = 0x1, sdma3_rq_pending = 0x0, rlc_busy = 0x0, tcp_busy = 0x0, cpf_busy = 0x0, cpc_busy = 0x1, cpg_busy = 0x1, cpaxi_busy = 0x1}
rdna2.reg.grbm_status3 {grbm_rlc_intr_credit_pending = 0x0, grbm_utcl2_intr_credit_pending = 0x1, grbm_cpf_intr_credit_pending = 0x1, mespipe0_rq_pending = 0x0, mespipe1_rq_pending = 0x1, mespipe2_rq_pending = 0x0, mespipe3_rq_pending = 0x0, ph_busy = 0x1, ch_busy = 0x0, gl2cc_busy = 0x0, gl1cc_busy = 0x1, gus_link_busy = 0x0, gus_busy = 0x1, utcl1_busy = 0x1, pmm_busy = 0x0}
rdna2.reg.grbm_status_se0 {db_clean = 0x1, cb_clean = 0x0, utcl1_busy = 0x0, tcp_busy = 0x0, gl1cc_busy = 0x0, rmi_busy = 0x0, bci_busy = 0x1, pa_busy = 0x0, ta_busy = 0x1, sx_busy = 0x0, spi_busy = 0x1, sc_busy = 0x0, db_busy = 0x1, cb_busy = 0x0}
rdna2.reg.grbm_status_se1 {db_clean = 0x0, cb_clean = 0x0, utcl1_busy = 0x0, tcp_busy = 0x1, gl1cc_busy = 0x1, rmi_busy = 0x0, bci_busy = 0x0, pa_busy = 0x0, ta_busy = 0x0, sx_busy = 0x1, spi_busy = 0x1, sc_busy = 0x0, db_busy = 0x0, cb_busy = 0x0}
rdna2.reg.grbm_status_se2 {db_clean = 0x0, cb_clean = 0x1, utcl1_busy = 0x0, tcp_busy = 0x0, gl1cc_busy = 0x0, rmi_busy = 0x0, bci_busy = 0x1, pa_busy = 0x1, ta_busy = 0x0, sx_busy = 0x1, spi_busy = 0x0, sc_busy = 0x0, db_busy = 0x1, cb_busy = 0x1}
rdna2.reg.grbm_status_se3 {db_clean = 0x1, cb_clean = 0x1, utcl1_busy = 0x1, tcp_busy = 0x0, gl1cc_busy = 0x1, rmi_busy = 0x1, bci_busy = 0x0, pa_busy = 0x0, ta_busy = 0x1, sx_busy = 0x1, spi_busy = 0x0, sc_busy = 0x0, db_busy = 0x1, cb_busy = 0x0}
rdna2.reg.gus_perfcounter0_cfg {perf_sel = 0xb6, perf_sel_end = 0xa7, perf_mode = 0xc, enable = 0x0, clear = 0x1}
rdna2.reg.gus_perfcounter1_cfg {perf_sel = 0xe3, perf_sel_end = 0x47, perf_mode = 0xa, enable = 0x0, clear = 0x0}
rdna2.reg.gus_perfcounter2_mode {compare_mode0 = 0x1, compare_mode1 = 0x2, compare_mode2 = 0x0, compare_mode3 = 0x3, compare_value0 = 0x7, compare_value1 = 0xf, compare_value2 = 0x7, compare_value3 = 0x3}
rdna2.reg.gus_perfcounter2_select {perf_sel = 0x166, perf_sel1 = 0x39a, cntr_mode = 0xd, perf_mode1 = 0x7, perf_mode = 0x3}
rdna2.reg.gus_perfcounter2_select1 {perf_sel2 = 0x3b, perf_sel3 = 0x2d9, perf_mode3 = 0x3, perf_mode2 = 0xb}
rdna2.reg.gus_perfcounter_hi {counter_hi = 0xa48a, compare_value = 0x61ef}
rdna2.reg.gus_perfcounter_rslt_cntl {perf_counter_select = 0xf, start_trigger = 0xe7, stop_trigger = 0x5, enable_any = 0x1, clear_all = 0x0, stop_all_on_saturate = 0x0}
rdna2.reg.ia_multi_vgt_param {primgroup_size = 0x7c53, partial_vs_wave_on = 0x0, switch_on_eop = 0x1, partial_es_wave_on = 0x1, switch_on_eoi = 0x0, wd_switch_on_eop = 0x1}
rdna2.reg.ia_multi_vgt_param_piped {primgroup_size = 0xcb9a, partial_vs_wave_on = 0x1, switch_on_eop = 0x0, partial_es_wave_on = 0x1, switch_on_eoi = 0x0, wd_switch_on_eop = 0x1, en_inst_opt_basic = 0x1, en_inst_opt_adv = 0x1, hw_use_only = 0x1}
rdna2.reg.pa_cl_clip_cntl {ucp_ena_0 = 0x1, ucp_ena_1 = 0x0, ucp_ena_2 = 0x0, ucp_ena_3 = 0x0, ucp_ena_4 = 0x1, ucp_ena_5 = 0x1, ps_ucp_y_scale_neg = 0x1, ps_ucp_mode = 0x2, clip_disable = 0x1, ucp_cull_only_ena = 0x0, boundary_edge_flag_ena = 0x0, dx_clip_space_def = 0x1, dis_clip_err_detect = 0x0, vtx_kill_or = 0x1, dx_rasterization_kill = 0x1, dx_linear_attr_clip_ena = 0x1, vte_vport_provoke_disable = 0x1, zclip_near_disable = 0x0, zclip_far_disable = 0x1, zclip_prog_near_ena = 0x1}
rdna2.reg.pa_cl_naninf_cntl {vte_xy_inf_discard = 0x1, vte_z_inf_discard = 0x1, vte_w_inf_discard = 0x0, vte_0xnaninf_is_0 = 0x0, vte_xy_nan_retain = 0x1, vte_z_nan_retain = 0x1, vte_w_nan_retain = 0x1, vte_w_recip_nan_is_0 = 0x0, vs_xy_nan_to_inf = 0x1, vs_xy_inf_retain = 0x1, vs_z_nan_to_inf = 0x1, vs_z_inf_retain = 0x1, vs_w_nan_to_inf = 0x0, vs_w_inf_retain = 0x1, vs_clip_dist_inf_discard = 0x1, vte_no_output_neg_0 = 0x0}
rdna2.reg.pa_cl_ngg_cntl {vertex_reuse_off = 0x0, index_buf_edge_flag_ena = 0x0, vertex_reuse_depth = 0x90}
rdna2.reg.pa_cl_vrs_cntl {vertex_rate_combiner_mode = 0x6, primitive_rate_combiner_mode = 0x6, htile_rate_combiner_mode = 0x6, sample_iter_combiner_mode = 0x2, expose_vrs_pixels_mask = 0x1, cmask_rate_hint_force_zero = 0x1}
rdna2.reg.pa_cl_vs_out_cntl {clip_dist_ena_0 = 0x1, clip_dist_ena_1 = 0x1, clip_dist_ena_2 = 0x0, clip_dist_ena_3 = 0x1, clip_dist_ena_4 = 0x1, clip_dist_ena_5 = 0x1, clip_dist_ena_6 = 0x1, clip_dist_ena_7 = 0x0, cull_dist_ena_0 = 0x1, cull_dist_ena_1 = 0x0, cull_dist_ena_2 = 0x1, cull_dist_ena_3 = 0x0, cull_dist_ena_4 = 0x1, cull_dist_ena_5 = 0x0, cull_dist_ena_6 = 0x0, cull_dist_ena_7 = 0x0, use_vtx_point_size = 0x1, use_vtx_edge_flag = 0x1, use_vtx_render_target_indx = 0x0, use_vtx_viewport_indx = 0x1, use_vtx_kill_flag = 0x1, vs_out_misc_vec_ena = 0x1, vs_out_ccdist0_vec_ena = 0x1, vs_out_ccdist1_vec_ena = 0x1, vs_out_misc_side_bus_ena = 0x1, use_vtx_gs_cut_flag = 0x0, use_vtx_line_width = 0x1, use_vtx_vrs_rate = 0x0, bypass_vtx_rate_combiner = 0x0, bypass_prim_rate_combiner = 0x1}
rdna2.reg.pa_cl_vte_cntl {vport_x_scale_ena = 0x0, vport_x_offset_ena = 0x1, vport_y_scale_ena = 0x1, vport_y_offset_ena = 0x0, vport_z_scale_ena = 0x0, vport_z_offset_ena = 0x1, vtx_xy_fmt = 0x0, vtx_z_fmt = 0x0, vtx_w0_fmt = 0x1, perfcounter_ref = 0x0}
rdna2.reg.pa_ph_perfcounter0_select {perf_sel = 0x204, perf_sel1 = 0xdb, cntr_mode = 0x3, perf_mode1 = 0x6, perf_mode = 0x0}
rdna2.reg.pa_ph_perfcounter0_select1 {perf_sel2 = 0x6d, perf_sel3 = 0x321, perf_mode3 = 0xd, perf_mode2 = 0x7}
rdna2.reg.pa_ph_perfcounter1_select {perf_sel = 0x349, perf_sel1 = 0x197, cntr_mode = 0x9, perf_mode1 = 0xd, perf_mode = 0x2}
rdna2.reg.pa_ph_perfcounter1_select1 {perf_sel2 = 0xfe, perf_sel3 = 0x2d2, perf_mode3 = 0xf, perf_mode2 = 0x9}
rdna2.reg.pa_ph_perfcounter2_select {perf_sel = 0x350, perf_sel1 = 0x308, cntr_mode = 0xb, perf_mode1 = 0xe, perf_mode = 0x5}
rdna2.reg.pa_ph_perfcounter2_select1 {perf_sel2 = 0x323, perf_sel3 = 0x5d, perf_mode3 = 0xc, perf_mode2 = 0x4}
rdna2.reg.pa_ph_perfcounter3_select {perf_sel = 0x31a, perf_sel1 = 0x125, cntr_mode = 0xd, perf_mode1 = 0x5, perf_mode = 0x2}
rdna2.reg.pa_ph_perfcounter3_select1 {perf_sel2 = 0x205, perf_sel3 = 0x25f, perf_mode3 = 0x8, perf_mode2 = 0x6}
rdna2.reg.pa_ph_perfcounter4_select {perf_sel = 0x2ab}
rdna2.reg.pa_ph_perfcounter5_select {perf_sel = 0xa6}
rdna2.reg.pa_ph_perfcounter6_select {perf_sel = 0x84}
rdna2.reg.pa_ph_perfcounter7_select {perf_sel = 0x281}
rdna2.reg.pa_sc_aa_config {msaa_num_samples = 0x5, aa_mask_centroid_dtmn = 0x1, max_sample_dist = 0x7, msaa_exposed_samples = 0x5, detail_to_exposed_mode = 0x1, coverage_to_shader_select = 0x0, sample_coverage_encoding = 0x1, covered_centroid_is_center = 0x0}
rdna2.reg.pa_sc_aa_mask_x0y0_x1y0 {aa_mask_x0y0 = 0x50b7, aa_mask_x1y0 = 0xeb74}
rdna2.reg.pa_sc_aa_mask_x0y1_x1y1 {aa_mask_x0y1 = 0x4e93, aa_mask_x1y1 = 0x1ace}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y0_0 {s0_x = 0xf, s0_y = 0x6, s1_x = 0x9, s1_y = 0x3, s2_x = 0xe, s2_y = 0x2, s3_x = 0x6, s3_y = 0xc}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y0_1 {s4_x = 0x2, s4_y = 0x1, s5_x = 0x4, s5_y = 0xd, s6_x = 0xc, s6_y = 0x6, s7_x = 0x4, s7_y = 0xa}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y0_2 {s8_x = 0x9, s8_y = 0x4, s9_x = 0xc, s9_y = 0xb, s10_x = 0xd, s10_y = 0x7, s11_x = 0x7, s11_y = 0xc}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y0_3 {s12_x = 0xc, s12_y = 0x9, s13_x = 0xd, s13_y = 0xe, s14_x = 0x8, s14_y = 0x6, s15_x = 0x5, s15_y = 0x3}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y1_0 {s0_x = 0x4, s0_y = 0x0, s1_x = 0xf, s1_y = 0x9, s2_x = 0xd, s2_y = 0xa, s3_x = 0x0, s3_y = 0x9}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y1_1 {s4_x = 0x6, s4_y = 0x0, s5_x = 0x9, s5_y = 0xb, s6_x = 0x8, s6_y = 0xe, s7_x = 0x0, s7_y = 0x7}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y1_2 {s8_x = 0x5, s8_y = 0x6, s9_x = 0x6, s9_y = 0x0, s10_x = 0x4, s10_y = 0xf, s11_x = 0x2, s11_y = 0x5}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x0y1_3 {s12_x = 0xc, s12_y = 0x0, s13_x = 0x3, s13_y = 0x3, s14_x = 0x4, s14_y = 0x2, s15_x = 0xa, s15_y = 0xf}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y0_0 {s0_x = 0x7, s0_y = 0xd, s1_x = 0x3, s1_y = 0xe, s2_x = 0x5, s2_y = 0x3, s3_x = 0xe, s3_y = 0x1}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y0_1 {s4_x = 0x5, s4_y = 0x3, s5_x = 0xb, s5_y = 0xa, s6_x = 0xc, s6_y = 0x3, s7_x = 0x3, s7_y = 0x5}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y0_2 {s8_x = 0x3, s8_y = 0xa, s9_x = 0x7, s9_y = 0x7, s10_x = 0xa, s10_y = 0x1, s11_x = 0xa, s11_y = 0x4}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y0_3 {s12_x = 0x1, s12_y = 0x3, s13_x = 0x7, s13_y = 0x8, s14_x = 0x0, s14_y = 0x1, s15_x = 0x1, s15_y = 0x3}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y1_0 {s0_x = 0xb, s0_y = 0x2, s1_x = 0xe, s1_y = 0x4, s2_x = 0x5, s2_y = 0x5, s3_x = 0x2, s3_y = 0x2}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y1_1 {s4_x = 0x6, s4_y = 0x4, s5_x = 0xb, s5_y = 0x8, s6_x = 0xb, s6_y = 0x8, s7_x = 0x2, s7_y = 0xd}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y1_2 {s8_x = 0xf, s8_y = 0xe, s9_x = 0xa, s9_y = 0x4, s10_x = 0x3, s10_y = 0x4, s11_x = 0xc, s11_y = 0x9}
rdna2.reg.pa_sc_aa_sample_locs_pixel_x1y1_3 {s12_x = 0x3, s12_y = 0x3, s13_x = 0x3, s13_y = 0x1, s14_x = 0x2, s14_y = 0xe, s15_x = 0x1, s15_y = 0x0}
rdna2.reg.pa_sc_binner_cntl_0 {binning_mode = 0x3, bin_size_x = 0x0, bin_size_y = 0x1, bin_size_x_extend = 0x6, bin_size_y_extend = 0x5, context_states_per_bin = 0x5, persistent_states_per_bin = 0xc, disable_start_of_prim = 0x1, fpovs_per_batch = 0x8c, optimal_bin_selection = 0x0, flush_on_binning_transition = 0x0, bin_mapping_mode = 0x2}
rdna2.reg.pa_sc_binner_cntl_1 {max_alloc_count = 0xbd95, max_prim_per_batch = 0xb4c6}
rdna2.reg.pa_sc_centroid_priority_0 {distance_0 = 0xd, distance_1 = 0x7, distance_2 = 0x6, distance_3 = 0xf, distance_4 = 0xf, distance_5 = 0xd, distance_6 = 0x4, distance_7 = 0x4}
rdna2.reg.pa_sc_centroid_priority_1 {distance_8 = 0x7, distance_9 = 0xe, distance_10 = 0xd, distance_11 = 0x8, distance_12 = 0x1, distance_13 = 0x6, distance_14 = 0xb, distance_15 = 0x9}
rdna2.reg.pa_sc_cliprect_0_br {br_x = 0x4e0d, br_y = 0x7e14}
rdna2.reg.pa_sc_cliprect_0_tl {tl_x = 0x7b2c, tl_y = 0x5e58}
rdna2.reg.pa_sc_cliprect_1_br {br_x = 0x74eb, br_y = 0x37c0}
rdna2.reg.pa_sc_cliprect_1_tl {tl_x = 0x442c, tl_y = 0x436c}
rdna2.reg.pa_sc_cliprect_2_br {br_x = 0xa7f, br_y = 0x2e97}
rdna2.reg.pa_sc_cliprect_2_tl {tl_x = 0x6452, tl_y = 0x66f3}
rdna2.reg.pa_sc_cliprect_3_br {br_x = 0x2688, br_y = 0x2a64}
rdna2.reg.pa_sc_cliprect_3_tl {tl_x = 0x6419, tl_y = 0x690d}
rdna2.reg.pa_sc_cliprect_rule {clip_rule = 0x47c5}
rdna2.reg.pa_sc_conservative_rasterization_cntl {over_rast_enable = 0x0, over_rast_sample_select = 0xa, under_rast_enable = 0x1, under_rast_sample_select = 0x7, pbb_uncertainty_region_enable = 0x1, zmm_tri_extent = 0x1, zmm_tri_offset = 0x0, override_over_rast_inner_to_normal = 0x1, override_under_rast_inner_to_normal = 0x0, degenerate_override_inner_to_normal_disable = 0x1, uncertainty_region_mode = 0x1, outer_uncertainty_edgerule_override = 0x0, inner_uncertainty_edgerule_override = 0x0, null_squad_aa_mask_enable = 0x0, coverage_aa_mask_enable = 0x1, prez_aa_mask_enable = 0x1, postz_aa_mask_enable = 0x1, centroid_sample_override = 0x1, uncertainty_region_mult = 0x3, uncertainty_region_pbb_mult = 0x0}
rdna2.reg.pa_sc_edgerule {er_tri = 0x6, er_point = 0xc, er_rect = 0x1, er_line_lr = 0x18, er_line_rl = 0x2e, er_line_tb = 0x7, er_line_bt = 0x0}
rdna2.reg.pa_sc_generic_scissor_br {br_x = 0x666d, br_y = 0x2fc2}
rdna2.reg.pa_sc_generic_scissor_tl {tl_x = 0x1ce5, tl_y = 0x124, window_offset_disable = 0x0}
rdna2.reg.pa_sc_hp3d_trap_screen_count {count = 0xf493}
rdna2.reg.pa_sc_hp3d_trap_screen_h {x_coord = 0x13f8}
rdna2.reg.pa_sc_hp3d_trap_screen_hv_en {enable_hv_pre_shader = 0x1, force_pre_shader_all_pixels = 0x1}
rdna2.reg.pa_sc_hp3d_trap_screen_occurrence {count = 0x5b6b}
rdna2.reg.pa_sc_hp3d_trap_screen_v {y_coord = 0x1159}
rdna2.reg.pa_sc_line_cntl {expand_line_width = 0x0, last_pixel = 0x0, perpendicular_endcap_ena = 0x0, dx10_diamond_test_ena = 0x1, extra_dx_dy_precision = 0x0}
rdna2.reg.pa_sc_line_stipple {line_pattern = 0x7bda, repeat_count = 0x20, pattern_bit_order = 0x0, auto_reset_cntl = 0x0}
rdna2.reg.pa_sc_line_stipple_state {current_ptr = 0x4, current_count = 0x5c}
rdna2.reg.pa_sc_mode_cntl_0 {msaa_enable = 0x1, vport_scissor_enable = 0x0, line_stipple_enable = 0x1, send_unlit_stiles_to_pkr = 0x1, alternate_rbs_per_tile = 0x1, coarse_tile_starts_on_even_rb = 0x0}
rdna2.reg.pa_sc_mode_cntl_1 {walk_size = 0x0, walk_alignment = 0x1, walk_align8_prim_fits_st = 0x0, walk_fence_enable = 0x0, walk_fence_size = 0x1, supertile_walk_order_enable = 0x0, tile_walk_order_enable = 0x0, tile_cover_disable = 0x1, tile_cover_no_scissor = 0x1, zmm_line_extent = 0x1, zmm_line_offset = 0x0, zmm_rect_extent = 0x0, kill_pix_post_hi_z = 0x1, kill_pix_post_detail_mask = 0x0, ps_iter_sample = 0x0, multi_shader_engine_prim_discard_enable = 0x1, multi_gpu_supertile_enable = 0x1, gpu_id_override_enable = 0x0, gpu_id_override = 0x1, multi_gpu_prim_discard_enable = 0x0, force_eov_cntdwn_enable = 0x0, force_eov_rez_enable = 0x1, out_of_order_primitive_enable = 0x0, out_of_order_water_mark = 0x7}
rdna2.reg.pa_sc_ngg_mode_cntl {max_deallocs_in_wave = 0x23e, max_fpovs_in_wave = 0x8b}
rdna2.reg.pa_sc_p3d_trap_screen_count {count = 0x1e5a}
rdna2.reg.pa_sc_p3d_trap_screen_h {x_coord = 0x2a07}
rdna2.reg.pa_sc_p3d_trap_screen_hv_en {enable_hv_pre_shader = 0x1, force_pre_shader_all_pixels = 0x0}
rdna2.reg.pa_sc_p3d_trap_screen_occurrence {count = 0x3cbd}
rdna2.reg.pa_sc_p3d_trap_screen_v {y_coord = 0xa2b}
rdna2.reg.pa_sc_perfcounter0_select {perf_sel = 0x14, perf_sel1 = 0x3bf, cntr_mode = 0x4, perf_mode1 = 0xb, perf_mode = 0x3}
rdna2.reg.pa_sc_perfcounter0_select1 {perf_sel2 = 0x20a, perf_sel3 = 0x62, perf_mode3 = 0xf, perf_mode2 = 0xa}
rdna2.reg.pa_sc_perfcounter1_select {perf_sel = 0x229}
rdna2.reg.pa_sc_perfcounter2_select {perf_sel = 0x3ed}
rdna2.reg.pa_sc_perfcounter3_select {perf_sel = 0x1a1}
rdna2.reg.pa_sc_perfcounter4_select {perf_sel = 0x2cf}
rdna2.reg.pa_sc_perfcounter5_select {perf_sel = 0xe5}
rdna2.reg.pa_sc_perfcounter6_select {perf_sel = 0x35b}
rdna2.reg.pa_sc_perfcounter7_select {perf_sel = 0xb3}
rdna2.reg.pa_sc_raster_config {rb_map_pkr0 = 0x1, rb_map_pkr1 = 0x3, rb_xsel2 = 0x3, rb_xsel = 0x1, rb_ysel = 0x0, pkr_map = 0x0, pkr_xsel = 0x1, pkr_ysel = 0x0, pkr_xsel2 = 0x1, sc_map = 0x3, sc_xsel = 0x0, sc_ysel = 0x0, se_map = 0x1, se_xsel = 0x2, se_ysel = 0x1}
rdna2.reg.pa_sc_raster_config_1 {se_pair_map = 0x3, se_pair_xsel = 0x1, se_pair_ysel = 0x0}
rdna2.reg.pa_sc_screen_extent_control {slice_even_enable = 0x3, slice_odd_enable = 0x0}
rdna2.reg.pa_sc_screen_extent_max_0 {x = 0xb6dc, y = 0xcbb1}
rdna2.reg.pa_sc_screen_extent_max_1 {x = 0xc5a4, y = 0x34b7}
rdna2.reg.pa_sc_screen_extent_min_0 {x = 0x2b50, y = 0x68f2}
rdna2.reg.pa_sc_screen_extent_min_1 {x = 0x3672, y = 0xd829}
rdna2.reg.pa_sc_screen_scissor_br {br_x = 0x7491, br_y = 0x79a7}
rdna2.reg.pa_sc_screen_scissor_tl {tl_x = 0x5cc4, tl_y = 0xc0f}
rdna2.reg.pa_sc_shader_control {realign_dquads_after_n_waves = 0x3, load_collision_waveid = 0x1, load_intrawave_collision = 0x1, wave_break_region_size = 0x2}
rdna2.reg.pa_sc_tile_steering_override {enable = 0x1, num_se = 0x0, num_rb_per_se = 0x0, num_sc = 0x3, num_rb_per_sc = 0x2, num_packer_per_sc = 0x0}
rdna2.reg.pa_sc_trap_screen_count {count = 0x27cc}
rdna2.reg.pa_sc_trap_screen_h {x_coord = 0x1922}
rdna2.reg.pa_sc_trap_screen_hv_en {enable_hv_pre_shader = 0x1, force_pre_shader_all_pixels = 0x1}
rdna2.reg.pa_sc_trap_screen_occurrence {count = 0x835c}
rdna2.reg.pa_sc_trap_screen_v {y_coord = 0x3356}
rdna2.reg.pa_sc_vport_scissor_0_br {br_x = 0x514e, br_y = 0x7a60}
rdna2.reg.pa_sc_vport_scissor_0_tl {tl_x = 0x14a6, tl_y = 0x51d7, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_10_br {br_x = 0x7dc8, br_y = 0x3fd7}
rdna2.reg.pa_sc_vport_scissor_10_tl {tl_x = 0x1232, tl_y = 0x72cd, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_11_br {br_x = 0x352e, br_y = 0x42e6}
rdna2.reg.pa_sc_vport_scissor_11_tl {tl_x = 0x34d6, tl_y = 0x407b, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_12_br {br_x = 0x6a2e, br_y = 0x61c5}
rdna2.reg.pa_sc_vport_scissor_12_tl {tl_x = 0x732f, tl_y = 0x2714, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_13_br {br_x = 0x2afe, br_y = 0x558d}
rdna2.reg.pa_sc_vport_scissor_13_tl {tl_x = 0x4616, tl_y = 0x2a44, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_14_br {br_x = 0x1e12, br_y = 0x5440}
rdna2.reg.pa_sc_vport_scissor_14_tl {tl_x = 0x3791, tl_y = 0x4cf9, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_15_br {br_x = 0x76f1, br_y = 0x768d}
rdna2.reg.pa_sc_vport_scissor_15_tl {tl_x = 0xfc8, tl_y = 0x621c, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_1_br {br_x = 0x730b, br_y = 0x696d}
rdna2.reg.pa_sc_vport_scissor_1_tl {tl_x = 0x2017, tl_y = 0x5069, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_2_br {br_x = 0x398f, br_y = 0x2bfe}
rdna2.reg.pa_sc_vport_scissor_2_tl {tl_x = 0x3127, tl_y = 0x5e8f, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_3_br {br_x = 0x2422, br_y = 0x194a}
rdna2.reg.pa_sc_vport_scissor_3_tl {tl_x = 0x5f03, tl_y = 0x13f, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_4_br {br_x = 0x3086, br_y = 0x350e}
rdna2.reg.pa_sc_vport_scissor_4_tl {tl_x = 0x5a4, tl_y = 0x743a, window_offset_disable = 0x0}
rdna2.reg.pa_sc_vport_scissor_5_br {br_x = 0x60da, br_y = 0x5151}
rdna2.reg.pa_sc_vport_scissor_5_tl {tl_x = 0x7d99, tl_y = 0x1aeb, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_6_br {br_x = 0x88c, br_y = 0x70b0}
rdna2.reg.pa_sc_vport_scissor_6_tl {tl_x = 0x4d05, tl_y = 0x1b58, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_7_br {br_x = 0x7f43, br_y = 0x2b5c}
rdna2.reg.pa_sc_vport_scissor_7_tl {tl_x = 0x2ba0, tl_y = 0x2a36, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_8_br {br_x = 0x4c20, br_y = 0x24d2}
rdna2.reg.pa_sc_vport_scissor_8_tl {tl_x = 0x77a2, tl_y = 0x4d7a, window_offset_disable = 0x1}
rdna2.reg.pa_sc_vport_scissor_9_br {br_x = 0x2e76, br_y = 0x928}
rdna2.reg.pa_sc_vport_scissor_9_tl {tl_x = 0x6ed7, tl_y = 0x8b8, window_offset_disable = 0x1}
rdna2.reg.pa_sc_window_offset {window_x_offset = 0x879c, window_y_offset = 0x2bdb}
rdna2.reg.pa_sc_window_scissor_br {br_x = 0x6b5f, br_y = 0x7b9c}
rdna2.reg.pa_sc_window_scissor_tl {tl_x = 0x3e8c, tl_y = 0x7922, window_offset_disable = 0x0}
rdna2.reg.pa_stereo_cntl {stereo_mode = 0xf, rt_slice_mode = 0x2, rt_slice_offset = 0x3, vp_id_mode = 0x3, vp_id_offset = 0x2}
rdna2.reg.pa_su_hardware_screen_offset {hw_screen_offset_x = 0x1c4, hw_screen_offset_y = 0x1a3}
rdna2.reg.pa_su_line_cntl {width = 0x229d}
rdna2.reg.pa_su_line_stipple_cntl {line_stipple_reset = 0x2, expand_full_length = 0x0, fractional_accum = 0x1, diamond_adjust = 0x0}
rdna2.reg.pa_su_line_stipple_value {line_stipple_value = 0xceda6f}
rdna2.reg.pa_su_over_rasterization_cntl {discard_0_area_triangles = 0x0, discard_0_area_lines = 0x0, discard_0_area_points = 0x1, discard_0_area_rectangles = 0x1, use_provoking_zw = 0x0}
rdna2.reg.pa_su_perfcounter0_select {perf_sel = 0x229, perf_sel1 = 0x102, cntr_mode = 0x7, perf_mode1 = 0x0, perf_mode = 0x1}
rdna2.reg.pa_su_perfcounter0_select1 {perf_sel2 = 0x1df, perf_sel3 = 0x28e, perf_mode3 = 0x0, perf_mode2 = 0xf}
rdna2.reg.pa_su_perfcounter1_select {perf_sel = 0x149, perf_sel1 = 0x1c8, cntr_mode = 0xf, perf_mode1 = 0xf, perf_mode = 0xb}
rdna2.reg.pa_su_perfcounter1_select1 {perf_sel2 = 0x38, perf_sel3 = 0x146, perf_mode3 = 0x7, perf_mode2 = 0xd}
rdna2.reg.pa_su_perfcounter2_select {perf_sel = 0x3c0, perf_sel1 = 0x339, cntr_mode = 0x7, perf_mode1 = 0x5, perf_mode = 0x3}
rdna2.reg.pa_su_perfcounter2_select1 {perf_sel2 = 0x1c1, perf_sel3 = 0x1e3, perf_mode3 = 0xe, perf_mode2 = 0xd}
rdna2.reg.pa_su_perfcounter3_select {perf_sel = 0x361, perf_sel1 = 0x1df, cntr_mode = 0xa, perf_mode1 = 0xf, perf_mode = 0x6}
rdna2.reg.pa_su_perfcounter3_select1 {perf_sel2 = 0x14a, perf_sel3 = 0x214, perf_mode3 = 0x3, perf_mode2 = 0xf}
rdna2.reg.pa_su_point_minmax {min_size = 0xfad4, max_size = 0xd902}
rdna2.reg.pa_su_point_size {height = 0xf8df, width = 0x4278}
rdna2.reg.pa_su_poly_offset_db_fmt_cntl {poly_offset_neg_num_db_bits = 0x79, poly_offset_db_is_float_fmt = 0x1}
rdna2.reg.pa_su_prim_filter_cntl {triangle_filter_disable = 0x0, line_filter_disable = 0x0, point_filter_disable = 0x1, rectangle_filter_disable = 0x0, triangle_expand_ena = 0x0, line_expand_ena = 0x0, point_expand_ena = 0x1, rectangle_expand_ena = 0x1, prim_expand_constant = 0x15, xmax_right_exclusion = 0x0, ymax_bottom_exclusion = 0x0}
rdna2.reg.pa_su_sc_mode_cntl {cull_front = 0x0, cull_back = 0x1, face = 0x0, poly_mode = 0x0, polymode_front_ptype = 0x5, polymode_back_ptype = 0x1, poly_offset_front_enable = 0x1, poly_offset_back_enable = 0x0, poly_offset_para_enable = 0x0, vtx_window_offset_enable = 0x1, provoking_vtx_last = 0x1, persp_corr_dis = 0x0, multi_prim_ib_ena = 0x0, right_triangle_alternate_gradient_ref = 0x1, new_quad_decomposition = 0x0, keep_together_enable = 0x0}
rdna2.reg.pa_su_small_prim_filter_cntl {small_prim_filter_enable = 0x1, triangle_filter_disable = 0x1, line_filter_disable = 0x1, point_filter_disable = 0x1, rectangle_filter_disable = 0x1}
rdna2.reg.pa_su_vtx_cntl {pix_center = 0x0, round_mode = 0x3, quant_mode = 0x4}
rdna2.reg.rlc_gpm_perf_count_0 {feature_sel = 0x8, se_index = 0xe, sa_index = 0x5, wgp_index = 0x8, event_sel = 0x3, unused = 0x2, enable = 0x0}
rdna2.reg.rlc_gpm_perf_count_1 {feature_sel = 0x1, se_index = 0xe, sa_index = 0xa, wgp_index = 0xc, event_sel = 0x3, unused = 0x0, enable = 0x0}
rdna2.reg.rlc_gpu_iov_perf_cnt_cntl {enable = 0x1, mode_select = 0x1, reset = 0x1}
rdna2.reg.rlc_gpu_iov_perf_cnt_rd_addr {vfid = 0x3, cnt_id = 0x1}
rdna2.reg.rlc_gpu_iov_perf_cnt_wr_addr {vfid = 0x0, cnt_id = 0x2}
rdna2.reg.rlc_perfcounter0_select {perfcounter_select = 0x2a}
rdna2.reg.rlc_perfcounter1_select {perfcounter_select = 0x9}
rdna2.reg.rlc_perfmon_clk_cntl {perfmon_clock_state = 0x0}
rdna2.reg.rlc_perfmon_cntl {perfmon_state = 0x4, perfmon_sample_enable = 0x1}
rdna2.reg.rlc_spm_accum_ctrl {stroberesetperfmonitors = 0x0, strobestartaccumulation = 0x1, stroberearmaccum = 0x1, stroberesetspmblock = 0x1, strobestartspm = 0x6, stroberearmswaaccum = 0x1, strobestartswa = 0x0, strobeperfmonsamplewires = 0x0}
rdna2.reg.rlc_spm_accum_ctrlram_addr {addr = 0x663}
rdna2.reg.rlc_spm_accum_ctrlram_addr_offset {global_offset = 0x6b, spmwithaccum_se_offset = 0x39, spmwithaccum_global_offset = 0x48}
rdna2.reg.rlc_spm_accum_ctrlram_data {data = 0xcf}
rdna2.reg.rlc_spm_accum_dataram_32bitcntrs_regions {spp_addr_region = 0x74, swa_addr_region = 0x22}
rdna2.reg.rlc_spm_accum_dataram_addr {addr = 0x2c}
rdna2.reg.rlc_spm_accum_dataram_wrcount {dataramwrcount = 0x428ea}
rdna2.reg.rlc_spm_accum_mode {enableaccum = 0x0, enablespmwithaccummode = 0x1, enablesppmode = 0x0, autoresetperfmondisable = 0x1, swaautoresetperfmondisable = 0x0, autoaccumen = 0x0, swaautoaccumen = 0x1, autospmen = 0x0, swaautospmen = 0x0, globals_loadoverride = 0x0, globals_swaloadoverride = 0x0, se0_loadoverride = 0x0, se0_swaloadoverride = 0x0, se1_loadoverride = 0x0, se1_swaloadoverride = 0x1, se2_loadoverride = 0x0, se2_swaloadoverride = 0x0, se3_loadoverride = 0x1, se3_swaloadoverride = 0x0}
rdna2.reg.rlc_spm_accum_samples_requested {samplesrequested = 0xbd}
rdna2.reg.rlc_spm_accum_status {numbsamplescompleted = 0xef, accumdone = 0x1, spmdone = 0x0, accumoverflow = 0x1, accumarmed = 0x1, sequenceinprogress = 0x0, finalsequenceinprogress = 0x1, allfifosempty = 0x1, fsmisidle = 0x0, swaaccumdone = 0x0, swaspmdone = 0x0, swaaccumoverflow = 0x0, swaaccumarmed = 0x1, allsegsdone = 0x0, rearmswapending = 0x1, rearmspppending = 0x0}
rdna2.reg.rlc_spm_accum_swa_dataram_addr {addr = 0x70}
rdna2.reg.rlc_spm_accum_threshold {threshold = 0x1a84}
rdna2.reg.rlc_spm_deser_start_skew {deser_start_skew = 0x29}
rdna2.reg.rlc_spm_glb_sampledelay_ind_data {data = 0x74}
rdna2.reg.rlc_spm_globals_muxsel_skew {globals_muxsel_skew = 0x3e}
rdna2.reg.rlc_spm_globals_sample_skew {globals_sample_skew = 0x62}
rdna2.reg.rlc_spm_global_muxsel_addr {perfmon_sel_addr = 0x39}
rdna2.reg.rlc_spm_global_muxsel_addr_offset {offset = 0x4093}
rdna2.reg.rlc_spm_perfmon_cntl {reserved1 = 0x8cf, perfmon_ring_mode = 0x0, perfmon_sample_interval = 0xc43a}
rdna2.reg.rlc_spm_perfmon_glb_segment_size {perfmon_segment_size = 0x30, global_num_line = 0x90}
rdna2.reg.rlc_spm_perfmon_ring_base_hi {ring_base_hi = 0x5cd}
rdna2.reg.rlc_spm_perfmon_se3to0_segment_size {se0_num_line = 0x28, se1_num_line = 0xaf, se2_num_line = 0x54, se3_num_line = 0xf6}
rdna2.reg.rlc_spm_perfmon_segment_size {perfmon_segment_size = 0x7, reserved1 = 0x6, global_num_line = 0xc, se0_num_line = 0x17, se1_num_line = 0x9, se2_num_line = 0x9}
rdna2.reg.rlc_spm_perfmon_swa_glb_segment_size {perfmon_segment_size = 0xa, global_num_line = 0xbe}
rdna2.reg.rlc_spm_perfmon_swa_se3to0_segment_size {se0_num_line = 0xab, se1_num_line = 0x5d, se2_num_line = 0x8d, se3_num_line = 0x9d}
rdna2.reg.rlc_spm_perfmon_swa_segment_size {perfmon_segment_size = 0x5a, reserved1 = 0x7, global_num_line = 0xa, se0_num_line = 0xb, se1_num_line = 0x3, se2_num_line = 0x18}
rdna2.reg.rlc_spm_ring_wrptr {perfmon_ring_wrptr = 0x47e7b42}
rdna2.reg.rlc_spm_segment_threshold {num_segment_threshold = 0x19}
rdna2.reg.rlc_spm_se_muxsel_addr {perfmon_sel_addr = 0x123}
rdna2.reg.rlc_spm_se_muxsel_addr_offset {offset = 0xc4c8}
rdna2.reg.rlc_spm_se_muxsel_skew {se_muxsel_skew = 0x33}
rdna2.reg.rlc_spm_se_sampledelay_ind_data {data = 0x26}
rdna2.reg.rlc_spm_se_sample_skew {se_sample_skew = 0x20}
rdna2.reg.rlc_spm_virt_ctrl {pausespmsamplingrequest = 0x1}
rdna2.reg.rlc_spm_virt_status {spmsamplingpaused = 0x1}
rdna2.reg.rmi_perfcounter0_select {perf_sel = 0x6f, perf_sel1 = 0xcf, cntr_mode = 0x9, perf_mode1 = 0xb, perf_mode = 0xf}
rdna2.reg.rmi_perfcounter0_select1 {perf_sel2 = 0x13, perf_sel3 = 0x109, perf_mode3 = 0xe, perf_mode2 = 0xf}
rdna2.reg.rmi_perfcounter1_select {perf_sel = 0x1cc, perf_mode = 0x7}
rdna2.reg.rmi_perfcounter2_select {perf_sel = 0x1ff, perf_sel1 = 0x11d, cntr_mode = 0x1, perf_mode1 = 0x1, perf_mode = 0x8}
rdna2.reg.rmi_perfcounter2_select1 {perf_sel2 = 0x32, perf_sel3 = 0xb2, perf_mode3 = 0x2, perf_mode2 = 0x5}
rdna2.reg.rmi_perfcounter3_select {perf_sel = 0xb6, perf_mode = 0x9}
rdna2.reg.rmi_perf_counter_cntl {trans_based_perf_en_sel = 0x1, event_based_perf_en_sel = 0x3, tc_perf_en_sel = 0x1, perf_event_window_mask0 = 0x2, perf_event_window_mask1 = 0x2, perf_counter_cid = 0xc, perf_counter_vmid = 0x3, perf_counter_burst_length_threshold = 0x38, perf_soft_reset = 0x0, perf_cntr_spm_sel = 0x0}
rdna2.reg.scratch_reg_atomic {immed = 0xd24e9f, id = 0x0, reserved27 = 0x0, op = 0x2, reserved31 = 0x0}
rdna2.reg.scratch_umsk {obsolete_umsk = 0x86, obsolete_swap = 0x2}
rdna2.reg.sdma0_perfcnt_misc_cntl {cmd_op = 0x1857}
rdna2.reg.sdma0_perfcnt_perfcounter0_cfg {perf_sel = 0x42, perf_sel_end = 0xa6, perf_mode = 0x0, enable = 0x1, clear = 0x0}
rdna2.reg.sdma0_perfcnt_perfcounter1_cfg {perf_sel = 0x82, perf_sel_end = 0x67, perf_mode = 0x1, enable = 0x1, clear = 0x1}
rdna2.reg.sdma0_perfcnt_perfcounter_hi {counter_hi = 0x2e0a, compare_value = 0x66f}
rdna2.reg.sdma0_perfcnt_perfcounter_rslt_cntl {perf_counter_select = 0xf, start_trigger = 0x28, stop_trigger = 0xf, enable_any = 0x1, clear_all = 0x1, stop_all_on_saturate = 0x1}
rdna2.reg.sdma0_perfcounter0_select {perf_sel = 0x242, perf_sel1 = 0x349, cntr_mode = 0x2, perf_mode1 = 0xd, perf_mode = 0x3}
rdna2.reg.sdma0_perfcounter0_select1 {perf_sel2 = 0x2c, perf_sel3 = 0x2f0, perf_mode3 = 0xf, perf_mode2 = 0x9}
rdna2.reg.sdma0_perfcounter1_select {perf_sel = 0x389, perf_sel1 = 0x39c, cntr_mode = 0xa, perf_mode1 = 0xf, perf_mode = 0xc}
rdna2.reg.sdma0_perfcounter1_select1 {perf_sel2 = 0x2ef, perf_sel3 = 0x100, perf_mode3 = 0xe, perf_mode2 = 0x9}
rdna2.reg.sdma1_perfcnt_misc_cntl {cmd_op = 0x8fa9}
rdna2.reg.sdma1_perfcnt_perfcounter0_cfg {perf_sel = 0x6e, perf_sel_end = 0xed, perf_mode = 0x9, enable = 0x0, clear = 0x0}
rdna2.reg.sdma1_perfcnt_perfcounter1_cfg {perf_sel = 0x25, perf_sel_end = 0xf1, perf_mode = 0x2, enable = 0x0, clear = 0x0}
rdna2.reg.sdma1_perfcnt_perfcounter_hi {counter_hi = 0x5758, compare_value = 0x5f60}
rdna2.reg.sdma1_perfcnt_perfcounter_rslt_cntl {perf_counter_select = 0x8, start_trigger = 0xc3, stop_trigger = 0xc5, enable_any = 0x1, clear_all = 0x0, stop_all_on_saturate = 0x1}
rdna2.reg.sdma1_perfcounter0_select {perf_sel = 0x208, perf_sel1 = 0x106, cntr_mode = 0xf, perf_mode1 = 0x0, perf_mode = 0x3}
rdna2.reg.sdma1_perfcounter0_select1 {perf_sel2 = 0x3d8, perf_sel3 = 0x201, perf_mode3 = 0xa, perf_mode2 = 0xf}
rdna2.reg.sdma1_perfcounter1_select {perf_sel = 0xb2, perf_sel1 = 0x32d, cntr_mode = 0x5, perf_mode1 = 0x9, perf_mode = 0xb}
rdna2.reg.sdma1_perfcounter1_select1 {perf_sel2 = 0x244, perf_sel3 = 0x80, perf_mode3 = 0x1, perf_mode2 = 0x4}
rdna2.reg.sdma2_perfcnt_misc_cntl {cmd_op = 0x511}
rdna2.reg.sdma2_perfcnt_perfcounter0_cfg {perf_sel = 0x42, perf_sel_end = 0xfe, perf_mode = 0xd, enable = 0x0, clear = 0x0}
rdna2.reg.sdma2_perfcnt_perfcounter1_cfg {perf_sel = 0x42, perf_sel_end = 0xc9, perf_mode = 0x5, enable = 0x0, clear = 0x1}
rdna2.reg.sdma2_perfcnt_perfcounter_hi {counter_hi = 0xc49b, compare_value = 0x72b9}
rdna2.reg.sdma2_perfcnt_perfcounter_rslt_cntl {perf_counter_select = 0x5, start_trigger = 0xbb, stop_trigger = 0xa2, enable_any = 0x0, clear_all = 0x1, stop_all_on_saturate = 0x1}
rdna2.reg.sdma2_perfcounter0_select {perf_sel = 0x2b0, perf_sel1 = 0x19e, cntr_mode = 0xa, perf_mode1 = 0xa, perf_mode = 0x5}
rdna2.reg.sdma2_perfcounter0_select1 {perf_sel2 = 0x2ed, perf_sel3 = 0x101, perf_mode3 = 0x1, perf_mode2 = 0x0}
rdna2.reg.sdma2_perfcounter1_select {perf_sel = 0x2a0, perf_sel1 = 0xca, cntr_mode = 0x6, perf_mode1 = 0x0, perf_mode = 0x6}
rdna2.reg.sdma2_perfcounter1_select1 {perf_sel2 = 0x12c, perf_sel3 = 0x163, perf_mode3 = 0x2, perf_mode2 = 0xd}
rdna2.reg.sdma3_perfcnt_misc_cntl {cmd_op = 0x9e6f}
rdna2.reg.sdma3_perfcnt_perfcounter0_cfg {perf_sel = 0x1, perf_sel_end = 0x61, perf_mode = 0x6, enable = 0x1, clear = 0x0}
rdna2.reg.sdma3_perfcnt_perfcounter1_cfg {perf_sel = 0xd6, perf_sel_end = 0x85, perf_mode = 0x9, enable = 0x0, clear = 0x1}
rdna2.reg.sdma3_perfcnt_perfcounter_hi {counter_hi = 0x8333, compare_value = 0xff4d}
rdna2.reg.sdma3_perfcnt_perfcounter_rslt_cntl {perf_counter_select = 0xf, start_trigger = 0x5f, stop_trigger = 0xdc, enable_any = 0x1, clear_all = 0x0, stop_all_on_saturate = 0x1}
rdna2.reg.sdma3_perfcounter0_select {perf_sel = 0x1ae, perf_sel1 = 0xc, cntr_mode = 0x1, perf_mode1 = 0x5, perf_mode = 0x3}
rdna2.reg.sdma3_perfcounter0_select1 {perf_sel2 = 0x61, perf_sel3 = 0x30d, perf_mode3 = 0xe, perf_mode2 = 0x8}
rdna2.reg.sdma3_perfcounter1_select {perf_sel = 0x125, perf_sel1 = 0xd6, cntr_mode = 0xe, perf_mode1 = 0x8, perf_mode = 0x0}
rdna2.reg.sdma3_perfcounter1_select1 {perf_sel2 = 0x382, perf_sel3 = 0x3ca, perf_mode3 = 0x3, perf_mode2 = 0xd}
rdna2.reg.spi_baryc_cntl {persp_center_cntl = 0x1, persp_centroid_cntl = 0x0, linear_center_cntl = 0x0, linear_centroid_cntl = 0x0, pos_float_location = 0x0, pos_float_ulc = 0x1, front_face_all_bits = 0x1}
rdna2.reg.spi_config_cntl {gpr_write_priority = 0x1630f8, exp_priority_order = 0x1, enable_sqg_top_events = 0x1, enable_sqg_bop_events = 0x0, force_half_rate_pc_exp = 0x0, ttrace_stall_all = 0x0, alloc_arb_lru_ena = 0x1, exp_arb_lru_ena = 0x1, ps_pkr_priority_cntl = 0x2}
rdna2.reg.spi_interp_control_0 {flat_shade_ena = 0x1, pnt_sprite_ena = 0x1, pnt_sprite_ovrd_x = 0x1, pnt_sprite_ovrd_y = 0x1, pnt_sprite_ovrd_z = 0x0, pnt_sprite_ovrd_w = 0x7, pnt_sprite_top_1 = 0x1}
rdna2.reg.spi_perfcounter0_select {perf_sel = 0x53, perf_sel1 = 0xc2, cntr_mode = 0xa, perf_mode1 = 0xb, perf_mode = 0x7}
rdna2.reg.spi_perfcounter0_select1 {perf_sel2 = 0x1a, perf_sel3 = 0x97, perf_mode3 = 0x2, perf_mode2 = 0x6}
rdna2.reg.spi_perfcounter1_select {perf_sel = 0x13c, perf_sel1 = 0x1d, cntr_mode = 0x9, perf_mode1 = 0x6, perf_mode = 0xe}
rdna2.reg.spi_perfcounter1_select1 {perf_sel2 = 0xdc, perf_sel3 = 0x380, perf_mode3 = 0x8, perf_mode2 = 0x8}
rdna2.reg.spi_perfcounter2_select {perf_sel = 0x1b3, perf_sel1 = 0x172, cntr_mode = 0xb, perf_mode1 = 0x8, perf_mode = 0x3}
rdna2.reg.spi_perfcounter2_select1 {perf_sel2 = 0x57, perf_sel3 = 0xa, perf_mode3 = 0xa, perf_mode2 = 0x1}
rdna2.reg.spi_perfcounter3_select {perf_sel = 0x1ea, perf_sel1 = 0xec, cntr_mode = 0x6, perf_mode1 = 0xe, perf_mode = 0x9}
rdna2.reg.spi_perfcounter3_select1 {perf_sel2 = 0x2e5, perf_sel3 = 0x348, perf_mode3 = 0x8, perf_mode2 = 0x1}
rdna2.reg.spi_perfcounter4_select {perf_sel = 0x17b}
rdna2.reg.spi_perfcounter5_select {perf_sel = 0x2c0}
rdna2.reg.spi_perfcounter_bins {bin0_min = 0x6, bin0_max = 0x9, bin1_min = 0x7, bin1_max = 0xd, bin2_min = 0x3, bin2_max = 0x3, bin3_min = 0xd, bin3_max = 0x7}
rdna2.reg.spi_ps_input_addr {persp_sample_ena = 0x0, persp_center_ena = 0x1, persp_centroid_ena = 0x1, persp_pull_model_ena = 0x0, linear_sample_ena = 0x0, linear_center_ena = 0x1, linear_centroid_ena = 0x1, line_stipple_tex_ena = 0x1, pos_x_float_ena = 0x0, pos_y_float_ena = 0x1, pos_z_float_ena = 0x0, pos_w_float_ena = 0x0, front_face_ena = 0x0, ancillary_ena = 0x1, sample_coverage_ena = 0x1, pos_fixed_pt_ena = 0x1}
rdna2.reg.spi_ps_input_cntl_0 {offset = 0xc, default_val = 0x2, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0x5, pt_sprite_tex = 0x0, dup = 0x0, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x3, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_1 {offset = 0x7, default_val = 0x0, flat_shade = 0x0, rotate_pc_ptr = 0x1, cyl_wrap = 0xf, pt_sprite_tex = 0x1, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x3, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_10 {offset = 0x17, default_val = 0x1, flat_shade = 0x0, rotate_pc_ptr = 0x1, cyl_wrap = 0x3, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x1, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_11 {offset = 0x19, default_val = 0x1, flat_shade = 0x0, rotate_pc_ptr = 0x0, cyl_wrap = 0x1, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x2, pt_sprite_tex_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_12 {offset = 0x12, default_val = 0x2, flat_shade = 0x0, rotate_pc_ptr = 0x1, cyl_wrap = 0x5, pt_sprite_tex = 0x1, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x1, pt_sprite_tex_attr1 = 0x1, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_13 {offset = 0x6, default_val = 0x1, flat_shade = 0x0, rotate_pc_ptr = 0x1, cyl_wrap = 0x8, pt_sprite_tex = 0x1, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x3, pt_sprite_tex_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_14 {offset = 0x3b, default_val = 0x3, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0x8, pt_sprite_tex = 0x0, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x0, default_val_attr1 = 0x0, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_15 {offset = 0x35, default_val = 0x3, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0xc, pt_sprite_tex = 0x0, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x1, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_16 {offset = 0x17, default_val = 0x0, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0x9, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x2, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_17 {offset = 0x3e, default_val = 0x1, flat_shade = 0x0, rotate_pc_ptr = 0x1, cyl_wrap = 0x9, pt_sprite_tex = 0x0, dup = 0x0, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x1, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_18 {offset = 0x2e, default_val = 0x1, flat_shade = 0x1, rotate_pc_ptr = 0x0, cyl_wrap = 0x8, pt_sprite_tex = 0x0, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x0, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_19 {offset = 0x1a, default_val = 0x3, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0x4, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x0, default_val_attr1 = 0x0, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_2 {offset = 0x25, default_val = 0x3, flat_shade = 0x0, rotate_pc_ptr = 0x1, cyl_wrap = 0xa, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x0, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_20 {offset = 0x3b, default_val = 0x2, flat_shade = 0x0, rotate_pc_ptr = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_21 {offset = 0x29, default_val = 0x2, flat_shade = 0x0, rotate_pc_ptr = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x3, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_22 {offset = 0x3c, default_val = 0x2, flat_shade = 0x1, rotate_pc_ptr = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_23 {offset = 0x3, default_val = 0x3, flat_shade = 0x1, rotate_pc_ptr = 0x0, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_24 {offset = 0x27, default_val = 0x2, flat_shade = 0x0, rotate_pc_ptr = 0x0, dup = 0x0, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x3, attr0_valid = 0x0, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_25 {offset = 0x2b, default_val = 0x0, flat_shade = 0x1, rotate_pc_ptr = 0x1, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x2, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_26 {offset = 0x11, default_val = 0x1, flat_shade = 0x0, rotate_pc_ptr = 0x0, dup = 0x0, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x2, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_27 {offset = 0x23, default_val = 0x2, flat_shade = 0x1, rotate_pc_ptr = 0x0, dup = 0x0, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x3, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_28 {offset = 0x1b, default_val = 0x0, flat_shade = 0x1, rotate_pc_ptr = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x2, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_29 {offset = 0x7, default_val = 0x0, flat_shade = 0x0, rotate_pc_ptr = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_3 {offset = 0x3b, default_val = 0x3, flat_shade = 0x1, rotate_pc_ptr = 0x0, cyl_wrap = 0x3, pt_sprite_tex = 0x1, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x3, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_30 {offset = 0x3b, default_val = 0x3, flat_shade = 0x0, rotate_pc_ptr = 0x0, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x0, default_val_attr1 = 0x3, attr0_valid = 0x1, attr1_valid = 0x0}
rdna2.reg.spi_ps_input_cntl_31 {offset = 0x31, default_val = 0x2, flat_shade = 0x0, rotate_pc_ptr = 0x1, dup = 0x0, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_4 {offset = 0x2d, default_val = 0x0, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0xf, pt_sprite_tex = 0x1, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x0, default_val_attr1 = 0x0, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_5 {offset = 0x18, default_val = 0x2, flat_shade = 0x0, rotate_pc_ptr = 0x0, cyl_wrap = 0x5, pt_sprite_tex = 0x1, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x0, default_val_attr1 = 0x3, pt_sprite_tex_attr1 = 0x1, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_6 {offset = 0x6, default_val = 0x0, flat_shade = 0x0, rotate_pc_ptr = 0x0, cyl_wrap = 0xf, pt_sprite_tex = 0x1, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x0, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_7 {offset = 0x25, default_val = 0x2, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0x9, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x0, use_default_attr1 = 0x1, default_val_attr1 = 0x2, pt_sprite_tex_attr1 = 0x0, attr0_valid = 0x1, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_8 {offset = 0x5, default_val = 0x0, flat_shade = 0x1, rotate_pc_ptr = 0x1, cyl_wrap = 0x2, pt_sprite_tex = 0x0, dup = 0x0, fp16_interp_mode = 0x0, use_default_attr1 = 0x0, default_val_attr1 = 0x2, pt_sprite_tex_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_cntl_9 {offset = 0x1e, default_val = 0x0, flat_shade = 0x1, rotate_pc_ptr = 0x0, cyl_wrap = 0x8, pt_sprite_tex = 0x0, dup = 0x1, fp16_interp_mode = 0x1, use_default_attr1 = 0x1, default_val_attr1 = 0x1, pt_sprite_tex_attr1 = 0x1, attr0_valid = 0x0, attr1_valid = 0x1}
rdna2.reg.spi_ps_input_ena {persp_sample_ena = 0x1, persp_center_ena = 0x0, persp_centroid_ena = 0x1, persp_pull_model_ena = 0x1, linear_sample_ena = 0x1, linear_center_ena = 0x0, linear_centroid_ena = 0x1, line_stipple_tex_ena = 0x0, pos_x_float_ena = 0x0, pos_y_float_ena = 0x1, pos_z_float_ena = 0x0, pos_w_float_ena = 0x1, front_face_ena = 0x0, ancillary_ena = 0x0, sample_coverage_ena = 0x1, pos_fixed_pt_ena = 0x0}
rdna2.reg.spi_ps_in_control {num_interp = 0x11, offchip_param_en = 0x1, late_pc_dealloc = 0x0, num_prim_interp = 0x9, bc_optimize_disable = 0x1, ps_w32_en = 0x1}
rdna2.reg.spi_shader_col_format {col0_export_format = 0x1, col1_export_format = 0xd, col2_export_format = 0x3, col3_export_format = 0x1, col4_export_format = 0xf, col5_export_format = 0x4, col6_export_format = 0x1, col7_export_format = 0x5}
rdna2.reg.spi_shader_idx_format {idx0_export_format = 0x7}
rdna2.reg.spi_shader_late_alloc_vs {limit = 0x9}
rdna2.reg.spi_shader_pgm_hi_es {mem_base = 0xe0}
rdna2.reg.spi_shader_pgm_hi_es_gs {mem_base = 0x0}
rdna2.reg.spi_shader_pgm_hi_gs {mem_base = 0x57}
rdna2.reg.spi_shader_pgm_hi_hs {mem_base = 0x1e}
rdna2.reg.spi_shader_pgm_hi_ls {mem_base = 0x2b}
rdna2.reg.spi_shader_pgm_hi_ls_hs {mem_base = 0xf5}
rdna2.reg.spi_shader_pgm_hi_ps {mem_base = 0x91}
rdna2.reg.spi_shader_pgm_hi_vs {mem_base = 0x19}
rdna2.reg.spi_shader_pgm_rsrc1_gs {vgprs = 0x30, sgprs = 0xa, priority = 0x0, float_mode = 0x4a, priv = 0x0, dx10_clamp = 0x1, ieee_mode = 0x0, cu_group_enable = 0x0, mem_ordered = 0x0, fwd_progress = 0x0, wgp_mode = 0x1, gs_vgpr_comp_cnt = 0x1, fp16_ovfl = 0x1}
rdna2.reg.spi_shader_pgm_rsrc1_hs {vgprs = 0x27, sgprs = 0xd, priority = 0x0, float_mode = 0x29, priv = 0x0, dx10_clamp = 0x1, ieee_mode = 0x0, mem_ordered = 0x0, fwd_progress = 0x0, wgp_mode = 0x0, ls_vgpr_comp_cnt = 0x1, fp16_ovfl = 0x1}
rdna2.reg.spi_shader_pgm_rsrc1_ps {vgprs = 0x0, sgprs = 0x8, priority = 0x1, float_mode = 0xd, priv = 0x0, dx10_clamp = 0x0, ieee_mode = 0x0, cu_group_disable = 0x0, mem_ordered = 0x0, fwd_progress = 0x0, load_provoking_vtx = 0x1, fp16_ovfl = 0x1}
rdna2.reg.spi_shader_pgm_rsrc1_vs {vgprs = 0x21, sgprs = 0xe, priority = 0x2, float_mode = 0xcd, priv = 0x0, dx10_clamp = 0x0, ieee_mode = 0x1, vgpr_comp_cnt = 0x0, cu_group_enable = 0x1, mem_ordered = 0x0, fwd_progress = 0x1, fp16_ovfl = 0x1}
rdna2.reg.spi_shader_pgm_rsrc2_gs {scratch_en = 0x0, user_sgpr = 0x18, trap_present = 0x0, excp_en = 0x12a, es_vgpr_comp_cnt = 0x2, oc_lds_en = 0x1, lds_size = 0x8d, user_sgpr_msb = 0x0, shared_vgpr_cnt = 0x1}
rdna2.reg.spi_shader_pgm_rsrc2_gs_vs {scratch_en = 0x1, user_sgpr = 0x6, trap_present = 0x1, excp_en = 0x85, vgpr_comp_cnt = 0x0, oc_lds_en = 0x0, lds_size = 0x89, skip_usgpr0 = 0x0, user_sgpr_msb = 0x0}
rdna2.reg.spi_shader_pgm_rsrc2_hs {scratch_en = 0x1, user_sgpr = 0x1e, trap_present = 0x1, oc_lds_en = 0x1, tg_size_en = 0x0, excp_en = 0x12c, lds_size = 0x1e8, user_sgpr_msb = 0x0, shared_vgpr_cnt = 0xa}
rdna2.reg.spi_shader_pgm_rsrc2_ps {scratch_en = 0x0, user_sgpr = 0xd, trap_present = 0x0, wave_cnt_en = 0x0, extra_lds_size = 0x48, excp_en = 0x131, load_collision_waveid = 0x0, load_intrawave_collision = 0x1, user_sgpr_msb = 0x1, shared_vgpr_cnt = 0x7}
rdna2.reg.spi_shader_pgm_rsrc2_vs {scratch_en = 0x0, user_sgpr = 0x8, trap_present = 0x0, oc_lds_en = 0x0, so_base0_en = 0x1, so_base1_en = 0x1, so_base2_en = 0x0, so_base3_en = 0x0, so_en = 0x1, excp_en = 0x91, pc_base_en = 0x0, dispatch_draw_en = 0x0, user_sgpr_msb = 0x1, shared_vgpr_cnt = 0xc}
rdna2.reg.spi_shader_pgm_rsrc3_gs {cu_en = 0x95d5, wave_limit = 0x34, lock_low_threshold = 0x8, group_fifo_depth = 0x11}
rdna2.reg.spi_shader_pgm_rsrc3_hs {wave_limit = 0x3f, lock_low_threshold = 0x1, group_fifo_depth = 0x0, cu_en = 0x31f0}
rdna2.reg.spi_shader_pgm_rsrc3_ps {cu_en = 0xd6b2, wave_limit = 0x2e, lock_low_threshold = 0xa}
rdna2.reg.spi_shader_pgm_rsrc3_vs {cu_en = 0x55a6, wave_limit = 0x18, lock_low_threshold = 0xf}
rdna2.reg.spi_shader_pgm_rsrc4_gs {cu_en = 0xad89, spi_shader_late_alloc_gs = 0x7a}
rdna2.reg.spi_shader_pgm_rsrc4_hs {cu_en = 0x8805}
rdna2.reg.spi_shader_pgm_rsrc4_ps {cu_en = 0x3557}
rdna2.reg.spi_shader_pgm_rsrc4_vs {cu_en = 0xb8f4}
rdna2.reg.spi_shader_pos_format {pos0_export_format = 0x0, pos1_export_format = 0xb, pos2_export_format = 0x2, pos3_export_format = 0x3, pos4_export_format = 0x5}
rdna2.reg.spi_shader_req_ctrl_esgs {soft_grouping_en = 0x0, number_of_requests_per_cu = 0x3, soft_grouping_allocation_timeout = 0x5, hard_lock_hysteresis = 0x0, hard_lock_low_threshold = 0xd, producer_request_lockout = 0x0, global_scanning_en = 0x0, allocation_rate_throttling_threshold = 0x1}
rdna2.reg.spi_shader_req_ctrl_lshs {soft_grouping_en = 0x1, number_of_requests_per_cu = 0x9, soft_grouping_allocation_timeout = 0x2, hard_lock_hysteresis = 0x0, hard_lock_low_threshold = 0x12, producer_request_lockout = 0x1, global_scanning_en = 0x0, allocation_rate_throttling_threshold = 0x0}
rdna2.reg.spi_shader_req_ctrl_ps {soft_grouping_en = 0x0, number_of_requests_per_cu = 0xb, soft_grouping_allocation_timeout = 0xd, hard_lock_hysteresis = 0x0, hard_lock_low_threshold = 0xd, producer_request_lockout = 0x1, global_scanning_en = 0x1, allocation_rate_throttling_threshold = 0x0}
rdna2.reg.spi_shader_req_ctrl_vs {soft_grouping_en = 0x1, number_of_requests_per_cu = 0x5, soft_grouping_allocation_timeout = 0x1, hard_lock_hysteresis = 0x1, hard_lock_low_threshold = 0x16, producer_request_lockout = 0x0, global_scanning_en = 0x0, allocation_rate_throttling_threshold = 0x6}
rdna2.reg.spi_shader_user_accum_esgs_0 {contribution = 0x64}
rdna2.reg.spi_shader_user_accum_esgs_1 {contribution = 0x5d}
rdna2.reg.spi_shader_user_accum_esgs_2 {contribution = 0x40}
rdna2.reg.spi_shader_user_accum_esgs_3 {contribution = 0x27}
rdna2.reg.spi_shader_user_accum_lshs_0 {contribution = 0x62}
rdna2.reg.spi_shader_user_accum_lshs_1 {contribution = 0x76}
rdna2.reg.spi_shader_user_accum_lshs_2 {contribution = 0x6f}
rdna2.reg.spi_shader_user_accum_lshs_3 {contribution = 0x7a}
rdna2.reg.spi_shader_user_accum_ps_0 {contribution = 0xd}
rdna2.reg.spi_shader_user_accum_ps_1 {contribution = 0x7}
rdna2.reg.spi_shader_user_accum_ps_2 {contribution = 0x71}
rdna2.reg.spi_shader_user_accum_ps_3 {contribution = 0x3f}
rdna2.reg.spi_shader_user_accum_vs_0 {contribution = 0x7b}
rdna2.reg.spi_shader_user_accum_vs_1 {contribution = 0xa}
rdna2.reg.spi_shader_user_accum_vs_2 {contribution = 0x28}
rdna2.reg.spi_shader_user_accum_vs_3 {contribution = 0x5d}
rdna2.reg.spi_shader_z_format {z_export_format = 0x2}
rdna2.reg.spi_tmpring_size {waves = 0xa7b, wavesize = 0x76a}
rdna2.reg.spi_vs_out_config {vs_export_count = 0x18, vs_half_pack = 0x0, no_pc_export = 0x1, prim_export_count = 0xa}
rdna2.reg.sqc_caches {target_inst = 0x0, target_data = 0x1, invalidate = 0x1, complete = 0x0, l2_wb_policy = 0x3}
rdna2.reg.sq_perfcounter0_select {perf_sel = 0x10f, spm_mode = 0xb, perf_mode = 0x3}
rdna2.reg.sq_perfcounter10_select {perf_sel = 0xd4, spm_mode = 0x2, perf_mode = 0xf}
rdna2.reg.sq_perfcounter11_select {perf_sel = 0x1c8, spm_mode = 0xe, perf_mode = 0xc}
rdna2.reg.sq_perfcounter12_select {perf_sel = 0x1bc, spm_mode = 0x1, perf_mode = 0x7}
rdna2.reg.sq_perfcounter13_select {perf_sel = 0x1d0, spm_mode = 0x7, perf_mode = 0xe}
rdna2.reg.sq_perfcounter14_select {perf_sel = 0x139, spm_mode = 0x0, perf_mode = 0x4}
rdna2.reg.sq_perfcounter15_select {perf_sel = 0x66, spm_mode = 0xb, perf_mode = 0xe}
rdna2.reg.sq_perfcounter1_select {perf_sel = 0x1f1, spm_mode = 0x1, perf_mode = 0xf}
rdna2.reg.sq_perfcounter2_select {perf_sel = 0x164, spm_mode = 0xa, perf_mode = 0xe}
rdna2.reg.sq_perfcounter3_select {perf_sel = 0x3, spm_mode = 0x5, perf_mode = 0x3}
rdna2.reg.sq_perfcounter4_select {perf_sel = 0x1b7, spm_mode = 0xb, perf_mode = 0xd}
rdna2.reg.sq_perfcounter5_select {perf_sel = 0x13e, spm_mode = 0x2, perf_mode = 0xd}
rdna2.reg.sq_perfcounter6_select {perf_sel = 0x103, spm_mode = 0x9, perf_mode = 0x3}
rdna2.reg.sq_perfcounter7_select {perf_sel = 0x69, spm_mode = 0x8, perf_mode = 0x7}
rdna2.reg.sq_perfcounter8_select {perf_sel = 0x4, spm_mode = 0xe, perf_mode = 0x9}
rdna2.reg.sq_perfcounter9_select {perf_sel = 0x1e8, spm_mode = 0xc, perf_mode = 0xe}
rdna2.reg.sq_perfcounter_ctrl {ps_en = 0x1, vs_en = 0x0, gs_en = 0x1, es_en = 0x0, hs_en = 0x1, ls_en = 0x1, cs_en = 0x0, cntr_rate = 0x3, disable_flush = 0x0, disable_me0pipe0_perf = 0x0, disable_me0pipe1_perf = 0x0, disable_me1pipe0_perf = 0x1, disable_me1pipe1_perf = 0x0, disable_me1pipe2_perf = 0x0, disable_me1pipe3_perf = 0x0}
rdna2.reg.sq_perfcounter_ctrl2 {force_en = 0x1}
rdna2.reg.sq_thread_trace_buf0_size {base_hi = 0x6, size = 0x18e6a0}
rdna2.reg.sq_thread_trace_buf1_size {base_hi = 0xc, size = 0x3a2db0}
rdna2.reg.sq_thread_trace_ctrl {mode = 0x3, all_vmid = 0x0, ch_perf_en = 0x0, interrupt_en = 0x0, double_buffer = 0x0, hiwater = 0x3, reg_stall_en = 0x1, spi_stall_en = 0x1, sq_stall_en = 0x1, reg_drop_on_stall = 0x1, util_timer = 0x0, wavestart_mode = 0x1, rt_freq = 0x2, sync_count_markers = 0x1, sync_count_draws = 0x1, lowater_offset = 0x6, auto_flush_padding_dis = 0x1, auto_flush_mode = 0x1, capture_all = 0x0, draw_event_en = 0x1}
rdna2.reg.sq_thread_trace_mask {simd_sel = 0x1, wgp_sel = 0xc, sa_sel = 0x1, wtype_include = 0xe}
rdna2.reg.sq_thread_trace_status {finish_pending = 0x509, finish_done = 0xddc, utc_err = 0x0, busy = 0x1, event_cntr_overflow = 0x0, event_cntr_stall = 0x0, owner_vmid = 0x5}
rdna2.reg.sq_thread_trace_status2 {buf0_full = 0x0, buf1_full = 0x1, packet_lost_buf_no_lockdown = 0x1}
rdna2.reg.sq_thread_trace_token_mask {token_exclude = 0x38, bop_events_token_include = 0x0, reg_include = 0xa6, inst_exclude = 0x3, reg_exclude = 0x6, reg_detail_all = 0x0}
rdna2.reg.sq_thread_trace_wptr {offset = 0x1390a62d, buffer_id = 0x1}
rdna2.reg.sq_wave_active {wave_slot = 0x78433}
rdna2.reg.sq_wave_gpr_alloc {vgpr_base = 0xd4, vgpr_size = 0x4e, sgpr_base = 0x24, sgpr_size = 0x8}
rdna2.reg.sq_wave_hw_id1 {wave_id = 0x12, simd_id = 0x3, wgp_id = 0x8, sa_id = 0x0, se_id = 0x2}
rdna2.reg.sq_wave_hw_id2 {queue_id = 0xc, pipe_id = 0x3, me_id = 0x0, state_id = 0x7, wg_id = 0x13, vm_id = 0xf}
rdna2.reg.sq_wave_hw_id_legacy {wave_id = 0x6, simd_id = 0x0, pipe_id = 0x1, cu_id = 0xe, sh_id = 0x0, se_id = 0x2, wave_id_msb = 0x0, tg_id = 0x0, vm_id = 0x6, queue_id = 0x4, state_id = 0x7, me_id = 0x3}
rdna2.reg.sq_wave_ib_dbg1 {wave_idle = 0x0, misc_cnt = 0x47}
rdna2.reg.sq_wave_ib_sts {vm_cnt = 0xc, exp_cnt = 0x3, lgkm_cnt_bit4 = 0x0, lgkm_cnt = 0xb, valu_cnt = 0x4, vm_cnt_hi = 0x1, lgkm_cnt_bit5 = 0x0, vs_cnt = 0x0}
rdna2.reg.sq_wave_ib_sts2 {inst_prefetch = 0x0, resource_override = 0x0, mem_order = 0x1, fwd_progress = 0x0, wave64 = 0x0}
rdna2.reg.sq_wave_lds_alloc {lds_base = 0xb1, lds_size = 0xb6, vgpr_shared_size = 0xd}
rdna2.reg.sq_wave_mode {fp_round = 0x0, fp_denorm = 0xc, dx10_clamp = 0x1, ieee = 0x0, lod_clamped = 0x0, excp_en = 0x61, fp16_ovfl = 0x1, disable_perf = 0x0}
rdna2.reg.sq_wave_pc_hi {pc_hi = 0xaed5}
rdna2.reg.sq_wave_pops_packer {pops_en = 0x1, pops_packer_id = 0x2}
rdna2.reg.sq_wave_sched_mode {dep_mode = 0x3}
rdna2.reg.sq_wave_shader_cycles {cycles = 0x899c0}
rdna2.reg.sq_wave_status {scc = 0x0, spi_prio = 0x1, user_prio = 0x0, priv = 0x1, trap_en = 0x1, ttrace_en = 0x0, export_rdy = 0x1, execz = 0x1, vccz = 0x0, in_tg = 0x1, in_barrier = 0x0, halt = 0x0, trap = 0x1, ttrace_simd_en = 0x1, valid = 0x1, ecc_err = 0x0, skip_export = 0x0, perf_en = 0x0, fatal_halt = 0x0, must_export = 0x1}
rdna2.reg.sq_wave_trapsts {excp = 0x199, savectx = 0x0, illegal_inst = 0x1, excp_hi = 0x7, buffer_oob = 0x1, excp_cycle = 0x9, excp_group_mask = 0x4, excp_wave64hi = 0x1, utc_error = 0x0, dp_rate = 0x1}
rdna2.reg.sq_wave_valid_and_idle {wave_slot = 0x9b65e}
rdna2.reg.sq_wave_vgpr_offset {src0 = 0x2b, src1 = 0xf, src2 = 0x11, dst = 0x12}
rdna2.reg.sx_blend_opt_control {mrt0_color_opt_disable = 0x0, mrt0_alpha_opt_disable = 0x1, mrt1_color_opt_disable = 0x1, mrt1_alpha_opt_disable = 0x0, mrt2_color_opt_disable = 0x0, mrt2_alpha_opt_disable = 0x1, mrt3_color_opt_disable = 0x0, mrt3_alpha_opt_disable = 0x0, mrt4_color_opt_disable = 0x1, mrt4_alpha_opt_disable = 0x0, mrt5_color_opt_disable = 0x0, mrt5_alpha_opt_disable = 0x0, mrt6_color_opt_disable = 0x0, mrt6_alpha_opt_disable = 0x0, mrt7_color_opt_disable = 0x0, mrt7_alpha_opt_disable = 0x1, pixen_zero_opt_disable = 0x0}
rdna2.reg.sx_blend_opt_epsilon {mrt0_epsilon = 0xf, mrt1_epsilon = 0x1, mrt2_epsilon = 0x9, mrt3_epsilon = 0xc, mrt4_epsilon = 0xf, mrt5_epsilon = 0x7, mrt6_epsilon = 0x7, mrt7_epsilon = 0x0}
rdna2.reg.sx_mrt0_blend_opt {color_src_opt = 0x0, color_dst_opt = 0x7, color_comb_fcn = 0x4, alpha_src_opt = 0x3, alpha_dst_opt = 0x6, alpha_comb_fcn = 0x3}
rdna2.reg.sx_mrt1_blend_opt {color_src_opt = 0x5, color_dst_opt = 0x6, color_comb_fcn = 0x2, alpha_src_opt = 0x7, alpha_dst_opt = 0x2, alpha_comb_fcn = 0x1}
rdna2.reg.sx_mrt2_blend_opt {color_src_opt = 0x6, color_dst_opt = 0x0, color_comb_fcn = 0x7, alpha_src_opt = 0x2, alpha_dst_opt = 0x0, alpha_comb_fcn = 0x0}
rdna2.reg.sx_mrt3_blend_opt {color_src_opt = 0x1, color_dst_opt = 0x5, color_comb_fcn = 0x7, alpha_src_opt = 0x5, alpha_dst_opt = 0x5, alpha_comb_fcn = 0x0}
rdna2.reg.sx_mrt4_blend_opt {color_src_opt = 0x0, color_dst_opt = 0x0, color_comb_fcn = 0x2, alpha_src_opt = 0x5, alpha_dst_opt = 0x0, alpha_comb_fcn = 0x7}
rdna2.reg.sx_mrt5_blend_opt {color_src_opt = 0x4, color_dst_opt = 0x5, color_comb_fcn = 0x0, alpha_src_opt = 0x0, alpha_dst_opt = 0x3, alpha_comb_fcn = 0x7}
rdna2.reg.sx_mrt6_blend_opt {color_src_opt = 0x2, color_dst_opt = 0x0, color_comb_fcn = 0x6, alpha_src_opt = 0x7, alpha_dst_opt = 0x3, alpha_comb_fcn = 0x3}
rdna2.reg.sx_mrt7_blend_opt {color_src_opt = 0x3, color_dst_opt = 0x5, color_comb_fcn = 0x5, alpha_src_opt = 0x0, alpha_dst_opt = 0x4, alpha_comb_fcn = 0x7}
rdna2.reg.sx_perfcounter0_select {perf_sel = 0xc4, perf_sel1 = 0x217, cntr_mode = 0xa, perf_mode1 = 0xa, perf_mode = 0x2}
rdna2.reg.sx_perfcounter0_select1 {perf_sel2 = 0x3e, perf_sel3 = 0x2da, perf_mode3 = 0x5, perf_mode2 = 0x0}
rdna2.reg.sx_perfcounter1_select {perf_sel = 0x37a, perf_sel1 = 0x214, cntr_mode = 0xe, perf_mode1 = 0x7, perf_mode = 0x7}
rdna2.reg.sx_perfcounter1_select1 {perf_sel2 = 0x65, perf_sel3 = 0x220, perf_mode3 = 0x8, perf_mode2 = 0xa}
rdna2.reg.sx_perfcounter2_select {perf_sel = 0x399, cntr_mode = 0xd, perf_mode = 0x0}
rdna2.reg.sx_perfcounter3_select {perf_sel = 0x2d7, cntr_mode = 0x1, perf_mode = 0x5}
rdna2.reg.sx_ps_downconvert {mrt0 = 0xb, mrt1 = 0x9, mrt2 = 0xf, mrt3 = 0x6, mrt4 = 0xa, mrt5 = 0x6, mrt6 = 0x6, mrt7 = 0x3}
rdna2.reg.sx_ps_downconvert_control {mrt0_fmt_mapping_disable = 0x1, mrt1_fmt_mapping_disable = 0x0, mrt2_fmt_mapping_disable = 0x1, mrt3_fmt_mapping_disable = 0x0, mrt4_fmt_mapping_disable = 0x1, mrt5_fmt_mapping_disable = 0x0, mrt6_fmt_mapping_disable = 0x1, mrt7_fmt_mapping_disable = 0x1}
rdna2.reg.ta_bc_base_addr_hi {address = 0x63}
rdna2.reg.ta_cs_bc_base_addr_hi {address = 0x8}
rdna2.reg.ta_perfcounter0_select {perf_sel = 0x295, perf_sel1 = 0x384, cntr_mode = 0xe, perf_mode1 = 0x0, perf_mode = 0xf}
rdna2.reg.ta_perfcounter0_select1 {perf_sel2 = 0x17, perf_sel3 = 0x1ce, perf_mode3 = 0x4, perf_mode2 = 0x8}
rdna2.reg.ta_perfcounter1_select {perf_sel = 0x169, cntr_mode = 0xf, perf_mode = 0x2}
rdna2.reg.tcp_perfcounter0_select {perf_sel = 0x1d2, perf_sel1 = 0x161, cntr_mode = 0xe, perf_mode1 = 0x3, perf_mode = 0xb}
rdna2.reg.tcp_perfcounter0_select1 {perf_sel2 = 0x3fd, perf_sel3 = 0x28b, perf_mode3 = 0xe, perf_mode2 = 0xd}
rdna2.reg.tcp_perfcounter1_select {perf_sel = 0xbc, perf_sel1 = 0xbf, cntr_mode = 0x7, perf_mode1 = 0xb, perf_mode = 0xb}
rdna2.reg.tcp_perfcounter1_select1 {perf_sel2 = 0x1d7, perf_sel3 = 0x312, perf_mode3 = 0x0, perf_mode2 = 0xe}
rdna2.reg.tcp_perfcounter2_select {perf_sel = 0x151, cntr_mode = 0x6, perf_mode = 0xf}
rdna2.reg.tcp_perfcounter3_select {perf_sel = 0x1c0, cntr_mode = 0xc, perf_mode = 0x0}
rdna2.reg.td_perfcounter0_select {perf_sel = 0x1ac, perf_sel1 = 0x387, cntr_mode = 0x3, perf_mode1 = 0xf, perf_mode = 0x4}
rdna2.reg.td_perfcounter0_select1 {perf_sel2 = 0x319, perf_sel3 = 0xe2, perf_mode3 = 0x2, perf_mode2 = 0xe}
rdna2.reg.td_perfcounter1_select {perf_sel = 0x3d9, cntr_mode = 0x3, perf_mode = 0x8}
rdna2.reg.utcl1_perfcounter0_select {perf_sel = 0x5a, counter_mode = 0xf}
rdna2.reg.utcl1_perfcounter1_select {perf_sel = 0x105, counter_mode = 0x1}
rdna2.reg.vgt_dma_base_hi {base_addr = 0xddbb}
rdna2.reg.vgt_dma_event_initiator {event_type = 0x1, address_hi = 0x55d1, extended_event = 0x1}
rdna2.reg.vgt_dma_index_type {index_type = 0x2, swap_mode = 0x2, buf_type = 0x0, rdreq_policy = 0x1, atc = 0x0, not_eop = 0x0, req_path = 0x1, mtype = 0x6, disable_instance_packing = 0x1}
rdna2.reg.vgt_draw_initiator {source_select = 0x1, major_mode = 0x1, sprite_en_r6xx = 0x1, not_eop = 0x1, use_opaque = 0x0, reg_rt_index = 0x2}
rdna2.reg.vgt_draw_payload_cntl {en_reg_rt_index = 0x0, en_prim_payload = 0x1, en_draw_vp = 0x0, en_vrs_rate = 0x1}
rdna2.reg.vgt_esgs_ring_itemsize {itemsize = 0x31a2}
rdna2.reg.vgt_es_per_gs {es_per_gs = 0x742}
rdna2.reg.vgt_event_address_reg {address_low = 0x910f527}
rdna2.reg.vgt_event_initiator {event_type = 0x9, address_hi = 0x4aff, extended_event = 0x0}
rdna2.reg.vgt_group_decr {decr = 0xa}
rdna2.reg.vgt_group_first_decr {first_decr = 0x5}
rdna2.reg.vgt_group_prim_type {prim_type = 0x10, retain_order = 0x1, retain_quads = 0x1, prim_order = 0x6}
rdna2.reg.vgt_group_vect_0_cntl {comp_x_en = 0x1, comp_y_en = 0x0, comp_z_en = 0x1, comp_w_en = 0x1, stride = 0xfa, shift = 0x2}
rdna2.reg.vgt_group_vect_0_fmt_cntl {x_conv = 0xd, x_offset = 0xf, y_conv = 0x6, y_offset = 0xa, z_conv = 0xd, z_offset = 0x5, w_conv = 0x9, w_offset = 0xa}
rdna2.reg.vgt_group_vect_1_cntl {comp_x_en = 0x1, comp_y_en = 0x0, comp_z_en = 0x0, comp_w_en = 0x1, stride = 0x8d, shift = 0x99}
rdna2.reg.vgt_group_vect_1_fmt_cntl {x_conv = 0x8, x_offset = 0xe, y_conv = 0xc, y_offset = 0x2, z_conv = 0xd, z_offset = 0x3, w_conv = 0xd, w_offset = 0x9}
rdna2.reg.vgt_gsvs_ring_itemsize {itemsize = 0x378a}
rdna2.reg.vgt_gsvs_ring_offset_1 {offset = 0x4506}
rdna2.reg.vgt_gsvs_ring_offset_2 {offset = 0x471}
rdna2.reg.vgt_gsvs_ring_offset_3 {offset = 0x14d8}
rdna2.reg.vgt_gs_instance_cnt {enable = 0x0, cnt = 0x39, en_max_vert_out_per_gs_instance = 0x0}
rdna2.reg.vgt_gs_max_vert_out {max_vert_out = 0x1fc}
rdna2.reg.vgt_gs_mode {mode = 0x5, reserved_0 = 0x0, cut_mode = 0x3, reserved_1 = 0x4, gs_c_pack_en = 0x1, reserved_2 = 0x1, es_passthru = 0x0, compute_mode = 0x0, fast_compute_mode = 0x1, element_info_en = 0x0, partial_thd_at_eoi = 0x0, suppress_cuts = 0x0, es_write_optimize = 0x0, gs_write_optimize = 0x1, onchip = 0x3}
rdna2.reg.vgt_gs_onchip_cntl {es_verts_per_subgrp = 0x3ca, gs_prims_per_subgrp = 0x10d, gs_inst_prims_in_subgrp = 0x18b}
rdna2.reg.vgt_gs_out_prim_type {outprim_type = 0x20, outprim_type_1 = 0x36, outprim_type_2 = 0x6, outprim_type_3 = 0x29, unique_type_per_stream = 0x1}
rdna2.reg.vgt_gs_per_es {gs_per_es = 0x66e}
rdna2.reg.vgt_gs_per_vs {gs_per_vs = 0xd}
rdna2.reg.vgt_gs_vert_itemsize {itemsize = 0x598f}
rdna2.reg.vgt_gs_vert_itemsize_1 {itemsize = 0x3926}
rdna2.reg.vgt_gs_vert_itemsize_2 {itemsize = 0x4c43}
rdna2.reg.vgt_gs_vert_itemsize_3 {itemsize = 0x51e1}
rdna2.reg.vgt_hos_cntl {tess_mode = 0x1}
rdna2.reg.vgt_hos_reuse_depth {reuse_depth = 0x50}
rdna2.reg.vgt_hs_offchip_param {offchip_buffering = 0xb8, offchip_granularity = 0x2}
rdna2.reg.vgt_index_type {index_type = 0x3, disable_instance_packing = 0x0}
rdna2.reg.vgt_ls_hs_config {num_patches = 0x0, hs_num_input_cp = 0x3c, hs_num_output_cp = 0x13}
rdna2.reg.vgt_multi_prim_ib_reset_en {reset_en = 0x1, match_all_bits = 0x0}
rdna2.reg.vgt_output_path_cntl {path_select = 0x0}
rdna2.reg.vgt_out_dealloc_cntl {dealloc_dist = 0x2f}
rdna2.reg.vgt_primitiveid_en {primitiveid_en = 0x0, disable_reset_on_eoi = 0x1, ngg_disable_provok_reuse = 0x0}
rdna2.reg.vgt_primitive_type {prim_type = 0x26}
rdna2.reg.vgt_reuse_off {reuse_off = 0x1}
rdna2.reg.vgt_shader_stages_en {ls_en = 0x3, hs_en = 0x1, es_en = 0x0, gs_en = 0x1, vs_en = 0x1, dynamic_hs = 0x0, dispatch_draw_en = 0x0, dis_dealloc_accum_0 = 0x0, dis_dealloc_accum_1 = 0x0, vs_wave_id_en = 0x0, primgen_en = 0x0, ordered_id_mode = 0x0, max_primgrp_in_wave = 0xc, gs_fast_launch = 0x0, hs_w32_en = 0x0, gs_w32_en = 0x0, vs_w32_en = 0x0, ngg_wave_id_en = 0x0, primgen_passthru_en = 0x0, primgen_passthru_no_msg = 0x1}
rdna2.reg.vgt_strmout_buffer_config {stream_0_buffer_en = 0x0, stream_1_buffer_en = 0xb, stream_2_buffer_en = 0xb, stream_3_buffer_en = 0x0}
rdna2.reg.vgt_strmout_config {streamout_0_en = 0x0, streamout_1_en = 0x1, streamout_2_en = 0x1, streamout_3_en = 0x0, rast_stream = 0x3, en_prims_needed_cnt = 0x0, rast_stream_mask = 0x7, use_rast_stream_mask = 0x1}
rdna2.reg.vgt_strmout_draw_opaque_vertex_stride {vertex_stride = 0x18f}
rdna2.reg.vgt_strmout_vtx_stride_0 {stride = 0x2c6}
rdna2.reg.vgt_strmout_vtx_stride_1 {stride = 0x17}
rdna2.reg.vgt_strmout_vtx_stride_2 {stride = 0x2b2}
rdna2.reg.vgt_strmout_vtx_stride_3 {stride = 0x322}
rdna2.reg.vgt_tess_distribution {accum_isoline = 0xd0, accum_tri = 0x88, accum_quad = 0x31, donut_split = 0x8, trap_split = 0x2}
rdna2.reg.vgt_tf_memory_base_hi {base_hi = 0x8e}
rdna2.reg.vgt_tf_param {type = 0x2, partitioning = 0x1, topology = 0x2, reserved_reduc_axis = 0x1, deprecated = 0x1, num_ds_waves_per_simd = 0x0, disable_donuts = 0x1, rdreq_policy = 0x3, distribution_mode = 0x0, detect_one = 0x1, detect_zero = 0x1, mtype = 0x4}
rdna2.reg.vgt_tf_ring_size {size = 0x46b3}
rdna2.reg.vgt_vertex_reuse_block_cntl {vtx_reuse_depth = 0x79}
rdna2.reg.vgt_vtx_cnt_en {vtx_cnt_en = 0x0}
rdna2.reg.wd_cntl_sb_buf_base_hi {base_hi = 0x43}
rdna2.reg.wd_index_buf_base_hi {base_hi = 0x46}
rdna2.reg.wd_pos_buf_base_hi {base_hi = 0x5e}
rdna2.pkt.gcr_cntl {gli_inv = 0x3, gl1_range = 0x2, glm_wb = 0x1, glm_inv = 0x0, glk_wb = 0x1, glk_inv = 0x0, glv_inv = 0x0, gl1_inv = 0x0, gl2_us = 0x0, gl2_range = 0x2, gl2_discard = 0x1, gl2_inv = 0x0, gl2_wb = 0x1, seq = 0x2, range_is_pa = 0x1}
rdna2.pkt.ib_control {ib_size = 0x169b9, chain = 0x1, pre_ena = 0x0, valid = 0x0}
rdna2.pkt.release_mem_op {glm_wb = 0x1, glm_inv = 0x0, glv_inv = 0x1, gl1_inv = 0x0, gl2_us = 0x0, gl2_range = 0x1, gl2_discard = 0x1, gl2_inv = 0x0, gl2_wb = 0x0, seq = 0x2}
