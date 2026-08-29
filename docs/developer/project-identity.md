[← Developer documentation](index.md)

# Project identity

## Current identity

The repository and game name is exactly `ether-food`. The canonical repository
is `kleiveist/ether-food`.

The public description is:

> A top-down action RPG about restoring a lost world, reviving civilizations,
> and uncovering forgotten memories.

The project is in **Pre-production / concept development**. The German concept
is authoritative; this page documents repository identity and retained
technical boundaries rather than translating game design.

## Desired GitHub metadata

The versioned contract is
[`../../.github/repository-metadata.json`](../../.github/repository-metadata.json).

| Field | Desired value |
| --- | --- |
| Description | `A top-down action RPG about restoring a lost world, reviving civilizations, and uncovering forgotten memories.` |
| Homepage | Not configured |
| Topics | `2d-game`, `action-rpg`, `game-development`, `gdscript`, `godot`, `godot-4`, `python`, `top-down` |

There is no maintained canonical website, documentation deployment, store page,
or playable destination, so the expected homepage value is `null`. The JSON
contract records desired repository values; changing GitHub server-side
metadata is a separate authorized operation. Maintainers can audit live state
without mutation with:

```text
gh api repos/kleiveist/ether-food --jq '{description, homepage, topics}'
```

## Visible local identity

- [`config/project.toml`](../../config/project.toml) uses
  `display_name = "ether-food"` while retaining
  `template_id = "forge2d-template"` and `repository_language = "en"`.
- [`game/project.godot`](../../game/project.godot) uses
  `config/name="ether-food"`.
- The root README and community routes identify `kleiveist/ether-food`.

The technical repository language remains English even though the authoritative
game concept is German.

## Inherited Forge2D origin

`ether-food` was generated from Forge2D Template. The inherited runtime,
repository-local Python tooling, documentation history, and release machinery
remain available as the
[Inherited Forge2D technical foundation](../forge2d-template/index.md).

This restructure deliberately retains `template_id = "forge2d-template"`, the
`g2dtool` Python package, the `g2d` CLI, bootstrap classes, scene architecture,
export artifact names, and release tooling. Fully decoupling or renaming those
internals is separate follow-up work and must preserve compatibility through an
explicit technical plan.
