# Servicemon Homebrew tap

Install the CLI and dashboard for local development services:

```sh
brew tap sauravhiremath/tap
brew trust --formula sauravhiremath/tap/servicemon
brew install sauravhiremath/tap/servicemon
```

See the [source repository](https://github.com/sauravhiremath/servicemon) for first use, configuration, and service-control rules.

The formula builds from source using Homebrew Node and locked dependencies. Installation does not create user config, start the manager, or register login startup. Stop the manager before package or Node upgrades. Before uninstalling, disable startup and stop the manager. Config, retained logs, and Compose resources remain after package removal.

## Formula maintenance

Run the **Tap update** workflow for an existing public Servicemon release:

```sh
gh workflow run tests.yml --repo sauravhiremath/homebrew-tap \
  -f version=<version> -F publish=false
```

It downloads the source archive and manifest, verifies the checksum, generates the formula, and runs Homebrew style, online audit, source installation, and functional tests. It saves the checked formula as a seven-day workflow artifact.

To commit the checked update, run the same command with `-F publish=true`. A separate job writes the formula to `main` only after all checks pass. The workflow uses this repository's `GITHUB_TOKEN`; no source-repository token is needed. The source release must already be public.

For local formula generation, use `scripts/prepare-formula.mjs` from the checked source archive. Pass the manifest path with `--manifest` and the tap directory with `--tap`. Set `--url` to the exact versioned release asset URL. Preserve each old formula with its matching archive before replacing it.

Source archive creation and publication commands are in the source repository's [release instructions](https://github.com/sauravhiremath/servicemon/blob/master/docs/releasing.md).

Use current stable release tags for workflow actions, not commit hash pins. Keep source archive checksums and dependency lockfiles.
