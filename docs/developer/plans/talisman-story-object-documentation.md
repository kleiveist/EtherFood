<!-- AUTO-GENERATED:backlink START -->
[← Back](plans.md)
<!-- AUTO-GENERATED:backlink END -->
# Talisman Story Object Documentation ExecPlan

## Purpose / Big Picture

Consolidate the Talisman's established narrative role in the authoritative
German concept, align the detailed German concept page, and provide five
review-only pixel-art object directions without selecting a canonical design.

## Current State

The Talisman's origin and three narrative functions are distributed across the
story, terminology, canon, and endgame pages. The authoritative source has no
dedicated Talisman page or governed image set. The worktree already contains
uncommitted documentation work from the preceding game-flow task.

## Scope and Non-Goals

In scope are German concept documentation, documentation media, navigation,
generated documentation metadata, and five preliminary PNG concepts. Game
code, English concept translations, production sprites, a final object design,
new powers, and a new explanation of Zehsen's motivation are out of scope.

## Concrete Steps

1. Consolidate only already established Talisman facts and explicit unknowns.
2. Add an authoritative German source page and align affected overview pages.
3. Generate, inspect, and document five visually distinct pixel-art variants.
4. Regenerate navigation and summaries, then run focused consistency checks.

## Progress

- 2026-08-30: Read repository governance, language and media rules, relevant
  Talisman pages, and the image-generation skill and prompting references.
- 2026-08-30: Confirmed and preserved the existing dirty documentation tree.
- 2026-08-30: Generated and inspected five separate pixel-art directions with
  alpha transparency.
- 2026-08-30: Added the authoritative Talisman page and governed media entry.
- 2026-08-30: After visual review, retained the split-prism variant 2 and
  removed the other four draft images from the documentation set.

## Surprises & Discoveries

- The spoken object name is ambiguous. Existing canon consistently uses
  `Talisman`, so the new page retains that term instead of introducing a new
  proper name.
- The possible spoken reading `Sense` can be explored safely as one visual
  variant without making a scythe shape canonical.

## Decision Log

- Treat shape, material, color, scale, and carrying method as open visual
  design, while origin, story timing, functions, and metaphysical limits remain
  established.
- Keep the visible guide companion separate from the initially unnoticed
  Talisman.
- Use five individual transparent PNG concepts rather than a combined sheet so
  variants can be reviewed or removed independently.

## Validation

- Documentation-index generator dry run and write mode: passed; the new source,
  media, and plan pages are present in generated navigation and have backlinks.
- Detailed German summary generation: passed for 69 Markdown files; generated
  roots were normalized to repository-relative form.
- Focused relative-link audit: passed for 86 links with zero missing targets.
- The retained Talisman PNG metadata and copy-integrity checks passed; it is
  byte-identical to its generated source, uses RGBA, and contains transparency.
- `git diff --check`: passed.
- `python3 tools/control.py style`: passed for 44 Python and GDScript files.
- `python3 tools/control.py check`: did not pass because this session has no
  Godot 4 binary or pytest installation and no repository virtual environment;
  source style passed within the gate.
- Scope checks: no tracked diff exists in the English concept or outside
  `docs/`, and generated summaries contain no machine-specific path.

## Recovery / Idempotence

All authored changes are normal files. The documentation generators may be
rerun after structural edits. Unique image filenames avoid overwriting existing
media; the original generated outputs remain outside the repository.

## Outcomes & Retrospective

The Talisman now has one authoritative German source page that distinguishes
its established origin, staged story functions, and soul-power boundary from
its still-open visual and character design. The reviewed split-prism direction
remains available without promoting generated detail to canon. No game code or
English concept translation was changed.
