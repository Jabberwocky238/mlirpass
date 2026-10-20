//! Proc macros for mlirpass: passes and pattern sets are declared where they are written.
//!
//! - `#[pass("name", on = "op", extra = ["opt", ..])]` on a struct: its `mlir-opt` name, the op it
//!   is anchored on, and its options (fields marked `#[opt("key", default = expr)]`, read with
//!   `OptionValue`, or with `FromStr` when marked `from_str`); `check = path` validates the
//!   result (`fn(&Self) -> Result<(), Error>`). Generates `PassDecl` and `TryFrom<&Options>`;
//!   the struct implements `Run`, and is a `Pass` through it.
//! - The same on a `fn(body, op) -> Result<(), Error>`: a unit pass struct (the name in
//!   CamelCase, or `ty = Name`) whose `Run` is that body.
//! - `#[patterns(converter, flag: bool, ..)]` on an `impl` block: each method marked
//!   `#[lowering("root", .., benefit = n, when = expr, untyped)]` goes into a generated
//!   `populate(patterns, [tc,] [opts,] flags..)`, in declaration order. `options = Type`: the
//!   methods also take `opts` (`OptLowering`; `plain` opts one out); `extra = path` is called
//!   last with the same arguments, for patterns that are not methods.
//! - `#[map("from" => "to", ..)]` on that `impl` block: a lowering generated whole. Without
//!   `via`, the one-to-one rewrite (`fastmath` / `overflow` attributes converted for llvm, `fp`
//!   failing on unsupported floats, `unconstrained` without a rounding mode, `scalar` not
//!   unrolling vectors); with `via = template(args..)`, a call of the family's template
//!   `template(cr, op, operands, "to", [opts,] args..)`. The impl also gets `ROOTS`.
//! - With `builder = ctor` on `#[patterns]`, a `#[lowering]` method whose first parameter is
//!   not `cr` is declared by its signature: it takes the builder `ctor(cr, op)`, the
//!   operands as `ValueId`s in order and anything else `FromOp` gives, and returns what
//!   replaces the op (`Replacement`).

use proc_macro::TokenStream;
use syn::Error;

mod blocks;
mod ops;
mod pass;
mod patterns;

/// `#[pass("name", on = "op", extra = [..])]`: see the crate docs.
#[proc_macro_attribute]
pub fn pass(attr: TokenStream, item: TokenStream) -> TokenStream {
    pass::PassArgs::expand(attr.into(), item.into()).unwrap_or_else(Error::into_compile_error).into()
}

/// `#[patterns(..)]`: see the crate docs.
#[proc_macro_attribute]
pub fn patterns(attr: TokenStream, item: TokenStream) -> TokenStream {
    patterns::PatternsArgs::expand(attr.into(), item.into()).unwrap_or_else(Error::into_compile_error).into()
}

/// `#[ops(b, fmf = f)]` on a fn: its arithmetic builds ops through `b` (see `OpsRewrite`):
/// `+ - * / %` call `b.add(l, r, f)`.., unary `-` `b.neg(x, f)`, `& | ^` `b.and(l, r)`..,
/// float literals `b.cst(x)`; `fm(g, expr)` builds `expr` with flags `g`. Code meant as plain
/// Rust goes in a macro call (`plain!(..)`), which is left alone.
#[proc_macro_attribute]
pub fn ops(attr: TokenStream, item: TokenStream) -> TokenStream {
    ops::OpsArgs::expand(attr.into(), item.into()).unwrap_or_else(Error::into_compile_error).into()
}

/// `blocks!(b; ..)`: a region's blocks in their final order. The first is the block `b` is
/// in (its arguments bound by name); the others are created after it, in order, with
/// arguments of the given types. Then each is filled in turn: `b.at` set to it, its
/// statements run with `#[ops]` arithmetic, so a block sees the names, arguments and values
/// of those before it. `b` needs `at`, `block(&[types])` and `arg(block, i)`.
#[proc_macro]
pub fn blocks(input: TokenStream) -> TokenStream {
    blocks::Blocks::expand(input.into()).unwrap_or_else(Error::into_compile_error).into()
}
