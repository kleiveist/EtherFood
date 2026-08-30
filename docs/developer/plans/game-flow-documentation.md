<!-- AUTO-GENERATED:backlink START -->
[← Back](plans.md)
<!-- AUTO-GENERATED:backlink END -->
# Game Flow Documentation ExecPlan

## Purpose / Big Picture

Record the newly defined eight-section game flow in the authoritative German
concept, align the detailed legacy concept pages that still describe the
playable sequence, and provide four review-only pixel-art concepts for the
flying hat-shaped guide companion.

## Current State

The authoritative source under `docs/content/de/` currently defines only the
general restoration order. The detailed pages under `docs/concept/game(de)/`
still use a six-section working outline. No visual concept for the guide
companion exists in the governed documentation media area.

## Scope and Non-Goals

In scope are German concept documentation, a recorded concept decision,
navigation and generated documentation metadata, and four preliminary PNG
concept variants. Game code, scenes, production sprites, final balancing,
English concept translations, and final designs for the three later
restoration regions remain out of scope.

## Concrete Steps

1. Separate confirmed flow decisions from tentative quantities and dimensions.
2. Add an authoritative game-flow page and decision record under
   `docs/content/de/`.
3. Align the detailed story, gameplay, content, and Heldenraum pages under
   `docs/concept/game(de)/` without changing unrelated canon.
4. Generate and document four review-only pixel-art guide variants.
5. Run documentation generators, focused term/link checks, style checks, and
   the repository gate where available.

## Progress

- 2026-08-30: Read repository rules, documentation governance, language policy,
  existing flow pages, media rules, and image-generation instructions.
- 2026-08-30: Confirmed a clean worktree before editing.
- 2026-08-30: Added the authoritative eight-section flow, guide-companion page,
  and approved EF-DEC-007 decision record.
- 2026-08-30: Aligned affected detailed story, gameplay, world-system, content,
  and production pages with the new structure.
- 2026-08-30: Generated, visually reviewed, and documented four preliminary
  pixel-art guide variants with alpha transparency.
- 2026-08-30: Regenerated documentation navigation, backlinks, and the existing
  detailed German summary artifacts.
- 2026-08-30: After visual review, retained guide variant 1 and removed the
  other three draft images from the documentation set.

## Surprises & Discoveries

- The authoritative `docs/content/de/` tree and the older detailed
  `docs/concept/game(de)/` tree overlap. The new decision must be recorded in
  the authoritative tree, while affected detailed pages need alignment to
  avoid conflicting playable sequences.
- The spoken name "Zenz" conflicts with established canon. The final section
  is therefore assigned to Semm, while Zehsen remains the guide-talisman source
  and is not turned into an end boss.
- The second generated green variant introduced scenery and a simulated
  checkerboard. A focused image edit removed the extra elements and produced a
  true alpha-channel result before the asset entered the workspace.
- The summary generator records its current working directory by default. Its
  deterministic outputs required path normalization so no container-specific
  path remains tracked.

## Decision Log

- Treat the four restoration regions, three Tatok passages, and one Semm finale
  as eight macro sections.
- Treat the grassland region as the detailed reference pattern; retain later
  restoration-region details as explicitly open.
- Keep waterfall depth and the number of lamp rooms as proposal values because
  the source description states uncertainty.
- Generate concept variants, not production-ready sprite sheets.

## Validation

- Documentation-index generator dry run and write mode: passed.
- Detailed German summary generation: passed for 69 Markdown files; generated
  paths normalized to repository-relative form.
- `git diff --check`: passed.
- `python3 tools/control.py style`: passed for 44 source files.
- Focused changed-document link audit: passed for 301 links; the known absent
  inherited Forge2D documentation tree was excluded.
- The retained guide PNG check passed; it is RGBA and contains transparency.
- Focused old-section/name and guide-versus-talisman audits: passed; old
  six-chapter wording remains only in decision history.
- `python3 tools/tests/test_source_hygiene.py`: 11 of 14 tests passed. Two
  failures and one error remain because the pre-existing public
  `docs/forge2d-template/` tree and its M06 report are absent.
- `python3 tools/control.py check`: did not pass because this local session has
  no repository virtual environment, pytest installation, or Godot 4 binary.

## Recovery / Idempotence

All authored changes are normal tracked files. Documentation generators are
deterministic and may be rerun after any structural edit. Generated image files
use unique variant filenames and do not overwrite existing media.

## Outcomes & Retrospective

The playable journey now has a stable eight-section macrostructure and a
detailed first-region reference without promoting tentative measurements or
later-region ideas to canon. The visible guide is separated from the hidden
Talisman, and one reviewed visual direction remains for further development.
No game code, English concept translation, or production sprite was changed.
