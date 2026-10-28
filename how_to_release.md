# How to release

## Bump the version

Bump `@version` in `mix.exs` and `version` in `native/yamlrustler/Cargo.toml`
(run `cargo update -p yamlrustler` in `native/yamlrustler` to update
Cargo.lock), for example to 0.3.1. Rename `## Unreleased` in `CHANGELOG.md` to
the new version and date, and update the version in the installation
instructions in `README.md`. Commit and push to `main`.

## Tag the release

    git tag v0.3.1
    git push origin v0.3.1

The tag must match `@version` in `mix.exs`, or the build fails.

## Let the workflow finish

`.github/workflows/release.yml` builds a NIF for every target, attaches them to
the GitHub release, and then commits the regenerated
`checksum-Elixir.YamlRustler.exs` to `main`. Consumers pick the release up from
that commit on; the tag itself still has the previous checksums.

If the checksum job fails, regenerate the file by hand once every artifact is
on the release, and commit it to `main`:

    YAML_RUSTLER_BUILD=1 mix rustler_precompiled.download YamlRustler --all --print

The build targets in the workflow and the `targets` in `lib/yaml_rustler.ex`
must stay in sync: every target listed there needs a checksum entry.

## Useful links
https://hexdocs.pm/rustler_precompiled/precompilation_guide.html
