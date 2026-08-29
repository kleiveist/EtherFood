---
title: "Konzeptfahrplan"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---

[← Überblick](index.md)

# Konzeptfahrplan

## Zweck des Dokuments

Der Konzeptfahrplan ordnet die Ausarbeitung nach Abhängigkeiten und
Entscheidungsreife. Er enthält bewusst keine erfundenen Termine oder
Produktionsversprechen.

## Bestätigte Entscheidungen

Der verbindliche Entwicklungsprozess lautet: Konzept → Systembeschreibung →
Risikoprototyp → Test → Entscheidung → Freigabe. Nur `approved` ist
verbindlich, und detaillierte Übersetzungen bleiben bis zum Übersetzungstor
gesperrt.

## Aktueller Arbeitsentwurf

1. Projektbasis, Sprache, Statusmodell und Änderungsprozess konsolidieren.
2. Welt, Core Loop, Fortschritt und Präsentationsziele widerspruchsfrei
   beschreiben.
3. Kampfumfang des Konzept-Vertical-Slice prüfbar machen.
4. Maschinen, Zuro und Gegnerentwicklung getrennt klären.
5. Risikoprototypen nur für klar benannte Annahmen durchführen.
6. Bereiche entscheiden, freigeben und abschließend auf Konsistenz prüfen.
7. Erst nach Gesamtabschluss freigegebene Einzeldokumente zur Übersetzung
   freigeben.

## Spielerperspektive und Spielerfantasie

Der Fahrplan priorisiert Fragen, die den wahrnehmbaren Wiederherstellungsbogen
und die Handlungsmöglichkeiten des Spielers bestimmen. Noch nicht entschieden
ist, welche Hypothese den höchsten Spielspaß- oder Machbarkeitsrisikoanteil hat.

## Regeln und Ablauf

Ein Arbeitspaket darf erst zur Freigabe, wenn Zweck, Spielerregeln, Ein- und
Ausgaben, Abhängigkeiten, veränderbare Werte, Feedback und Testkriterien
vorliegen. Ein Prototypbefund führt nicht automatisch zu Produktionscode oder
einer Freigabe.

## Eingaben und Ausgaben

- Eingaben: offene Fragen, Abhängigkeiten, Risikobewertungen und Testergebnisse.
- Ausgaben: dokumentierte Entscheidungen, neue Versionen und aktualisierter
  Konzeptstatus.
- Noch nicht entschieden: zeitliche Planung und Verantwortlichkeiten.

## Systemabhängigkeiten

Story/Welt und Gameplay/Fortschritt bilden die Grundlage für Landschaft,
Kampf, Maschinen, Zuro, Gegner und Präsentation. Die genaue Reihenfolge kann
sich nach dokumentierten Risikoerkenntnissen ändern.

## Veränderbare und später zu balancierende Werte

Prioritäten, Iterationsanzahl und Prototypumfang sind planbar, aber noch nicht
festgelegt. Balancingwerte gehören in die jeweiligen Systeme, nicht in diesen
Fahrplan.

## Visuelles, akustisches und UI-Feedback

Der Fahrplan definiert keine Gestaltung. Er verlangt jedoch, dass jedes
Kernsystem seine Rückmeldungen vor Freigabe beschreibt und testet.

## Sonderfälle und Risiken

- Abhängige Systeme könnten zu früh als fest behandelt werden.
- Prototypen ohne klare Annahme erzeugen schwer verwertbare Ergebnisse.
- Ein freigegebenes Einzeldokument kann trotzdem bereichsübergreifend
  inkonsistent sein.

## Offene Fragen

- Welche offenen Annahmen besitzen das höchste Konzept- oder Machbarkeitsrisiko?
- Welche Reviews und Rollen sind für Freigaben erforderlich?
- Welche dokumentierten Ausnahmen dürfen einen Bereich vorläufig abschließen?

## Abnahmekriterien

- Jeder Kernbereich besitzt einen nachvollziehbaren Status und nächste Frage.
- Prototypen verweisen auf eine zu prüfende Annahme und resultierende
  Entscheidung.
- Das Gesamtkonzept wird erst nach erfolgreicher Konsistenzprüfung `complete`.

## Verwandte Konzeptseiten

- [Konzeptgrundlage](../01-baseline/concept-baseline.md)
- [Konzeptstatus](../01-baseline/concept-status.md)
- [Dokumentationsgovernance](../01-baseline/documentation-governance.md)
- [Testprotokoll](../09-prototypes-and-tests/test-log.md)
