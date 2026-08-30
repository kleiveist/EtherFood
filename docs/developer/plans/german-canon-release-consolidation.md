<!-- AUTO-GENERATED:backlink START -->
[← Back](plans.md)
<!-- AUTO-GENERATED:backlink END -->
# German Canon Release Consolidation ExecPlan

## Purpose / Big Picture

Close all twelve decisions in `docs/concept/CHECKLIST-ZUR-FREIGABE.md` and
consolidate the resulting canon throughout the German concept documentation.
The finished documentation consistently defines names, cosmology, Era's time
system and Convection, Sol and Yol cycles, soul power, the hero's pact, and the
endgame return of souls without changing gameplay code, artwork, or the English
concept mirror.

## Current State

The German legacy concept under `docs/concept/game(de)/` still uses working
names and open alternatives, including Jator, an official Atea group name, a
24-hour Convergence every 20 to 25 Earth years, and unresolved soul-collection
models. The release checklist is still `review-required` and ADR-0001 is still
proposed.

The worktree was already dirty before this task. It contains a user-owned move
of concept assets from `docs/concept/assets/` toward `docs/assets/`, including
modified asset overview pages, deleted old paths, and new untracked paths.
Those changes must be preserved and are outside this plan.

## Scope and Non-Goals

In scope are the release checklist, German concept pages below
`docs/concept/game(de)/`, ADR-0005 through ADR-0007, the required page and file
renames, affected relative links and generated documentation navigation,
summaries, and index data. This plan also records its own progress under
`docs/developer/` as required by repository governance.

Out of scope are gameplay code, scenes, artwork, assets, dependencies, the
English concept mirror, the governed concept hierarchy under `docs/content/`,
and any new lore beyond the supplied decisions and their explicit follow-up
clarifications. A later explicit user request authorizes committing the
validated documentation and pushing it from `main`.

## Concrete Steps

1. Record the initial worktree and read repository governance, the checklist,
   all directly affected German pages, navigation, and generator guidance.
2. Accept and rewrite the checklist and name ADR, add ADR-0005, and consolidate
   the glossary and canon/open-question register.
3. Rename and rewrite the relevant world-history, faction, time-cycle, and
   cosmology pages; add the complete Era timekeeping page.
4. Propagate the approved pact, Tator, Zehsen, soul-power, and return-of-souls
   rules through story, gameplay, world-system, content, and production pages.
5. Audit every requested legacy term and every link to renamed files, then run
   the maintained documentation generator without manually editing generated
   marker regions.
6. Run validation in fastest-first order, record exact results here, and review
   the final diff for scope and preservation of pre-existing work.

## Progress

- [x] 2026-08-30: Read `AGENTS.md`, `.agent/PLANS.md`, the documentation hub,
  German governance and language policy, the release checklist, the directly
  named German concept pages, and their section navigation.
- [x] 2026-08-30: Recorded the initially dirty asset relocation and confirmed
  that it is unrelated user-owned work to preserve.
- [x] 2026-08-30: Consolidated the twelve accepted decisions in the checklist,
  glossary, canon register, ADR-0001, and new ADR-0005.
- [x] 2026-08-30: Propagated the approved cosmology, pact, Tator, Zehsen,
  soul-power, and return-of-souls rules through German world, story, gameplay,
  content, world-system, and production pages.
- [x] 2026-08-30: Renamed the time-cycle, pact/history, and World Keeper pages;
  added Era timekeeping; regenerated indexes, backlinks, and all three German
  summary artifacts; and passed a scoped relative-link audit for
  `docs/concept/`.
- [x] 2026-08-30: Completed canon, alias, chronology, time-value, link, scope,
  generated-output, whitespace, source-style, and available repository-gate
  validation; recorded all environment and pre-existing repository failures.
- [x] 2026-08-30: Reframed explicitly sanctioned ambiguities as
  culture-dependent traditions of scholars, separated them from editorial
  unknowns, documented the rule in ADR-0006, and corrected a residual passage
  that incorrectly called Tator's ally Zehsen his opponent.
- [x] 2026-08-30: Added the life-sustaining Era soul cycle, universal rebirth
  within the undisturbed cycle, the observed but unexplained creation of new
  souls, and whole-soul consumption by Ether entities as ADR-0007 and
  propagated the distinction from Talisman soul-power absorption.

## Surprises & Discoveries

- 2026-08-30: Repository governance names `docs/content/de/` as the current
  source-of-truth hierarchy, while this explicitly scoped task targets the
  older detailed German concept under `docs/concept/game(de)/`. The requested
  scope is followed without modifying either `docs/content/de/` or the English
  mirror.
- 2026-08-30: The maintained session-provided generators are `PyGitIndex.py`
  for indexes/backlinks and `PySummary.py` for `.summary` artifacts. The
  summary run used a relative displayed root so generated files contain no
  container machine path.
- 2026-08-30: Repository and Git history contain no numeric duration ranges
  for the four slow-run labels beyond the approved task input. The canonical
  cycle page therefore preserves every named category and its supplied unit
  relationship without inventing new endpoints.
- 2026-08-30: The focused source-hygiene test is not globally green because
  the checkout already lacks the complete `docs/forge2d-template/` tree: 32
  expected paths and the M06 report are absent, producing 675 cascading link
  failures. A separate concept-only relative-link audit passed with zero
  violations.
- 2026-08-30: An unrelated untracked `docs/.obsidian/` directory appeared
  while this task was in progress. It was not inspected, generated, or edited
  and remains user-owned work alongside the pre-existing asset relocation.
- 2026-08-30: The root README and several inherited documentation contracts
  already describe the Forge2D template while the expected
  `docs/forge2d-template/` tree is absent. This causes additional full-suite
  failures unrelated to the German canon changes.

## Decision Log

- 2026-08-30: Treat the twelve decisions supplied in the task as the new
  release authority for the targeted German working concept and preserve only
  explicitly labelled historical aliases or rejected variants.
- 2026-08-30: Keep Zehsen's precise intention and loyalty open. Record only
  that Zehsen is a World Keeper, Tator's ally, and the source of the Talisman.
- 2026-08-30: Leave the English concept mirror unchanged even where it retains
  older names, because the task explicitly prohibits editing it and German is
  the governing language.
- 2026-08-30: Do not invent missing numeric limits for slow Sol/Yol runs or an
  official absolute calendar epoch. Use the approved fixed units and a
  source-labelled notation template until a separate decision supplies those
  values.
- 2026-08-30: Attribute explicitly canonical source ambiguities to scholars
  from multiple cultures. Preserve their disagreement without turning
  editorial working notes, rejected dictation variants, or gameplay unknowns
  into in-world lore.
- 2026-08-30: Treat Era's natural soul cycle as life-sustaining: every soul in
  the undisturbed cycle is reborn, new souls demonstrably arise by an unknown
  process, and this renewal prevents Ether entities from exhausting Era's
  entire soul population. Whole-soul consumption remains distinct from the
  Talisman's non-destructive absorption of soul power.
- 2026-08-30: Keep canon and storytelling documentation directly on `main`.
  Use pull requests with CI for later game implementation, including automated
  Godot and GDScript checks wherever the available engine and test tooling can
  execute them; document unavailable checks and manual substitutes honestly.

## Validation

Planned validation:

- focused `rg` audits for all requested legacy and canon terms;
- relative-link validation and generator idempotence;
- `git status --short` and `git diff --check`;
- `python tools/control.py style`;
- `python tools/control.py check`;
- `g2d check` if it is available as the repository-standard equivalent.

Results so far:

- `PyGitIndex.py --dry-run` — passed; detected the new and renamed
  documentation.
- `PyGitIndex.py` — passed; regenerated marked documentation indexes and
  backlinks.
- `PySummary.py --py --ini --md --snippet --all` from the German concept root
  — passed; regenerated 67-file `summary.md`, `allsummary.md`, and `index.json`
  without a machine-specific stored root.
- Concept-only relative-link audit — passed with zero violations.
- `python3 tools/tests/test_source_hygiene.py` — ran 14 tests but did not pass:
  two failures and one error arise from the pre-existing absent
  `docs/forge2d-template/` tree and its resulting missing links; the other 11
  tests passed.
- Full requested-term `rg` audit — passed for German canon. Jator, Yol aliases,
  Atea/Athea/Are, Zen/Zem, and Fehrenreich remain only in explicitly labelled
  release, alias, source, or decision contexts. The deliberately stale English
  mirror still contains old working canon and was inspected but not edited, as
  explicitly required.
- Task-specific canon audit — passed across 67 German source pages: all 12
  checklist statuses, renames, chronology order, fixed time conversions,
  complete named Sol/Yol run taxonomy, permitted alias locations, summary path
  hygiene, and an empty English-concept diff were verified.
- `git status --short` — executed before and after the work; the original asset
  relocation remains present and untouched, together with the later unrelated
  `docs/.obsidian/` directory.
- `git diff --check` — passed.
- `python tools/control.py style` — could not start because `python` is not
  installed (exit 127).
- `python3 tools/control.py style` — passed for 44 Python/GDScript files.
- `python tools/control.py check` — could not start because `python` is not
  installed (exit 127).
- `python3 tools/control.py check` — ran every available stage but did not pass:
  Doctor reported 9 passes, 2 warnings, and 1 failure because Godot 4 is
  absent; source style passed; Python tests could not start because `pytest` is
  absent; and the Godot integration test could not run.
- `g2d check` — could not start because `g2d` is not installed (exit 127).
- `python3 -m unittest discover -s tools/tests -q` — ran 174 tests; 166 passed,
  4 failed, and 4 errored. Failures are the pre-existing missing
  `docs/forge2d-template/` contracts and root project-identity mismatch, not
  files changed by this task.
- Final concept-only relative-link audit — passed with zero violations.
- Final scope audit — passed: no tracked diff outside `docs/`, no English
  concept diff, and no machine-specific path in the generated German summaries
  or this plan.
- Follow-up documentation generation — passed; ADR-0006 and ADR-0007 were
  added to generated navigation and backlinks, and the relative-root German
  summaries now contain 69 source pages.
- Follow-up ambiguity and soul-cycle audit — passed across all 69 German
  source pages: 26 pages use the scholars framing, no abstract research wording
  or residual `Gegenspieler Tators` contradiction remains, and rebirth, new
  soul creation, whole-soul consumption, and non-destructive Talisman power
  absorption are all present as distinct rules.
- Follow-up concept-link audit — passed for 464 relative links with zero
  violations. `git diff --check`, the empty English-concept diff, the empty
  tracked non-documentation diff, and generated-summary path hygiene also
  passed again.

## Recovery / Idempotence

All planned changes are Markdown, JSON summary output, or deterministic file
renames. Re-running term audits, the documentation generator, and validation is
safe. Recovery must use focused patches and must not reset, delete, or overwrite
the pre-existing asset relocation or any unrelated worktree change.

## Outcomes & Retrospective

All twelve release questions are accepted and consistently represented in the
German working concept. The current canon now distinguishes Tator, Semm, and
Zehsen; defines Tatok, Hera, The Meridian, and Sphärenreich; and documents the
complete Era time system, Konvektion, and the named Sol/Yol runs without
inventing unavailable duration ranges.

The hero's pact, his natural death, Tator's plan, the second journey, and the
return of the liberated souls to Era now form one chronology. Soul identity,
soul power, and the natural soul cycle are consistently separated. The cycle
now sustains Era, returns every undisturbed soul to rebirth, and is renewed by
the demonstrable but unexplained creation of new souls. Zehsen's confirmed
actions are documented while scholars preserve conflicting interpretations of
his intention, and Semm remains an independent further antagonist.

Source-dependent ambiguities now belong to a defined scholars tradition:
multiple cultures may preserve incompatible meanings or models without
overriding fixed canon. This treatment covers The Meridian, Hera's spatial
language, Sol and Yol imagery, Sphärenreich terminology, World Keeper names,
Zehsen, and the constructed world's unreliable records while keeping
production unknowns explicitly editorial.

Navigation, backlinks, and all three German summary outputs were regenerated.
No game code, artwork content, dependency, or English concept page was changed.
The final validated documentation and the pre-existing asset relocation are
authorized for a direct `main` commit and push by the follow-up request.
Repository-wide validation remains partially blocked by pre-existing missing
Forge2D documentation and unavailable Python/Godot tooling; the focused canon,
link, formatting, style, and scope checks passed.
