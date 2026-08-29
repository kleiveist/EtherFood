---
title: "Landschaftssystem"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---

[← Landschaft und Umwelt](index.md)

# Landschaftssystem

## Zweck des Dokuments

Dieses Dokument beschreibt die bestätigte Priorität von Natur und Landschaft
und strukturiert alle offenen Regeln für beschädigte und wiederhergestellte
Umweltzustände.

## Bestätigte Entscheidungen

Natur und Landschaft werden als erster Schritt der Weltwiederherstellung
wiederhergestellt. Erst danach kehren Bewohner zurück und werden Siedlungen oder
Städte wiederhergestellt beziehungsweise neu belebt.

## Aktueller Arbeitsentwurf: offene Bereiche

| Bereich | Offene Designfragen |
| --- | --- |
| Biome | Welche Biome benötigt das Spiel, und welche spielerische Funktion unterscheidet sie? |
| Beschädigte und wiederhergestellte Zustände | Welche Zustände existieren, was verändert sie und wie werden Übergänge geprüft? |
| Fortbewegung | Welche Wege, Hindernisse, Fähigkeiten und Zugangsregeln gelten? |
| Geländeeigenschaften | Welche Eigenschaften beeinflussen Bewegung, Kampf, Sicht oder Interaktion? |
| Ressourcen | Gibt es Umweltressourcen, und welchem bestätigten Systemzweck dienen sie? |
| Umweltgefahren | Welche Gefahren sind lesbar, vermeidbar und mit Wiederherstellung vereinbar? |
| Sichtbare Transformation | Welche Änderungen zeigen Ursache, Umfang und Ergebnis der Wiederherstellung? |
| Dauerhafte und temporäre Veränderungen | Was bleibt bestehen, was kehrt zurück und warum? |
| Verbindung zu Bewohnern | Welche Landschaftsbedingungen ermöglichen Rückkehr, ohne Bewohner auf einen Schalter zu reduzieren? |
| Verbindung zu Maschinen | Gibt es eine Wirkung in eine oder beide Richtungen? Noch nicht entschieden. |
| Verbindung zu Gegnern | Wie beeinflussen Zustände Auftreten oder Verhalten, falls überhaupt? |
| Verbindung zu Erinnerungen | Welche Orte oder Veränderungen können Geschichte zugänglich machen? |
| Technische Darstellbarkeit im Vertical Slice | Welcher kleinste Zustandswechsel zeigt die Idee robust und performant? |

## Spielerperspektive und Spielerfantasie

Der Spieler soll die Landschaft als veränderbaren Teil der Welt erleben und die
Folgen der Wiederherstellung räumlich nachvollziehen. Ob er heilt, aktiviert,
pflegt, gestaltet oder auf andere Weise handelt, ist noch nicht entschieden.

## Regeln und Ablauf

Eine spätere Regel muss Ausgangszustand, mögliche Interaktion, Voraussetzungen,
Übergang, Persistenz, erneuten Besuch und Folgefreischaltungen beschreiben. Die
Priorität der Landschaft ist bestätigt; die konkrete Handlung ist offen.

## Eingaben

Mögliche Eingaben sind Erkundung, Kampf, Interaktion, Erinnerungsfortschritt oder
andere noch zu entscheidende Bedingungen. Ressourcen oder Maschinen sind keine
bestätigten Eingaben.

## Ausgaben

Bestätigt ist ein wiederhergestellter Natur- oder Landschaftszustand, der den
weiteren Wiederherstellungsfortschritt ermöglicht. Konkrete Bewohner-,
Ressourcen-, Gegner- oder Fähigkeitsausgaben sind noch nicht entschieden.

## Systemabhängigkeiten

Landschaft hängt von Weltzustand, Fortschritt, Darstellung, Fortbewegung,
Kollision, Kampf und Speicherung ab. Verbindungen zu Bewohnern, Maschinen,
Gegnern, Zuro und Erinnerungen benötigen eigene Entscheidungen.

## Veränderbare und später zu balancierende Werte

Gebietsgröße, Zustandsanzahl, Transformationsdauer, Reichweite,
Fortbewegungswerte, Ressourcenmengen und Gefahrenwerte bleiben offen. Für den
Vertical Slice werden sie nur als veränderbare Prototypwerte verwendet.

## Visuelles, akustisches und UI-Feedback

Beschädigte und wiederhergestellte Zustände müssen in der Top-down-Ansicht
unterscheidbar sein. Transformation benötigt verständliche visuelle und
akustische Rückmeldung; UI darf unterstützen, aber die Weltänderung nicht allein
erklären. Farbsehschwächen und Effektüberlastung sind zu berücksichtigen.

## Sonderfälle und Risiken

- Teilweise Wiederherstellung kann Zustände schwer lesbar machen.
- Temporäre Rückfälle könnten den bestätigten Fortschrittsbogen untergraben.
- Geländeveränderung darf den Spieler nicht einschließen oder Wege unlösbar
  machen.
- Große Transformationen können technische Performance- und Speicherprobleme
  erzeugen.
- Ressourcen- oder Maschinenregeln dürfen nicht vor ihrer Freigabe vorausgesetzt
  werden.

## Offene Fragen

- Was tut der Spieler konkret, um Landschaft wiederherzustellen?
- Welche Zustandsgranularität ist spielerisch lesbar und technisch tragfähig?
- Wie bleibt die Welt nach Speichern, Laden und erneutem Betreten konsistent?
- Welche Landschaftsänderung genügt, um den Vertical-Slice-Kern zu prüfen?

## Abnahmekriterien

- Ein Gebiet besitzt klar dokumentierten beschädigten und wiederhergestellten
  Zustand samt Auslöser, Persistenz und Folge.
- Der Spieler kann die Transformation und ihre Ursache ohne externe Erklärung
  erkennen.
- Der Zustand erzeugt keine Sackgasse bei Bewegung, Kampf oder Fortschritt.
- Der Vertical Slice kann die Transformation mit vorhandener Technik
  risikoorientiert darstellen.

## Verwandte Konzeptseiten

- [Gameplay und Fortschritt](../03-gameplay-and-progression/gameplay-and-progression.md)
- [Handlung und Welt](../02-story-and-world/story-and-world.md)
- [Maschinensystem](../05-machines/machine-system.md)
- [Vertical Slice](../09-prototypes-and-tests/vertical-slice.md)
