<!-- AUTO-GENERATED:backlink START -->
[← Back](plans.md)
<!-- AUTO-GENERATED:backlink END -->
# ether-food Documentation Restructure ExecPlan

## Purpose / Big Picture

Turn the repository created from Forge2D Template into the clearly identified
`ether-food` game project while preserving the inherited runtime and local
tooling. Establish a navigable, GitHub- and GitBook-compatible Markdown
architecture in which the authoritative German game concept can be developed,
tested, approved, and translated under explicit governance.

## Current State

The checkout is `kleiveist/ether-food`, but the public README, visible project
configuration, repository metadata, community files, and documentation hubs
still present Forge2D Template as the primary identity. Game-owned developer
documentation exists only as neutral template pages, and there is no German
concept hierarchy or English translation-status page.

The worktree was not clean at the start: `game/project.godot` already contained
an uncommitted Godot-editor reserialization, including reordered input entries
and `config/features`. That work is user-owned. This plan changes only the
`config/name` value in the current working copy and preserves every other
existing difference in that file.

Documentation contains `AUTO-GENERATED:docs-index` and
`AUTO-GENERATED:backlink` regions. Repository search found no current generator.
The M08 documentation plan records that a temporary `PyGitIndex.py` generator
created the existing regions and was deliberately removed afterward. This work
therefore updates affected regions manually in a deterministic, path-sorted
form and validates every relative link.

## Scope and Non-Goals

In scope are the German concept hierarchy and templates, English documentation
status, documentation/media governance, game-owned technical documentation,
root and community entry points, visible project identity, focused contract
tests, deterministic navigation updates, and validation of links, Mermaid,
encoding, file size, dependencies, and runtime-code scope.

Out of scope are gameplay implementation, complete story creation, balancing,
final machine or Zuro rules, detailed English concept translations, a
documentation framework or deployment, Git LFS, new dependencies, removal of
the inherited Forge2D documentation, and renaming the inherited `g2dtool`,
`g2d`, bootstrap, scene, export, or release internals.

## Concrete Steps

1. Record the initial worktree state, documentation-generation finding, current
   identity contracts, relevant tests, and inherited documentation boundaries.
2. Create the complete `docs/content/de/`, `docs/content/en/`, and
   `docs/assets/` structures
   with governed frontmatter, substantive German concept drafts, explicit open
   questions, acceptance criteria, and relative navigation.
3. Rewrite the root and documentation hubs, add the English developer pages,
   and update affected generated-marker regions deterministically.
4. Change only the approved visible identity fields and preserve all inherited
   tooling identifiers and the pre-existing `game/project.godot` edits.
5. Update community-facing project names and URLs, the changelog, and only the
   tests whose expected identity or documentation architecture intentionally
   changed.
6. Audit links, Mermaid fences, UTF-8, binary size, dependency/runtime scope,
   untranslated English content, and stale primary identities; then run the
   required focused and repository gates in fastest-first order.
7. Update this plan with actual progress, discoveries, decisions, validation
   evidence, and remaining follow-up work.

## Progress

- [x] 2026-08-29: Read the required repository rules, ExecPlan standard,
  entry-point documents, documentation templates, focused tests, relevant M08,
  M12, and M13 plans, repository metadata guidance, configurations, community
  forms, and developer-area overviews.
- [x] 2026-08-29: Inspected the Git status, preserved the pre-existing
  `game/project.godot` changes, confirmed the `ether-food` origin, and audited
  generated documentation markers and generator availability.
- [x] 2026-08-29: Created and linked the concept, translation-status, media,
  and developer documentation structures with governed German content and
  explicit unresolved design fields.
- [x] 2026-08-29: Applied the minimal visible project identity and community
  URL/text updates while retaining inherited technical identifiers and the
  pre-existing Godot reserialization.
- [x] 2026-08-29: Updated focused configuration, metadata, community, link,
  structure, frontmatter, translation-gate, and Mermaid tests.
- [x] 2026-08-29: Completed the required command attempts,
  environment-aware equivalents, final content/scope audits, and validation
  record.
- [x] 2026-08-29: Applied the requested follow-up layout by moving both language
  trees below `docs/content/`, refreshing path contracts, and running the
  session-provided `PyGitIndex.py` in dry-run and write modes.

## Surprises & Discoveries

- 2026-08-29: Git requires a command-local `safe.directory=/workspace` override
  because of container ownership. Using `git -c safe.directory=/workspace ...`
  avoids changing global or repository Git configuration.
- 2026-08-29: The documentation index generator is intentionally absent from
  the repository; M08 states that `PyGitIndex.py` was temporary and removed
  after generating the inherited navigation blocks. A maintained copy was
  later found in the session-provided tooling and used without copying it into
  the repository.
- 2026-08-29: Godot has already rewritten `game/project.godot` locally. The
  identity update must be a one-line patch against that working copy.
- 2026-08-29: The container has `/usr/bin/python3` but no `python` command,
  no installed `pytest` module, and no usable `.venv/bin/python`. Required
  command spellings that begin with `python` cannot start; dependency-free
  unittest equivalents remain available through `python3`.
- 2026-08-29: The first full unittest audit exposed two preserved release
  contracts: the root README must retain `- Version: \`0.1.0\``, and list items
  under `Unreleased` intentionally block release metadata validation. Restoring
  the version line and leaving the historical changelog unchanged produced a
  passing 173-test run without weakening release safety.

## Decision Log

- 2026-08-29: Treat German pages under `docs/content/de/` as the game-concept source of
  truth; English remains the language for public overview and technical
  developer documentation.
- 2026-08-29: The initial restructure maintained generated-marker regions
  manually because no generator existed inside the checkout. For the requested
  follow-up, use the session-provided `PyGitIndex.py` and keep its generated
  overview pages and backlinks tracked without adding the generator itself.
- 2026-08-29: Group the German concept and English translation-status entry
  under `docs/content/`, while retaining `docs/developer/` and the inherited
  Forge2D foundation as separate documentation domains.
- 2026-08-29: Keep Forge2D-specific history, tooling names, identifiers, export
  artifact names, and release internals unchanged. Full technical decoupling or
  renaming of remaining template internals is a separate follow-up project.
- 2026-08-29: Do not apply `.github/repository-metadata.json` values to GitHub
  server-side settings in this repository-editing task; document the desired
  live values for a separately authorized metadata operation.
- 2026-08-29: Keep `CHANGELOG.md` unchanged in this non-release task. Adding
  unreleased bullets would intentionally trip the inherited release gate; no
  stale canonical URL or false current heading exists there, and historical
  Forge2D release identity remains accurate.

## Validation

Validation results:

- `python -m pytest tools/tests/test_source_hygiene.py` — could not start because
  `python` is not installed in the container.
- `python -m pytest tools/tests/test_config.py tools/tests/test_repository_metadata.py`
  — could not start for the same reason.
- `python tools/control.py style` and `python tools/control.py check` — could not
  start for the same reason.
- `python3 tools/tests/test_source_hygiene.py` — passed, 13 tests, including
  relative links, structure, frontmatter, translation gate, and Mermaid fences.
- `python3 -m unittest discover -s tools/tests -p 'test_config.py' -v` — passed,
  5 tests.
- `python3 tools/tests/test_repository_metadata.py` — passed, 6 tests.
- `python3 tools/tests/test_community_health.py` — passed, 10 tests.
- `python3 tools/control.py style` — passed for 44 Python/GDScript files.
- `python3 -m unittest discover -s tools/tests -q` — passed, 173 tests after
  restoring the README release-version contract and retaining the unchanged
  historical changelog.
- `python3 tools/control.py check` — ran all available stages but did not pass:
  Doctor reported 9 passes, 2 warnings, and 1 failure; source style passed for
  44 files; Python tests could not start because `pytest` is absent; and the
  Godot integration test could not start because Godot 4 is absent. No `.venv`
  exists in this checkout.
- Plain `git diff --check` could not identify the worktree because Git rejects
  the container ownership. The command-local equivalent
  `git -c safe.directory=/workspace diff --check` passed without changing Git
  configuration. A separate trailing-whitespace scan also covered untracked
  documentation and found no violations.
- The required stale-identity search found no `Blobbite`, `# Forge2D Template`,
  `kleiveist/Forge2D-Template`, `Ether Food`, `EtherFood`, or `Soul Eater`
  outside `docs/forge2d-template/`. Remaining Forge2D references identify
  inherited history, internal compatibility names, or the documented origin.
- UTF-8 conversion validation passed for all new German, English-status, and
  media Markdown. Relative-link and Mermaid validation passed in the focused
  test. `docs/content/en/` contains only its canonical status page and generated
  navigation overview; `docs/assets/` contains no binary
  file; and no new documentation file exceeds 1 MiB.
- Git scope review found no dependency-manifest change and no gameplay script or
  scene change. The only game-path file is the already-dirty
  `game/project.godot`; this task changes only its `config/name` line while
  preserving the prior editor reserialization.
- Follow-up validation: the session-provided `PyGitIndex.py` completed both its
  dry-run and write runs. The first clean write run processed 37 documentation
  indices and 134 documentation backlinks, then regenerated the root README
  navigation.
- `python3 -m unittest tools.tests.test_source_hygiene` — passed, 14 tests,
  including the relocated paths and a generated-overview contract for every
  directory below `docs/content/`.
- `python3 tools/control.py style` — passed for 44 Python/GDScript files.
- `python3 -m unittest discover -s tools/tests -q` — passed, 174 tests.
- `git -c safe.directory=/workspace diff --check` — passed.
- Follow-up `python3 tools/control.py check` — ran but did not pass: Doctor
  reported 9 passes, 2 warnings, and 1 failure because Godot 4 is unavailable;
  the style stage passed for 44 files; Python tests could not start because
  `pytest` is unavailable; and the Godot integration test could not start.

## Recovery / Idempotence

All intended changes, including generated navigation pages, are versioned text;
the external generator is not copied into the repository. Re-running the
generator, tests, and audits is safe. Navigation is path-based and
deterministically ordered. Recovery must use focused edits that retain the
pre-existing `game/project.godot` work and all inherited Forge2D documents. Do
not use a destructive Git reset or remove generated/user-owned files.

## Outcomes & Retrospective

The repository now presents `ether-food` as its game and GitHub identity while
retaining the operational Forge2D foundation. The documentation retains 38
German concept-source Markdown files below `docs/content/de/`, one English
translation-status source below `docs/content/en/`, five media-policy entry
points, and two English developer foundation pages. PyGitIndex-generated
overviews now connect every content directory. Navigation, frontmatter, concept
status, decision history, translation gating, and prototype evidence are linked
and machine-checkable.

Approved baseline decisions cover the exact name, language split, genre,
Top-down perspective, restoration sequence, Vertical Slice combat scope, and
the rule that machines and Zuro remain undefined. Story detail, machine rules,
Zuro meaning and progression, ordinary enemy progression, landscape specifics,
presentation, balancing, and production scope remain explicitly open.

No gameplay system, dependency, publishing framework, binary placeholder, or
English concept mirror was added. Local dependency-free validation is green;
the complete repository gate remains unavailable until a repository `.venv`
with `pytest` and a compatible Godot 4 executable are provided.

Follow-up work is deliberately separate: make concept decisions and run their
risk prototypes; perform and record the final cross-domain consistency review;
apply desired GitHub metadata only with separate authorization; open the
translation gate only after concept completion; and plan any full technical
decoupling or renaming of retained Forge2D internals without changing export or
release compatibility implicitly.
