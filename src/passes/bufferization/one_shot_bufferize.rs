use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;

use mlirformat::Error;

use crate::{one_shot_bufferize, one_shot_module_bufferize, pass, AnalysisHeuristic, Body, BufferizationOptions, LayoutMapOption, MemorySpaceOption, OpId, Run};

#[pass("one-shot-bufferize", on = "builtin.module")]
pub struct OneShotBufferize {
    #[opt("allow-return-allocs-from-loops")]
    allow_return_allocs_from_loops: bool,
    #[opt("allow-unknown-ops")]
    allow_unknown_ops: bool,
    #[opt("analysis-fuzzer-seed")]
    fuzzer_seed: u32,
    #[opt("analysis-heuristic", default = String::from("bottom-up"))]
    heuristic: String,
    #[opt("bufferize-function-boundaries")]
    function_boundaries: bool,
    #[opt("check-parallel-regions", default = true)]
    check_parallel_regions: bool,
    #[opt("copy-before-write")]
    copy_before_write: bool,
    #[opt("dialect-filter")]
    dialect_filter: Vec<String>,
    #[opt("dump-alias-sets")]
    dump_alias_sets: bool,
    #[opt("no-analysis-func-filter")]
    no_analysis_func_filter: Vec<String>,
    #[opt("function-boundary-type-conversion", default = LayoutMapOption::Infer, from_str)]
    function_boundary_layout: LayoutMapOption,
    #[opt("must-infer-memory-space")]
    must_infer_memory_space: bool,
    #[opt("use-encoding-for-memory-space")]
    use_encoding_for_memory_space: bool,
    #[opt("test-analysis-only")]
    test_analysis_only: bool,
    #[opt("print-conflicts")]
    print_conflicts: bool,
    #[opt("unknown-type-conversion", default = LayoutMapOption::FullyDynamic, from_str)]
    unknown_layout: LayoutMapOption,
    #[opt("buffer-alignment", default = 64)]
    buffer_alignment: u64,
}

impl OneShotBufferize {
    fn options(&self) -> Result<BufferizationOptions, Error> {
        let heuristic = match &*self.heuristic {
            "bottom-up" => AnalysisHeuristic::BottomUp,
            "top-down" => AnalysisHeuristic::TopDown,
            "bottom-up-from-terminators" => AnalysisHeuristic::BottomUpFromTerminators,
            "fuzzer" => AnalysisHeuristic::Fuzzer(self.fuzzer_seed),
            h => return Err(Error(format!("invalid analysis heuristic: {h}"))),
        };
        if self.must_infer_memory_space && self.use_encoding_for_memory_space {
            return Err(Error("only one of 'must-infer-memory-space' and 'use-encoding-for-memory-space' are allowed in one-shot-bufferize".into()));
        }
        if self.unknown_layout == LayoutMapOption::Infer {
            return Err(Error("Invalid option: 'infer-layout-map' is not a valid value for 'unknown-type-conversion'".into()));
        }
        if self.copy_before_write && self.test_analysis_only {
            return Err(Error("Invalid option: 'copy-before-write' cannot be used with 'test-analysis-only'".into()));
        }
        if self.print_conflicts && !self.test_analysis_only {
            return Err(Error("Invalid option: 'print-conflicts' requires 'test-analysis-only'".into()));
        }
        if self.dump_alias_sets && !self.test_analysis_only {
            return Err(Error("Invalid option: 'dump-alias-sets' requires 'test-analysis-only'".into()));
        }
        if !self.function_boundaries && !self.no_analysis_func_filter.is_empty() {
            return Err(Error("Invalid option: 'no-analysis-func-filter' requires 'bufferize-function-boundaries'".into()));
        }
        let memory_space = if self.must_infer_memory_space {
            MemorySpaceOption::MustInfer
        } else if self.use_encoding_for_memory_space {
            MemorySpaceOption::Encoding
        } else {
            MemorySpaceOption::Default
        };
        Ok(BufferizationOptions {
            allow_return_allocs_from_loops: self.allow_return_allocs_from_loops,
            allow_unknown_ops: self.allow_unknown_ops,
            heuristic,
            copy_before_write: self.copy_before_write,
            dump_alias_sets: self.dump_alias_sets,
            function_boundary_layout: self.function_boundary_layout,
            unknown_layout: self.unknown_layout,
            memory_space,
            print_conflicts: self.print_conflicts,
            buffer_alignment: self.buffer_alignment,
            test_analysis_only: self.test_analysis_only,
            function_boundaries: self.function_boundaries,
            check_parallel_regions: self.check_parallel_regions,
            no_analysis_func_filter: self.no_analysis_func_filter.clone(),
            dialect_filter: self.dialect_filter.clone(),
            ..BufferizationOptions::default()
        })
    }
}

impl Run for OneShotBufferize {
    fn run<'a>(&self, body: &mut Body<'a>, op: OpId) -> Result<(), Error> {
        let o = self.options()?;
        if o.function_boundaries {
            return one_shot_module_bufferize(body, &o, op);
        }
        one_shot_bufferize(body, &o, op)
    }
}
