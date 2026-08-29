<!-- AUTO-GENERATED:backlink START -->
[← Back](README.md)
<!-- AUTO-GENERATED:backlink END -->

# ether-food Repository Rules

Start at [docs/index.md](docs/index.md). The German concept under
`docs/content/de/` is
the content source of truth; its detailed
[governance](docs/content/de/01-baseline/documentation-governance.md) and
[language policy](docs/content/de/01-baseline/language-policy.md) are binding. Technical
documentation under `docs/developer/`, code, and technical identifiers are
English.

- Detailed English concept translations remain blocked until the overall
  concept is complete and the individual German source is approved.
- During the current concept phase, new gameplay systems may begin only as
  explicitly documented risk prototypes. Prototype code is not automatically
  production code.
- Changes to approved concepts require a documented decision and new version.
- Complex technical work uses living ExecPlans under `docs/developer/plans/`
  and follows `.agent/PLANS.md`.
- The [Inherited Forge2D technical foundation](docs/forge2d-template/index.md)
  remains preserved as a technical and historical reference.
- Update tests and relevant documentation when behavior changes. Follow the
  inherited mandatory Python and GDScript style guides.
- Never use destructive Git commands, commit secrets, or add an unreviewed
  dependency. Keep generated caches, binaries, and machine paths out of Git.
- Run the fastest relevant checks first; `g2d check` is the standard repository
  gate. Report only checks actually executed.
