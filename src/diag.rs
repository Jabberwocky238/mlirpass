//! Diagnostics (`mlir/IR/Diagnostics`): what a pass reports about the IR, each at an op's location,
//! as many as it finds, kept on the [`Body`] until the driver takes them ([`Body::take_diagnostics`]).
//! A pass that refuses its input emits them and returns an `Err` (MLIR's `emitError` and
//! `signalPassFailure`); the `mlir-opt` command line prints them as `mlir-opt` does.

use alloc::string::String;
use alloc::vec::Vec;
use core::fmt;

use mlirformat::Str;

use crate::{Body, OpId};

/// `DiagnosticSeverity`.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum Severity {
    Error,
    Warning,
    Remark,
    Note,
}

impl Severity {
    const TABLE: [(Self, &'static str); 4] = [(Self::Error, "error"), (Self::Warning, "warning"), (Self::Remark, "remark"), (Self::Note, "note")];

    pub const fn name(self) -> &'static str {
        Self::TABLE[self as usize].1
    }
}

/// A note attached to a diagnostic (`Diagnostic::attachNote`), at its own location or none.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Note<'a> {
    pub loc: Option<Str<'a>>,
    pub message: String,
}

/// ⭐ One diagnostic: severity, where (the op's name and location when it was emitted), the message,
/// notes, and fields a tool attaches for machine readers (a refusal code, a contract section), which
/// the text form leaves out.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Diagnostic<'a> {
    pub severity: Severity,
    pub op: Option<Str<'a>>,
    pub loc: Option<Str<'a>>,
    pub message: String,
    pub notes: Vec<Note<'a>>,
    pub fields: Vec<(&'static str, String)>,
}

impl<'a> Diagnostic<'a> {
    /// A diagnostic at `op` (its name and location).
    pub fn at(body: &Body<'a>, op: OpId, severity: Severity, message: impl Into<String>) -> Self {
        Self { severity, op: Some(body[op].name.clone()), loc: body[op].loc.clone(), message: message.into(), notes: Vec::new(), fields: Vec::new() }
    }

    /// A diagnostic about no op (the input as a whole, an option).
    pub fn bare(severity: Severity, message: impl Into<String>) -> Self {
        Self { severity, op: None, loc: None, message: message.into(), notes: Vec::new(), fields: Vec::new() }
    }

    #[must_use]
    pub fn note(mut self, loc: Option<Str<'a>>, message: impl Into<String>) -> Self {
        self.notes.push(Note { loc, message: message.into() });
        self
    }

    #[must_use]
    pub fn field(mut self, key: &'static str, value: impl Into<String>) -> Self {
        self.fields.push((key, value.into()));
        self
    }

    /// The value of field `key`, if attached.
    pub fn get(&self, key: &str) -> Option<&str> {
        self.fields.iter().find(|(k, _)| *k == key).map(|(_, v)| v.as_str())
    }
}

/// The first `"file":line:col` in a location's text, as `file:line:col` (what `mlir-opt` prints a
/// diagnostic at: a name, call site or fused location shows its first file location).
fn file_line_col(loc: &str) -> Option<String> {
    let b = loc.as_bytes();
    let mut i = 0;
    while i < b.len() {
        if b[i] != b'"' {
            i += 1;
            continue;
        }
        let start = i + 1;
        let mut j = start;
        while j < b.len() && b[j] != b'"' {
            j += if b[j] == b'\\' { 2 } else { 1 };
        }
        let rest = loc.get(j + 1..)?;
        let digits = |s: &str| s.bytes().take_while(u8::is_ascii_digit).count();
        if let Some(r) = rest.strip_prefix(':') {
            let (l, after) = r.split_at(digits(r));
            if !l.is_empty()
                && let Some(c) = after.strip_prefix(':')
                && digits(c) > 0
            {
                return Some(alloc::format!("{}:{l}:{}", &loc[start..j], &c[..digits(c)]));
            }
        }
        i = j + 1;
    }
    None
}

/// `mlir-opt`'s printing: `file:line:col: error: message` (`loc(unknown)`: no position), each note on
/// a line of its own after it.
impl fmt::Display for Diagnostic<'_> {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        let at = |f: &mut fmt::Formatter<'_>, loc: &Option<Str<'_>>| match loc.as_deref().and_then(file_line_col) {
            Some(l) => write!(f, "{l}: "),
            None => Ok(()),
        };
        at(f, &self.loc)?;
        write!(f, "{}: {}", self.severity.name(), self.message)?;
        for n in &self.notes {
            f.write_str("\n")?;
            at(f, &n.loc)?;
            write!(f, "note: {}", n.message)?;
        }
        Ok(())
    }
}

impl<'a> Body<'a> {
    /// ⭐ Reports `d` (`emitError` / `emitWarning` / `emitRemark` with what is built on them).
    pub fn report(&mut self, d: Diagnostic<'a>) {
        self.diagnostics.push(d);
    }

    /// ⭐ `op->emitError(message)`.
    pub fn emit_error(&mut self, op: OpId, message: impl Into<String>) {
        let d = Diagnostic::at(self, op, Severity::Error, message);
        self.report(d);
    }

    /// The diagnostics reported so far, in order.
    pub fn diagnostics(&self) -> &[Diagnostic<'a>] {
        &self.diagnostics
    }

    /// ⭐ Takes the diagnostics reported so far (the driver, after the pipeline).
    pub fn take_diagnostics(&mut self) -> Vec<Diagnostic<'a>> {
        core::mem::take(&mut self.diagnostics)
    }

    /// Whether an error has been reported.
    pub fn has_errors(&self) -> bool {
        self.diagnostics.iter().any(|d| d.severity == Severity::Error)
    }
}
