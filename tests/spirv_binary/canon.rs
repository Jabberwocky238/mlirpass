use mlirformat::{MlirOpt, Module};

/// Generic text with SSA names and block labels renumbered in order of appearance
pub struct Canon;

impl Canon {
    /// `module` in generic form, names numbered afresh after each `reset` (an op name in quotes)
    pub fn of(module: &Module<'_>, reset: &str) -> String {
        let text = MlirOpt::default().show(module).to_string();
        let mut names: Vec<String> = Vec::new();
        let mut out = String::new();
        let b = text.as_bytes();
        let mut i = 0;
        while i < b.len() {
            let c = b[i] as char;
            if !reset.is_empty() && text[i..].starts_with(reset) {
                names.clear();
            }
            let sigil = c == '%';
            if sigil && !(i > 0 && (b[i - 1] as char).is_ascii_alphanumeric()) {
                let mut j = i + 1;
                while j < b.len() && ((b[j] as char).is_ascii_alphanumeric() || b[j] == b'_' || b[j] == b'.' || b[j] == b'$' || b[j] == b'-') {
                    j += 1;
                }
                let tok = String::from(&text[i..j]);
                let k = names.iter().position(|n| *n == tok).unwrap_or_else(|| {
                    names.push(tok.clone());
                    names.len() - 1
                });
                out.push_str(&format!("{c}{k}"));
                i = j;
            } else {
                out.push(c);
                i += 1;
            }
        }
        out
    }
}

