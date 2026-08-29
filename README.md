# ether-food

[![CI](https://github.com/kleiveist/ether-food/actions/workflows/ci.yml/badge.svg)](https://github.com/kleiveist/ether-food/actions/workflows/ci.yml)

A top-down action RPG about restoring a lost world, reviving civilizations,
and uncovering forgotten memories.

**Status:** Pre-production / concept development

- Version: `0.1.0`

## Design snapshot

- Top-down action-RPG perspective and exploration
- A restoration arc that begins with nature and landscape, then brings back
  inhabitants, settlements, memories, and history
- Hero abilities that grow through interaction with restored memories and world
  history
- A concept Vertical Slice scoped to attack, dodge, block, and ranged magic
- Machine mechanics and the project-specific term Zuro remain open design areas
  rather than implemented or approved rules

The authoritative game concept is written in German under
[`docs/de/`](docs/de/index.md). Detailed English translations will begin only
after the entire German concept is complete and each individual source document
is approved. The English [documentation status](docs/en/index.md) explains this
translation gate.

<!-- AUTO-GENERATED:docs-index START -->

## Documentation

- 📚 [Documentation hub](docs/index.md)
- [Authoritative German game concept](docs/de/index.md)
- [English documentation status](docs/en/index.md)
- [Technical developer documentation](docs/developer/index.md)
- [Inherited Forge2D technical foundation](docs/forge2d-template/index.md)

## Repository files

- [Repository rules](AGENTS.md)
- [Changelog](CHANGELOG.md)
- [Contributing guide](CONTRIBUTING.md)
- [Security policy](SECURITY.md)

<!-- AUTO-GENERATED:docs-index END -->

## Technical quick start

`ether-food` retains the repository-local Python and Godot 4 tooling inherited
from Forge2D Template. Python 3.11 or newer is required; Godot 4.7.2 is the
currently tested engine version.

```text
git clone https://github.com/kleiveist/ether-food.git
cd ether-food
python tools/control.py install --dry-run
python tools/control.py install --yes
python tools/control.py godot4 run
```

Use `python3` where `python` is unavailable, or `py -3.11` on Windows. The
installer keeps Python packages in the repository-local `.venv` and does not use
system pip. See the inherited
[installation guide](docs/forge2d-template/tooling/installation.md) before
allowing setup changes.

Run focused checks first, then the repository gates:

```text
python tools/control.py style
python tools/control.py check
```

The inherited `g2d` CLI, export artifact names, bootstrap architecture, and
release tooling remain intentionally unchanged. Their technical documentation,
including the [repository metadata history](docs/forge2d-template/tooling/repository-metadata.md),
is preserved as foundation material rather than game identity.

## Contributing, security, and license

Read [CONTRIBUTING.md](CONTRIBUTING.md) before proposing a change. Report
suspected vulnerabilities only through the private process in
[SECURITY.md](SECURITY.md). The project is licensed under the
[MIT License](LICENSE).
