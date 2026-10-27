//! The passes a pipeline can name, with the op each is anchored on (`Passes.td`'s
//! `Pass<"name", "op">`). Nothing is global: a [`PassRegistry`] is handed to whoever parses a
//! pipeline; [`Passes`] is the default one, filled from [`PassSet`]s.

use alloc::boxed::Box;
use alloc::collections::BTreeMap;

use mlirformat::Error;

use super::{Options, Pass, PassDecl};

/// A registered pass.
pub struct PassInfo {
    pub name: &'static str,
    /// The op it runs on; `None`: any op.
    pub anchor: Option<&'static str>,
    pub make: fn(&Options<'_>) -> Result<Box<dyn Pass>, Error>,
}

/// ⭐ What a pipeline can name.
pub trait PassRegistry {
    /// The pass named `name`, if registered.
    fn pass(&self, name: &str) -> Option<&PassInfo>;
}

/// The default [`PassRegistry`]: passes by name.
#[derive(Default)]
pub struct Passes {
    by_name: BTreeMap<&'static str, PassInfo>,
}

impl Passes {
    /// Knows no pass.
    pub fn new() -> Self {
        Self::default()
    }

    /// Registers pass `T` under its `#[pass]` name and anchor.
    pub fn register<T>(&mut self) -> &mut Self
    where
        T: PassDecl + Pass + for<'o, 's> TryFrom<&'o Options<'s>, Error = Error> + 'static,
    {
        fn make<T: Pass + for<'o, 's> TryFrom<&'o Options<'s>, Error = Error> + 'static>(o: &Options<'_>) -> Result<Box<dyn Pass>, Error> {
            Ok(Box::new(T::try_from(o)?))
        }
        self.by_name.insert(T::NAME, PassInfo { name: T::NAME, anchor: T::ANCHOR, make: make::<T> });
        self
    }

    /// Registers every pass of set `S`.
    pub fn with<S: PassSet>(&mut self) -> &mut Self {
        S::register(self);
        self
    }
}

/// ⭐ Passes registered together: a module's, a target's.
pub trait PassSet {
    fn register(passes: &mut Passes);
}

/// `pass_set!(Name: PassA, PassB, ...)`: the unit struct `Name`, a [`PassSet`] of those passes.
#[macro_export]
macro_rules! pass_set {
    ($(#[$m:meta])* $name:ident: $($p:ty),* $(,)?) => {
        $(#[$m])*
        pub struct $name;

        impl $crate::PassSet for $name {
            fn register(passes: &mut $crate::Passes) {
                $(passes.register::<$p>();)*
            }
        }
    };
}

impl PassRegistry for Passes {
    fn pass(&self, name: &str) -> Option<&PassInfo> {
        self.by_name.get(name)
    }
}
