# Maintaining this tap

## Formula layout

Keep each package's formula in `Formula/<package>.rb`. Add the package to the table in [README.md](README.md), with its supported platform and source link. Multiple formulae share this tap; a new package does not need a separate tap repository.

Keep package-specific build, test, and release steps separate. The **Tap update** workflow in `.github/workflows/tests.yml` updates only Servicemon.

## Updating Servicemon

Run the **Tap update** workflow for an existing public Servicemon release. Replace `<version>` with the release version without the `v` prefix:

```sh
gh workflow run tests.yml --repo sauravhiremath/homebrew-tap \
  -f version=<version> -F publish=false
```

The workflow downloads the source archive and manifest, verifies the checksum, generates the formula, and runs Homebrew style, online audit, source installation, and functional tests. It saves the checked formula as a seven-day workflow artifact.

To commit the checked update, run the same command with `-F publish=true`. A separate job writes the formula to `main` only after all checks pass. The workflow uses this repository's `GITHUB_TOKEN`; no source-repository token is needed. The source release must already be public.

For local formula generation, use `scripts/prepare-formula.mjs` from the checked source archive. Pass the manifest path with `--manifest` and the tap directory with `--tap`. Set `--url` to the exact versioned release asset URL. Preserve each old formula with its matching archive before replacing it.

Source archive creation and publication commands are in Servicemon's [release instructions](https://github.com/sauravhiremath/servicemon/blob/master/docs/releasing.md).

## Dependencies and checksums

Use current stable release tags for workflow actions, not commit hash pins. Keep source archive checksums and dependency lockfiles.
