<!-- AUTO-GENERATED:backlink START -->
[← Back](developer.md)
<!-- AUTO-GENERATED:backlink END -->

# Developer documentation

This English area owns technical, architectural, and implementation-specific
documentation for `ether-food`. It does not redefine the authoritative German
game concept.

## Project foundations

- [Documentation architecture](documentation-architecture.md)
- [Project identity](project-identity.md)
- [Game architecture](architecture/index.md) and its
  [template](architecture/_architecture-template.md)
- [Feature documentation](features/features.md) and its
  [template](features/_feature-template.md)
- [Game decisions](decisions/decisions.md) and their
  [template](decisions/_adr-template.md)
- [Game ExecPlans](plans/index.md) and their
  [template](plans/_execplan-template.md)

## Concept boundary

The [authoritative German concept](../content/de/index.md) owns game-design decisions.
Technical pages link to the approved source decision and describe implementation
only.

## Branch and CI workflow

Canon and storytelling documentation is maintained directly on `main`. Keep
those commits documentation-focused and run the relevant documentation checks
before pushing.

Future game implementation uses feature branches and pull requests into
`main`. This includes gameplay code, Godot scenes and resources, GDScript,
runtime architecture, and implementation tooling. Pull requests use CI and run
the fastest relevant checks first, with `g2d check` as the standard repository
gate. Add headless Godot checks and automated GDScript tests wherever the
engine and test tooling support them. If a Godot or GDScript limitation makes
a check unavailable, the pull request records that limitation, runs every
available substitute, and reports any required manual validation instead of
claiming the missing test passed.

## Inherited Forge2D technical foundation

The reusable runtime and tooling are documented in the
[Inherited Forge2D technical foundation](../forge2d-template/index.md), including
the [runtime overview](../forge2d-template/architecture/runtime-overview.md).
Do not duplicate its historical material here; record only `ether-food`
additions, deliberate departures, and integration boundaries.
