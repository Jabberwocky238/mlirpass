use alloc::string::String;
use alloc::vec::Vec;
use core::fmt;

use mlirformat::Str;

use crate::{Body, OpId};

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

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Note<'a> {
    pub loc: Option<Str<'a>>,
    pub message: String,
}

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
    pub fn at(body: &Body<'a>, op: OpId, severity: Severity, message: impl Into<String>) -> Self {
        Self { severity, op: Some(body[op].name.clone()), loc: body[op].loc.clone(), message: message.into(), notes: Vec::new(), fields: Vec::new() }
    }

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

    pub fn get(&self, key: &str) -> Option<&str> {
        self.fields.iter().find(|(k, _)| *k == key).map(|(_, v)| v.as_str())
    }
}

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
    pub fn report(&mut self, d: Diagnostic<'a>) {
        self.diagnostics.push(d);
    }

    pub fn emit_error(&mut self, op: OpId, message: impl Into<String>) {
        let d = Diagnostic::at(self, op, Severity::Error, message);
        self.report(d);
    }

    pub fn diagnostics(&self) -> &[Diagnostic<'a>] {
        &self.diagnostics
    }

    pub fn take_diagnostics(&mut self) -> Vec<Diagnostic<'a>> {
        core::mem::take(&mut self.diagnostics)
    }

    pub fn has_errors(&self) -> bool {
        self.diagnostics.iter().any(|d| d.severity == Severity::Error)
    }
}
