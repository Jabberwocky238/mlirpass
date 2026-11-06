//! ⭐ The aliases `mlir-opt` prints (`AliasInitializer`): `#map` for an affine map, `#set` for an
//! integer set (the builtin dialect's), and the dialect attributes that name themselves
//! (`OpAsmAttrInterface::getAlias`: `#loop_unroll`, `#di_file`, `#sparse`, ...). Aliases are
//! inlined on import ([`Body::import`]); printing makes them again, named and ordered as the C++
//! printer does.

use alloc::collections::{BTreeMap, BTreeSet};
use alloc::format;
use alloc::string::String;
use alloc::vec::Vec;
use core::ops::Range;

use mlirformat::Attribute;

use crate::{Body, OpId};

/// The builtin attributes with an alias: how their text starts, and the alias.
const BUILTIN: [(&str, &str); 2] = [("affine_map<", "map"), ("affine_set<", "set")];

/// The dialect attributes whose alias is their mnemonic (`genMnemonicAlias`), or another name
/// (`sparse_tensor.encoding`): the attribute's name, and the alias.
const DIALECT: &[(&str, &str)] = &[
    ("llvm.access_group", "access_group"),
    ("llvm.alias_scope", "alias_scope"),
    ("llvm.alias_scope_domain", "alias_scope_domain"),
    ("llvm.di_basic_type", "di_basic_type"),
    ("llvm.di_common_block", "di_common_block"),
    ("llvm.di_compile_unit", "di_compile_unit"),
    ("llvm.di_composite_type", "di_composite_type"),
    ("llvm.di_derived_type", "di_derived_type"),
    ("llvm.di_file", "di_file"),
    ("llvm.di_global_variable", "di_global_variable"),
    ("llvm.di_global_variable_expression", "di_global_variable_expression"),
    ("llvm.di_imported_entity", "di_imported_entity"),
    ("llvm.di_label", "di_label"),
    ("llvm.di_lexical_block", "di_lexical_block"),
    ("llvm.di_lexical_block_file", "di_lexical_block_file"),
    ("llvm.di_local_variable", "di_local_variable"),
    ("llvm.di_module", "di_module"),
    ("llvm.di_namespace", "di_namespace"),
    ("llvm.di_null_type", "di_null_type"),
    ("llvm.di_string_type", "di_string_type"),
    ("llvm.di_subprogram", "di_subprogram"),
    ("llvm.di_subroutine_type", "di_subroutine_type"),
    ("llvm.loop_annotation", "loop_annotation"),
    ("llvm.loop_distribute", "loop_distribute"),
    ("llvm.loop_interleave", "loop_interleave"),
    ("llvm.loop_licm", "loop_licm"),
    ("llvm.loop_peeled", "loop_peeled"),
    ("llvm.loop_pipeline", "loop_pipeline"),
    ("llvm.loop_unroll", "loop_unroll"),
    ("llvm.loop_unroll_and_jam", "loop_unroll_and_jam"),
    ("llvm.loop_unswitch", "loop_unswitch"),
    ("llvm.loop_vectorize", "loop_vectorize"),
    ("llvm.mmra_tag", "mmra_tag"),
    ("llvm.tbaa_root", "tbaa_root"),
    ("llvm.tbaa_tag", "tbaa_tag"),
    ("llvm.tbaa_type_desc", "tbaa_type_desc"),
    ("ml_program.extern", "extern"),
    ("sparse_tensor.encoding", "sparse"),
];

/// One aliased attribute: its text, its alias, and how deep aliases nest in it (1: none).
struct Seen {
    text: String,
    alias: &'static str,
    depth: u32,
}

/// The aliased attributes of one printing, in the order the printer first visits them
/// (`AliasInitializer::visit`: an attribute before those inside it); `taken`: alias names already
/// defined.
pub(crate) struct Aliases {
    seen: Vec<Seen>,
    index: BTreeMap<String, usize>,
    taken: BTreeSet<String>,
}

impl Aliases {
    pub(crate) fn new(taken: impl IntoIterator<Item = String>) -> Self {
        Self { seen: Vec::new(), index: BTreeMap::new(), taken: taken.into_iter().collect() }
    }

    /// Past the string literal opening at `i`.
    fn skip_string(bytes: &[u8], mut i: usize) -> usize {
        i += 1;
        while i < bytes.len() && bytes[i] != b'"' {
            i += if bytes[i] == b'\\' { 2 } else { 1 };
        }
        i + 1
    }

    /// The end of the `<...>` opening at `i`: nested, string literals skipped; an `->` or a
    /// `>=` closes nothing.
    fn close(bytes: &[u8], mut i: usize) -> Option<usize> {
        let mut depth = 0;
        while i < bytes.len() {
            match bytes[i] {
                b'"' => {
                    i = Self::skip_string(bytes, i);
                    continue;
                }
                b'<' => depth += 1,
                b'>' if bytes[i - 1] != b'-' && bytes.get(i + 1) != Some(&b'=') => {
                    depth -= 1;
                    if depth == 0 {
                        return Some(i + 1);
                    }
                }
                _ => {}
            }
            i += 1;
        }
        None
    }

    /// The outermost aliased attributes in `text`, outside string literals, with their aliases.
    fn spans(text: &str) -> Vec<(Range<usize>, &'static str)> {
        let bytes = text.as_bytes();
        let ident = |c: u8| c.is_ascii_alphanumeric() || b"_$.".contains(&c);
        let mut out = Vec::new();
        let mut i = 0;
        while i < bytes.len() {
            let after_ident = i > 0 && (ident(bytes[i - 1]) || bytes[i - 1] == b'#' || bytes[i - 1] == b'!');
            match bytes[i] {
                b'"' => {
                    i = Self::skip_string(bytes, i);
                    continue;
                }
                b'a' if !after_ident => {
                    if let Some((kw, alias)) = BUILTIN.iter().find(|(kw, _)| text[i..].starts_with(kw))
                        && let Some(end) = Self::close(bytes, i + kw.len() - 1)
                    {
                        out.push((i..end, *alias));
                        i = end;
                        continue;
                    }
                }
                b'#' => {
                    let start = i + 1;
                    let mut j = start;
                    while j < bytes.len() && ident(bytes[j]) {
                        j += 1;
                    }
                    if let Some((_, alias)) = DIALECT.iter().find(|(name, _)| &text[start..j] == *name) {
                        let end = if bytes.get(j) == Some(&b'<') { Self::close(bytes, j) } else { Some(j) };
                        if let Some(end) = end {
                            out.push((i..end, *alias));
                            i = end;
                            continue;
                        }
                    }
                    i = j.max(i + 1);
                    continue;
                }
                _ => {}
            }
            i += 1;
        }
        out
    }

    /// Visits an aliased attribute, then those inside it; its alias depth.
    fn visit_one(&mut self, text: &str, alias: &'static str) -> u32 {
        if let Some(&k) = self.index.get(text) {
            return self.seen[k].depth;
        }
        let k = self.seen.len();
        self.index.insert(String::from(text), k);
        self.seen.push(Seen { text: String::from(text), alias, depth: 1 });
        // What is inside the attribute: past its own name.
        let inner = text.find('<').map_or("", |s| &text[s + 1..]);
        let mut depth = 0;
        for (r, a) in Self::spans(inner) {
            depth = depth.max(self.visit_one(&inner[r], a));
        }
        self.seen[k].depth = depth + 1;
        depth + 1
    }

    /// Visits the aliased attributes in `text`, in order.
    pub(crate) fn visit(&mut self, text: &str) {
        for (r, alias) in Self::spans(text) {
            self.visit_one(&text[r], alias);
        }
    }

    /// The generic printer's order (`DummyAliasOperationPrinter::printGenericOp`): an op's
    /// regions (each block's argument types, then its ops), its operand types, result types,
    /// then its attributes, properties among them, sorted by name.
    pub(crate) fn visit_generic(&mut self, b: &Body<'_>, op: OpId) {
        for r in &b[op].regions {
            for blk in &b[*r].blocks {
                for a in &b[*blk].args {
                    self.visit(&format!("{}", b[*a].ty));
                }
                for o in &b[*blk].ops {
                    self.visit_generic(b, *o);
                }
            }
        }
        self.visit_own(b, op);
    }

    /// [`visit_generic`](Self::visit_generic) of the root `op`, the ops of its blocks (the
    /// functions) visited in parallel on `x`: each run of them by an `Aliases` of its own, which
    /// gives its attributes in the order it first met them; those are then visited here in the
    /// runs' order, which is the order a serial visit meets them in. The formatting of every
    /// type and attribute, the cost, is the runs'; what is visited again is one text per
    /// aliased attribute.
    pub(crate) fn visit_generic_in<X: moremath::Executor + Sync>(&mut self, b: &Body<'_>, op: OpId, x: &X) {
        for r in &b[op].regions {
            for blk in &b[*r].blocks {
                for a in &b[*blk].args {
                    self.visit(&format!("{}", b[*a].ty));
                }
                let ops = &b[*blk].ops;
                let step = ops.len().div_ceil(x.threads() * 4).max(1);
                let runs: Vec<_> = ops
                    .chunks(step)
                    .map(|run| {
                        move || {
                            let mut a = Aliases::new([]);
                            run.iter().for_each(|o| a.visit_generic(b, *o));
                            a.seen
                        }
                    })
                    .collect();
                self.replay(x.execute(runs));
            }
        }
        self.visit_own(b, op);
    }

    /// The aliased attributes other `Aliases` saw, in their order and then each one's.
    fn replay(&mut self, runs: Vec<Vec<Seen>>) {
        for seen in runs.into_iter().flatten() {
            self.visit_one(&seen.text, seen.alias);
        }
    }

    /// [`visit`](Self::visit) of `text`, its lines cut into runs scanned in parallel on `x`
    /// (no aliased attribute spans a line).
    pub(crate) fn visit_in<X: moremath::Executor + Sync>(&mut self, text: &str, x: &X) {
        let runs: Vec<_> = Self::lines(text, x.threads() * 4)
            .map(|run| {
                move || {
                    let mut a = Aliases::new([]);
                    a.visit(run);
                    a.seen
                }
            })
            .collect();
        self.replay(x.execute(runs));
    }

    /// `text` cut at line ends into about `n` runs.
    fn lines(text: &str, n: usize) -> impl Iterator<Item = &str> {
        let step = text.len().div_ceil(n.max(1)).max(1);
        let mut rest = text;
        core::iter::from_fn(move || {
            if rest.is_empty() {
                return None;
            }
            let cut = rest.as_bytes().get(step..).and_then(|t| t.iter().position(|c| *c == b'\n')).map_or(rest.len(), |i| step + i + 1);
            let (run, tail) = rest.split_at(cut);
            rest = tail;
            Some(run)
        })
    }

    /// What [`visit_generic`](Self::visit_generic) visits of `op` itself, after its regions.
    fn visit_own(&mut self, b: &Body<'_>, op: OpId) {
        for v in b[op].operands.iter().chain(&b[op].results) {
            self.visit(&format!("{}", b[*v].ty));
        }
        let (properties, attributes) = b.placed(&b[op]);
        let mut attrs: Vec<(&str, Option<&Attribute<'_>>)> = match &properties {
            Some(Attribute::Dict(ps)) => ps.iter().map(|a| (&*a.name, a.value.as_ref())).collect(),
            _ => Vec::new(),
        };
        attrs.extend(attributes.iter().map(|a| (&*a.name, a.value.as_ref())));
        attrs.sort_by(|x, y| x.0.cmp(y.0));
        for (_, a) in attrs {
            if let Some(a) = a {
                self.visit(&format!("{a}"));
            }
        }
    }

    /// `uniqueAliasNameIndex`: `base`, else `base1`, `base2`, ... (`base_1` after a digit), the
    /// first not taken.
    fn unique(&mut self, base: &str, counts: &mut BTreeMap<String, u32>) -> String {
        if self.taken.insert(String::from(base)) {
            return String::from(base);
        }
        let probe = if base.ends_with(|c: char| c.is_ascii_digit()) { format!("{base}_") } else { String::from(base) };
        let count = counts.entry(probe.clone()).or_insert(1);
        loop {
            let name = format!("{probe}{count}");
            *count += 1;
            if self.taken.insert(name.clone()) {
                return name;
            }
        }
    }

    /// `text` with each outermost aliased attribute by its alias.
    fn replace(text: &str, names: &BTreeMap<String, String>) -> String {
        let mut out = String::new();
        let mut at = 0;
        for (r, _) in Self::spans(text) {
            out += &text[at..r.start];
            match names.get(&text[r.clone()]) {
                Some(n) => {
                    out.push('#');
                    out += n;
                }
                None => out += &text[r.clone()],
            }
            at = r.end;
        }
        out + &text[at..]
    }

    /// `initializeAliases` and the printing: the aliases sorted by depth, then name (stably: in
    /// visiting order), numbered; their definitions first, each with the aliases inside it, then
    /// `text` with each aliased attribute by its alias, its lines cut into runs replaced in
    /// parallel on `x`.
    pub(crate) fn apply<X: moremath::Executor + Sync>(mut self, text: String, x: &X) -> String {
        if self.seen.is_empty() {
            return text;
        }
        let mut order: Vec<usize> = (0..self.seen.len()).collect();
        order.sort_by(|a, b| {
            let (x, y) = (&self.seen[*a], &self.seen[*b]);
            (x.depth, x.alias).cmp(&(y.depth, y.alias))
        });
        let mut counts = BTreeMap::new();
        let mut names: BTreeMap<String, String> = BTreeMap::new();
        let mut defs = Vec::new();
        for k in order {
            let name = self.unique(self.seen[k].alias, &mut counts);
            names.insert(self.seen[k].text.clone(), name.clone());
            defs.push((name, k));
        }
        let mut out = String::new();
        for (name, k) in defs {
            // The definition prints what is inside it by alias, not itself.
            let full = &self.seen[k].text;
            let body = match full.find('<') {
                Some(s) => format!("{}{}", &full[..=s], Self::replace(&full[s + 1..], &names)),
                None => full.clone(),
            };
            out += &format!("#{name} = {body}\n");
        }
        let names = &names;
        let runs: Vec<_> = Self::lines(&text, x.threads() * 4).map(|run| move || Self::replace(run, names)).collect();
        x.execute(runs).into_iter().fold(out, |out, run| out + &run)
    }
}
