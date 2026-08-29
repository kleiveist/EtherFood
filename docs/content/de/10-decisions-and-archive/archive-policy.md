---
title: "Archivrichtlinie"
language: de
status: approved
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](10-decisions-and-archive.md)
<!-- AUTO-GENERATED:backlink END -->
[← Entscheidungen und Archiv](index.md)

# Archivrichtlinie

## Zweck

Die Archivrichtlinie erhält Entscheidungsverlauf und Testbelege, ohne veraltete
Inhalte als aktuelle Konzeptquelle erscheinen zu lassen.

## Bestätigte Regeln

- Ersetzte Konzeptdokumente erhalten `status: superseded` und einen Link zur
  aktuellen Version oder Entscheidung.
- Freigegebene Inhalte werden nicht still überschrieben; eine neue Version und
  ein Protokolleintrag sind erforderlich.
- Historische Forge2D-Pläne, Berichte, Entscheidungen und Releases bleiben in
  `docs/forge2d-template/` und sind nicht Teil des Spielkonzepts.
- Geheimnisse, personenbezogene Testdaten, generierte Caches und lokale
  Maschinenpfade werden nicht archiviert.

## Arbeitsablauf

Vor Ablösung werden Abhängigkeiten und Übersetzungen geprüft. Das alte Dokument
bleibt lesbar, erhält den Ersetzungsverweis und wird aus aktueller Navigation
entfernt. Das Entscheidungsprotokoll verbindet alte und neue Fassung.

## Eingaben und Ausgaben

Eingabe ist eine freigegebene Ersetzungsentscheidung. Ausgaben sind neue
Dokumentversion, `superseded`-Kennzeichnung, aktualisierte Links und gegebenenfalls
veralteter Übersetzungsstatus.

## Abhängigkeiten und veränderbare Werte

Die Richtlinie hängt von Governance, Statusübersicht und Übersetzungstor ab.
Aufbewahrungsdauer und ein späteres physisches Archivverzeichnis sind noch nicht
entschieden.

## Feedback, Sonderfälle und Risiken

Links müssen klar anzeigen, dass eine Seite historisch ist. Reine Umbenennungen,
Teilablösungen und zusammengeführte Entscheidungen benötigen eindeutige
Weiterleitungen, damit keine parallelen Wahrheiten entstehen.

## Offene Fragen

- Wann wird ein separates Archivverzeichnis benötigt?
- Wie werden große oder externe Testmedien langfristig referenziert?
- Welche redaktionellen Änderungen erfordern keine neue Konzeptversion?

## Abnahmekriterien

- Kein `superseded`-Dokument wird als aktuelle Regel in der Hauptnavigation
  geführt.
- Ersetzungsbeziehungen und betroffene Übersetzungen sind nachvollziehbar.
- Historische Template-Dokumente bleiben unverändert als technische Referenz
  erhalten.

## Verwandte Dokumente

- [Entscheidungsprotokoll](decision-log.md)
- [Dokumentationsgovernance](../01-baseline/documentation-governance.md)
- [Konzeptstatus](../01-baseline/concept-status.md)
