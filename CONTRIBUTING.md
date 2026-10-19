# Contributing

Every kind of contribution is welcome: bug reports, questions, feature requests, documentation
fixes, new passes, small typo PRs and large refactors alike. No template or prior discussion is
required — open an issue or a pull request whenever you like.

## Issues

Anything goes. For a bug, the MLIR text, the pipeline, and what `mlir-opt` 22.1.8 prints help the most.

## Pull requests

1. Fork the repository and branch from `main`.
2. Make your change.
3. Run the tests:

   ```sh
   cargo test -p mlirpass
   cargo build -p mlirpass --no-default-features
   ```

4. Open the pull request. CI runs the same tests.

Unfinished or draft pull requests are fine too.

## License

By contributing, you agree that your contributions are licensed under the MIT License.
