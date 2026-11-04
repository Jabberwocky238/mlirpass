//! `bufferization` passes.

mod convert_bufferization_to_memref;

mod buffer_results_to_out_params;
mod promote_buffers;
pub use convert_bufferization_to_memref::{ConvertBufferizationToMemref};
pub use buffer_results_to_out_params::{BufferResultsToOutParams};
pub use promote_buffers::{PromoteBuffersToStack};

mod one_shot_bufferize;
pub use one_shot_bufferize::OneShotBufferize;
