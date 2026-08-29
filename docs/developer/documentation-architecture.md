<!-- AUTO-GENERATED:backlink START -->
[← Back](developer.md)
<!-- AUTO-GENERATED:backlink END -->
[← Developer documentation](index.md)

# Documentation architecture

This page defines the ownership, language, status, and navigation boundaries for
`ether-food` documentation.

## Documentation domains

| Domain | Path | Language | Responsibility |
| --- | --- | --- | --- |
| Authoritative game concept | [`docs/content/de/`](../content/de/index.md) | German | Vision, story, world, mechanics, progression, presentation, prototype findings, and concept decisions |
| English documentation status | [`docs/content/en/`](../content/en/index.md) | English | Translation-gate status and a pointer to the current public overview; no detailed mirror yet |
| Game developer documentation | [`docs/developer/`](index.md) | English | Game-owned technical architecture, implementation decisions, features, and ExecPlans |
| Inherited Forge2D technical foundation | [`docs/forge2d-template/`](../forge2d-template/index.md) | English | Preserved template history, runtime architecture, tooling, plans, reports, decisions, and releases |
| Reserved player/release areas | `docs/player-guide/`, `docs/in-game-help/`, `docs/case-studies/`, `docs/release-manual/` | English until separately governed | Future deliverables; not current concept sources |

The inherited Forge2D material is a technical reference, not the game concept
and not the public identity of `ether-food`.

## Sources of truth

German concept documents are authoritative for game design. Only a concept page
with `status: approved` is binding. English developer pages are authoritative
for implementation and architecture only; they must link to, rather than
reinterpret, game-design decisions. Historical Forge2D pages remain
authoritative for the inherited foundation they describe.

## Concept status model

Concept frontmatter uses exactly `idea`, `draft`, `testing`, `approved`, or
`superseded`. Only `approved` is binding. Changes to approved content require a
recorded decision, a new document version, a decision-log entry, and stale
translation handling when relevant. The central status is maintained in
[`concept-status.md`](../content/de/01-baseline/concept-status.md).

## Translation gate

Detailed English translations remain blocked until the complete German concept
has status `complete` and the individual German source document is `approved`.
The root README and [`docs/content/en/index.md`](../content/en/index.md) are concise English
orientation pages, not translated design specifications.

## Paths and filenames

- Directory and file names are English, lowercase, and kebab-case except for
  established repository files and preserved historical Forge2D names.
- Every documentation area uses `index.md` as its canonical entry point.
- Language-owned game content stays below `docs/content/`: German concept
  content is under `docs/content/de/`, while the English translation-status
  entry point is under `docs/content/en/`. English technical content stays
  below `docs/developer/`.
- Technical identifiers remain English and use backticks in German prose.
- Superseded pages remain traceable under the archive policy; do not silently
  overwrite an approved concept.

## Media structure

Documentation media follows [`docs/assets/README.md`](../assets/README.md):
editable sources under `assets/source/`, exports under `assets/images/`,
diagrams under `assets/diagrams/`, and governed video references under
`assets/videos/`. Prefer Mermaid for simple flows. No documentation framework,
Git LFS configuration, or media dependency is implied.

## Link and navigation conventions

- Use repository-relative Markdown links so GitHub and GitBook can resolve them.
- Link to the nearest canonical `index.md` and provide a short parent link on
  subordinate pages.
- Do not use machine-specific absolute paths in source documents.
- Keep Mermaid fences balanced and use relative paths for media.
- Existing `AUTO-GENERATED:docs-index` and `AUTO-GENERATED:backlink` comments
  mark navigation regions maintained by the session-provided `PyGitIndex.py`.
  The generator remains external to the repository, is run after structural
  documentation changes, and its deterministic output is validated by the
  documentation link tests.

See the German [documentation governance](../content/de/01-baseline/documentation-governance.md)
and [language policy](../content/de/01-baseline/language-policy.md) for binding concept
rules.
