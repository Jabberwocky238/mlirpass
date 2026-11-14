pub struct Rng(u64);

impl From<u64> for Rng {
    fn from(seed: u64) -> Self {
        Self(seed)
    }
}

impl Rng {
    pub fn next(&mut self) -> u64 {
        self.0 = self.0.wrapping_add(0x9E37_79B9_7F4A_7C15);
        let mut z = self.0;
        z = (z ^ (z >> 30)).wrapping_mul(0xBF58_476D_1CE4_E5B9);
        z = (z ^ (z >> 27)).wrapping_mul(0x94D0_49BB_1331_11EB);
        z ^ (z >> 31)
    }

    pub fn below(&mut self, n: usize) -> usize {
        (self.next() % n as u64) as usize
    }

    pub fn range(&mut self, lo: usize, hi: usize) -> usize {
        lo + self.below(hi - lo + 1)
    }

    pub fn chance(&mut self, p: f64) -> bool {
        ((self.next() >> 11) as f64 / (1u64 << 53) as f64) < p
    }

    pub fn pick<'s, T>(&mut self, xs: &'s [T]) -> &'s T {
        &xs[self.below(xs.len())]
    }

    pub fn weighted(&mut self, weights: &[u32]) -> usize {
        let mut at = self.below(weights.iter().sum::<u32>() as usize) as u32;
        weights.iter().position(|&w| at < w || { at -= w; false }).unwrap_or(0)
    }
}
