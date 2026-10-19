//! Shared by the integration tests: the `mlir-opt` 22.1.8 fixtures (see `scripts/fixtures.py`).

#![allow(dead_code)]

use std::fs;
use std::path::{Path, PathBuf};

/// One kept `RUN:` line: `<name>.<k>`.
pub struct Run {
    pub stem: String,
    pub args: Vec<String>,
}

pub struct Fixtures;

impl Fixtures {
    pub fn dir() -> PathBuf {
        Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures")
    }

    /// Every kept RUN line, sorted.
    pub fn runs() -> Vec<Run> {
        let mut out: Vec<Run> = fs::read_dir(Self::dir())
            .unwrap()
            .filter_map(|e| {
                let name = e.ok()?.file_name().into_string().ok()?;
                let stem = name.strip_suffix(".args")?.to_owned();
                let args = fs::read_to_string(Self::dir().join(&name)).ok()?.lines().map(str::to_owned).collect();
                Some(Run { stem, args })
            })
            .collect();
        out.sort_by(|a, b| a.stem.cmp(&b.stem));
        out
    }

    /// `<stem>.<kind>.mlir`: `in`, `out` or `generic`.
    pub fn read(stem: &str, kind: &str) -> String {
        fs::read_to_string(Self::dir().join(format!("{stem}.{kind}.mlir"))).unwrap()
    }

    /// The `-split-input-file` chunks of one output.
    pub fn chunks(text: &str) -> Vec<&str> {
        text.split("\n// -----\n").filter(|c| !c.trim().is_empty()).collect()
    }

    /// Replaces SSA names and block names by `_`, so two printings are comparable.
    pub fn anon(s: &str) -> String {
        let name = |c: &char| c.is_ascii_alphanumeric() || matches!(c, '_' | '$' | '.' | '-');
        let mut out = String::new();
        let mut it = s.chars().peekable();
        while let Some(c) = it.next() {
            out.push(c);
            if matches!(c, '%' | '^') {
                out.push('_');
                while it.peek().is_some_and(name) {
                    it.next();
                }
            }
        }
        out
    }
}
