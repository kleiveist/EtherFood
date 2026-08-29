---
title: "Dokumentationsgovernance"
language: de
status: approved
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---

[← Verbindliche Konzeptgrundlage](index.md)

# Dokumentationsgovernance

## Zweck

Diese Richtlinie macht Konzeptstände, Entscheidungen, Tests und Übersetzungen
nachvollziehbar. Sie verhindert, dass Entwürfe stillschweigend verbindlich
werden.

## Bestätigte Regeln

- Deutsche Konzeptseiten sind die inhaltliche Quelle der Wahrheit.
- Zulässige Dokumentstatus sind `idea`, `draft`, `testing`, `approved` und
  `superseded`; nur `approved` ist verbindlich.
- Jede Seite besitzt maschinenlesbares Frontmatter mit Titel, Sprache, Status,
  Version, Quellenstatus und Übersetzungsstatus.
- Änderungen an freigegebenen Seiten benötigen Entscheidung, neue Version,
  Protokolleintrag und gegebenenfalls veraltete Übersetzungskennzeichnung.

## Arbeitsablauf

1. Eine offene Frage wird in der zuständigen Seite präzisiert.
2. Ein Entwurf beschreibt Regeln, Abhängigkeiten und Abnahmekriterien.
3. Falls nötig prüft ein begrenzter Prototyp eine benannte Annahme.
4. Beobachtungen werden im Testprotokoll festgehalten.
5. Eine Entscheidung akzeptiert, verwirft oder vertagt den Entwurf.
6. Freigegebene Inhalte erhalten `approved` und eine nachvollziehbare Version.

## Rollen und Spielerbezug

Konkrete Freigaberollen sind noch nicht entschieden. Jede Freigabe muss jedoch
Spielerwirkung, Systemwirkung und technische Machbarkeit getrennt betrachten.

## Eingaben und Ausgaben

- Eingaben: Anforderungen, Entwürfe, Reviews, Prototypbeobachtungen.
- Ausgaben: versionierte Dokumente, Entscheidungs- und Statusänderungen.
- Eine Diskussion ohne dokumentierte Entscheidung ändert keinen
  Freigabestatus.

## Abhängigkeiten und veränderbare Werte

Governance gilt für alle Konzeptbereiche und ihre Übersetzungen. Versionen und
Status sind veränderbar, aber nur über den beschriebenen Prozess; konkrete
Versionssprünge nach `0.1` sind noch nicht standardisiert.

## Feedback und Nachvollziehbarkeit

Links zwischen Konzeptseite, Testeintrag und Entscheidung bilden die
Prüfkette. Visuelles oder akustisches Spiel-Feedback ist Gegenstand der
jeweiligen Systemseite.

## Sonderfälle und Risiken

- Teilweise bestätigte Aussagen in einem `draft`-Dokument müssen explizit als
  bestätigt gekennzeichnet bleiben.
- Ein `superseded`-Dokument bleibt zur Nachvollziehbarkeit erhalten, darf aber
  nicht als aktuelle Regel verlinkt werden.
- Übersetzungen dürfen nicht als Ersatzquelle für eine deutsche Freigabe dienen.

## Offene Fragen

- Wer darf Freigaben erteilen und welche Reviews sind verpflichtend?
- Welche Versionierungsregel gilt für redaktionelle gegenüber inhaltlichen
  Änderungen?
- Wo werden akzeptierte Ausnahmen vom Gesamtabschluss dokumentiert?

## Abnahmekriterien

- Status und Version jeder fachlichen Seite sind maschinenlesbar.
- Jede Änderung an `approved` ist über Entscheidung und Protokoll nachvollziehbar.
- Der zentrale Konzeptstatus stimmt mit den Quelldokumenten überein.
- Das Übersetzungstor wird technisch und redaktionell nicht umgangen.

## Verwandte Dokumente

- [Sprachrichtlinie](language-policy.md)
- [Konzeptstatus](concept-status.md)
- [Entscheidungsprotokoll](../10-decisions-and-archive/decision-log.md)
- [Archivrichtlinie](../10-decisions-and-archive/archive-policy.md)
