# Servicemon Homebrew tap

Install the CLI and dashboard for local development services:

```sh
brew install sauravhiremath/tap/servicemon
```

See the [source repository](https://github.com/sauravhiremath/servicemon) for first use, configuration, and service-control rules.

The formula builds from source using Homebrew Node and locked dependencies. Installation does not create user config, start the manager, or register login startup. Stop the manager before package or Node upgrades. Before uninstalling, disable startup and stop the manager. Config, retained logs, and Compose resources remain after package removal.

## Formula maintenance

Use `scripts/prepare-formula.mjs` in the source repository with the source archive's `manifest.json` and this directory as `--tap`. Set `--url` to the exact versioned GitHub release asset URL. The generator verifies the archive checksum and refuses to overwrite an existing formula. Preserve each old formula with its matching archive before replacing it.

```sh
brew style sauravhiremath/tap/servicemon
brew audit --strict --online --formula sauravhiremath/tap/servicemon
brew install --build-from-source sauravhiremath/tap/servicemon
brew test sauravhiremath/tap/servicemon
```

The tap workflow checks the formula. Source archive creation and publication commands are in the source repository's [release instructions](https://github.com/sauravhiremath/servicemon/blob/master/docs/releasing.md).

Use current stable release tags for workflow actions, not commit hash pins. Keep source archive checksums and dependency lockfiles.
