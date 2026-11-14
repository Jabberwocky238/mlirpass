use alloc::vec::Vec;

use mlirformat::Dim;

pub struct Broadcast;

impl Broadcast {
    pub fn shape(a: &[i64], b: &[i64]) -> Option<Vec<i64>> {
        let mut r = if a.len() > b.len() { a.to_vec() } else { b.to_vec() };
        let n = r.len();
        for (k, (x, y)) in a.iter().rev().zip(b.iter().rev()).enumerate() {
            let (x, y) = (*x, *y);
            r[n - 1 - k] = if x == Dim::DYNAMIC || y == Dim::DYNAMIC {
                if x > 1 {
                    x
                } else if y > 1 {
                    y
                } else if x == 1 {
                    y
                } else if y == 1 {
                    x
                } else {
                    Dim::DYNAMIC
                }
            } else if x == y || y == 1 {
                x
            } else if x == 1 {
                y
            } else {
                return None;
            };
        }
        Some(r)
    }

    pub fn known(shapes: &[Vec<i64>]) -> bool {
        let rank = shapes.iter().map(Vec::len).max().unwrap_or(0);
        for i in 0..rank {
            let mut dynamic = false;
            let mut non_one: Option<i64> = None;
            for e in shapes {
                let d = if i >= e.len() { 1 } else { e[e.len() - i - 1] };
                if d == 1 {
                    continue;
                }
                if d == Dim::DYNAMIC {
                    if dynamic || non_one.is_some() {
                        return false;
                    }
                    dynamic = true;
                }
                if non_one.is_some_and(|n| n != d) {
                    return false;
                }
                non_one = Some(d);
            }
        }
        true
    }
}
