// A compute control stream; cdm.expected is what Mesa's agx_pack writes for it, Stream Terminate last
// (scripts/agx_pack_oracle.sh). After `agx-end, agx-layout`: @code at 0x100000000.
image.memory @code {
  image.stream @cdm attributes {cdm} {
    agx.cdm_barrier {usc_cache_inval = true, unk_4 = true}
    agx.cdm_launch_word_0 {uniform_register_count = 64, texture_state_register_count = 8, sampler_state_register_count = 1, preshader_register_count = 16, mode = 0}
    agx.cdm_launch_word_1 {pipeline = 0x1000c0}
    agx.cdm_global_size {x = 256, y = 4, z = 1}
    agx.cdm_local_size {x = 32, y = 1, z = 1}
  }
}
