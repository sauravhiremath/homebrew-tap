# Saurav's Homebrew tap

Homebrew formulae for [Saurav Hiremath's](https://github.com/sauravhiremath) tools. A formula contains the instructions to install a package. This tap is a shared repository for those formulae.

## Installation

Install a package with its full name:

```sh
brew install sauravhiremath/tap/servicemon
```

Homebrew adds the tap and trusts the selected formula when you use its full name. You do not need to trust the whole tap.

To add the tap without installing a package:

```sh
brew tap sauravhiremath/tap
```

See the [Homebrew tap documentation](https://docs.brew.sh/Taps) for details.

## Available packages

| Formula | Description | Platform |
| --- | --- | --- |
| [servicemon](Formula/servicemon.rb) | CLI and dashboard to control local development services | macOS |

### Servicemon

See the [Servicemon source repository](https://github.com/sauravhiremath/servicemon) for first use, configuration, and service-control rules.

The formula builds from source using Homebrew Node and locked dependencies. Installation does not create user config, start the manager, or register login startup.

- Stop the manager before package or Node upgrades.
- Before uninstalling, disable startup and stop the manager.
- Config, retained logs, and Compose resources remain after package removal.

## Maintenance

See [CONTRIBUTING.md](CONTRIBUTING.md) for formula layout and the Servicemon update procedure.
