---
title: "Sprachrichtlinie"
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

# Sprachrichtlinie

## Zweck

Diese Richtlinie legt verbindlich fest, welche Sprache Inhalt, Technik und
Übersetzungen verwenden.

## Deutsch als Konzeptquelle

Deutsch ist die verbindliche Arbeitssprache für Spielvision, Spielkonzept,
Story, Welt, Mechaniken, Kampf, Maschinen, Zuro, Landschaft, Fortschritt,
Prototypauswertungen, inhaltliche Entscheidungen, Status und Freigaben. Diese
Inhalte liegen unter `docs/content/de/` und sind die inhaltliche Quelle der
Wahrheit.

## Englisch für Technik und öffentliche Orientierung

Englisch wird für Code, Klassen, Funktionen, Variablen, technische
Identifikatoren, Pfade, Dateinamen, Konfigurationsschlüssel, Testnamen,
technische Entwicklerdokumentation, ExecPlans, Architekturunterlagen,
Commit-Titel und das öffentliche Root-README verwendet. Deutsche Seiten dürfen
technische Identifikatoren wie `PlayerCombatController`, `dodge` oder
`world_restoration` in Backticks verwenden.

## Übersetzungstor

Detaillierte englische Konzeptübersetzungen sind erst zulässig, wenn das
gesamte deutsche Konzept `complete` ist und das jeweilige Quelldokument
`approved` ist. Bis dahin bleibt
`translation_status: blocked-until-concept-complete` gesetzt. Das Root-README
und `docs/content/en/index.md` dürfen eine knappe englische Orientierung geben.

## Arbeitsablauf und Ein-/Ausgaben

Eine Übersetzung erhält als Eingabe eine eindeutig versionierte, freigegebene
deutsche Quelle. Ausgabe ist eine nachverfolgbare Übersetzung mit Quellenlink
und Versionsbezug. Wird die Quelle geändert, muss die Übersetzung als veraltet
gekennzeichnet werden.

## Systemabhängigkeiten und veränderbare Werte

Die Richtlinie gilt bereichsübergreifend. Veränderbar sind Terminologie und
Übersetzungsstatus nur durch dokumentierte Entscheidung; die technische
Repository-Sprache `repository_language = "en"` bleibt davon unberührt.

## Feedback, Sonderfälle und Risiken

UI- oder Spieltexte sind später gesondert zu lokalisieren und werden durch diese
Dokumentationsregel noch nicht festgelegt. Risiken sind widersprüchliche
Parallelquellen, voreilige Detailübersetzungen und unmarkierte veraltete Texte.

## Offene Fragen

- Welcher Reviewprozess gilt später für Übersetzungen?
- Wie werden lokalisierte In-Game-Texte versioniert und getestet?
- Welche Terminologieliste wird für Übersetzer verbindlich?

## Abnahmekriterien

- Alle Konzeptdetailseiten sind Deutsch und liegen unter `docs/content/de/`.
- Technische Entwicklerseiten und Identifikatoren sind Englisch.
- Unter `docs/content/en/` existiert vor Öffnung des Tors keine gespiegelte
  Detailstruktur.
- Übersetzungsbereitschaft folgt Gesamtabschluss und Einzeldokumentfreigabe.

## Verwandte Dokumente

- [Dokumentationsgovernance](documentation-governance.md)
- [Terminologie](terminology.md)
- [Konzeptstatus](concept-status.md)
- [English documentation status](../../en/index.md)
