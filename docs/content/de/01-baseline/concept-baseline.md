---
title: "Konzeptgrundlage"
language: de
status: approved
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](01-baseline.md)
<!-- AUTO-GENERATED:backlink END -->
[← Verbindliche Konzeptgrundlage](index.md)

# Konzeptgrundlage

## Zweck der Konzeptphase

Die Konzeptphase macht `ether-food` vollständig beschreibbar, prüfbar und
entscheidbar, bevor Kernsysteme als Produktionssysteme umgesetzt werden.

## Quelle der Wahrheit

Die deutsche Konzeptdokumentation unter `docs/content/de/` ist die inhaltliche Quelle
der Wahrheit. Nur der Status `approved` ist verbindlich. Technische
Entwicklerdokumentation beschreibt Implementierung, ersetzt aber keine
Spielkonzeptentscheidung.

## Statusmodell

- `idea`: ungeprüfte Idee
- `draft`: ausgearbeiteter, nicht freigegebener Entwurf
- `testing`: durch Prototyp oder Review in Prüfung
- `approved`: aktuell verbindlicher Bestandteil
- `superseded`: durch eine neuere Entscheidung ersetzt

## Änderungsprozess

Eine Änderung an einem freigegebenen Dokument benötigt eine dokumentierte
Entscheidung, eine neue Dokumentversion, einen Eintrag im
[Entscheidungsprotokoll](../10-decisions-and-archive/decision-log.md) und
gegebenenfalls die Kennzeichnung einer Übersetzung als veraltet.

## Entwicklungsprozess

Konzept → Systembeschreibung → Risikoprototyp → Test → Entscheidung → Freigabe.
Prototypcode ist nicht automatisch Produktionscode.

Vor Produktionsfreigabe besitzt jedes Kernsystem mindestens Zweck,
Spielerregeln, Ein- und Ausgaben, Abhängigkeiten, veränderbare Werte, Feedback
und Testkriterien.

## Bekannter Grundumfang

`ether-food` ist ein Top-down-Action-RPG über die Wiederherstellung einer
verlorenen Welt, die Rückkehr von Zivilisationen und vergessenen Erinnerungen.
Natur und Landschaft werden zuerst wiederhergestellt; danach folgen Bewohner,
Siedlungen und Städte, Erinnerungen und Geschichte sowie daraus entstehende
Fähigkeitserweiterungen. Der Konzept-Vertical-Slice umfasst Angriff,
Ausweichen, Blocken und Fernkampfmagie.

## Derzeitige Nicht-Ziele

Nicht Teil der aktuellen Konzeptgrundlage sind neue Gameplay-Implementierung,
vollständige Story, finales Balancing, konkrete Schadenswerte, finale
Gegnerlisten, erfundene Maschinen-/Zuro-Regeln, vollständige englische
Übersetzungen und die technische Umbenennung des geerbten Forge2D-Innenlebens.

## Abnahme und Verweise

Die Baseline ist erfüllt, wenn neue Konzeptarbeit das Statusmodell, den Prozess,
die bestätigte Projektbasis und die Nicht-Ziele erkennbar einhält. Sie wird
durch [Governance](documentation-governance.md),
[Sprachrichtlinie](language-policy.md) und
[Konzeptstatus](concept-status.md) ergänzt.
