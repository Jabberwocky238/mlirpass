//! Every affine map and integer set `mlir-opt` 22.1.8 printed in the fixtures parses back
//! (through the simplifying constructors) and prints the same.

mod common;

use std::collections::BTreeSet;

use common::Fixtures;
use mlirpass::{AffineMap, IntegerSet};

/// The `<...>` bodies after each `keyword`, brackets balanced.
fn bodies<'t>(text: &'t str, keyword: &str) -> Vec<&'t str> {
    let mut out = Vec::new();
    for (at, _) in text.match_indices(keyword) {
        let rest = &text[at + keyword.len()..];
        if !rest.starts_with('<') {
            continue;
        }
        let mut depth = 0;
        for (i, c) in rest.char_indices() {
            match c {
                '<' => depth += 1,
                '>' if !rest[..i].ends_with('-') && !rest[i..].starts_with(">=") => {
                    depth -= 1;
                    if depth == 0 {
                        out.push(&rest[1..i]);
                        break;
                    }
                }
                _ => {}
            }
        }
    }
    out
}

#[test]
fn affine_maps_print_as_mlir_opt() {
    let mut seen = BTreeSet::new();
    let mut bad = Vec::new();
    for run in Fixtures::runs() {
        let text = Fixtures::read(&run.stem, "generic");
        for body in bodies(&text, "affine_map") {
            if !seen.insert(body.to_owned()) {
                continue;
            }
            match AffineMap::parse(body) {
                Some(m) if m.to_string() == body => {}
                Some(m) => bad.push(format!("{body}  prints  {m}")),
                None => bad.push(format!("{body}  does not parse")),
            }
        }
        for body in bodies(&text, "affine_set") {
            if !seen.insert(body.to_owned()) {
                continue;
            }
            match IntegerSet::parse(body) {
                Some(m) if m.to_string() == body => {}
                Some(m) => bad.push(format!("{body}  prints  {m}")),
                None => bad.push(format!("{body}  does not parse")),
            }
        }
    }
    eprintln!("{} distinct maps and sets, {} differ", seen.len(), bad.len());
    for b in bad.iter().take(30) {
        eprintln!("  {b}");
    }
    assert!(bad.is_empty());
}
