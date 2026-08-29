---
title: "Kampfsystem"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---

[← Kampf](index.md)

# Kampfsystem

## Zweck des Dokuments

Dieses Dokument grenzt den bestätigten Kampfumfang des ersten Vertical Slice
ab und macht die noch offenen Kampfentscheidungen prüfbar.

## Bestätigte Entscheidungen

Der erste Vertical Slice enthält mindestens:

- Angriff,
- Ausweichen,
- Blocken,
- Magie als Fernkampfmöglichkeit.

Damit sind keine Schadenswerte, Abklingzeiten, Kombos, Ressourcen oder
Eingabebelegungen freigegeben.

## Aktueller Arbeitsentwurf

Der Kampf soll in der Top-down-Perspektive lesbare Entscheidungen zwischen
Offensive, Positionierung, Verteidigung und Fernkampf erlauben. Das ist eine
Arbeitshypothese; Tempo, Präzision, Taktikanteil und Schwierigkeitskurve müssen
durch einen Prototyp geprüft werden.

## Spielerperspektive und Spielerfantasie

Der Spieler soll Gefahren erkennen und bewusst mit den vier bestätigten
Handlungen reagieren können. Noch nicht entschieden sind Gewicht, Gefühl und
Rollenverteilung dieser Handlungen.

## Regeln und Ablauf: offene Entscheidungen

| Entscheidungsfeld | Offene Designfrage |
| --- | --- |
| Zielausrichtung | Frei, bewegungsbasiert, automatisch, feststellbar oder kombiniert? |
| Treffererkennung | Welche räumliche und zeitliche Regel macht Treffer nachvollziehbar? |
| Angriffsfolgen | Einzelangriff, Folgeangriffe oder andere Struktur; noch nicht entschieden |
| Beweglichkeit während Angriffen | Welche Bewegung, Drehung oder Unterbrechung ist erlaubt? |
| Kosten und Grenzen des Blockens | Ressource, Richtung, Trefferarten, Durchbruch und Erholung sind offen. |
| Ausweichfenster | Dauer, Unverwundbarkeit, Distanz, Richtung und Wiederholung sind offen. |
| Ressourcen für Magie | Quelle, Regeneration, Begrenzung und Verhältnis zum Nahkampf sind offen. |
| Gegnertelegraphie | Vorlauf, Form, Lesbarkeit und Varianten benötigen Tests. |
| Schadensmodell | Lebenspunkte, Rüstung, Typen, Staffelung und Zahlen sind nicht entschieden. |
| Heilung | Quelle, Verfügbarkeit, Risiko und Begrenzung sind offen. |
| Niederlage | Rücksetzpunkt, Verlust, Lernfeedback und Barrierewirkung sind offen. |
| Kampf-Feedback | Treffer-, Block-, Ausweich-, Magie- und Schadensrückmeldung sind zu definieren. |
| Barrierefreiheit | Assistenzoptionen, Kontrast, Bewegung, Timing und Informationsredundanz sind offen. |
| Controller- und Tastaturbedienung | Aktionen, Remapping, gleichzeitige Eingaben und Gerätewechsel sind offen. |

## Eingaben

Es werden semantische Aktionen für Angriff, Ausweichen, Blocken und
Fernkampfmagie benötigt. Konkrete Tasten, Controller-Belegung, Halten/Drücken
und Eingabepuffer sind noch nicht entschieden und müssen remappingfähig gedacht
werden.

## Ausgaben

Ausgaben können Treffer, Positionsänderung, erfolgreicher oder gebrochener
Block, vermiedener Treffer, Magieprojektil beziehungsweise Fernwirkung,
Ressourcenänderung und Zustandsfeedback umfassen. Ihre genauen Regeln sind
offen.

## Systemabhängigkeiten

Kampf hängt von Bewegung, Kamera, Kollision, Gegnerverhalten, Fortschritt,
Fähigkeiten, UI, Audio und Barrierefreiheit ab. Zuro darf Gegnerwerte oder
Verhalten nicht beeinflussen, bevor das Zuro-System freigegeben ist.

## Veränderbare und später zu balancierende Werte

Alle Zeitfenster, Distanzen, Geschwindigkeiten, Schadens-, Heilungs-, Kosten-,
Regenerations- und Gegnerwerte bleiben offen. Sie müssen als konfigurierbare
Testwerte behandelt werden; dieses Dokument genehmigt keine Zahl.

## Visuelles, akustisches und UI-Feedback

Jede der vier Aktionen sowie Treffer, Fehlschlag und Gegnerabsicht brauchen
mehrkanalige, unterscheidbare Rückmeldung. Noch nicht entschieden sind Effekte,
Animationen, Kamera, Klang, Controllerfeedback, Anzeigen und
Barrierefreiheitsalternativen.

## Sonderfälle und Risiken

- Gleichzeitige Eingaben und unterbrochene Aktionen benötigen Prioritätsregeln.
- Blocken oder Ausweichen könnte die andere Verteidigung entwerten.
- Fernkampfmagie darf weder Pflichtlösung noch bedeutungslose Alternative sein.
- Visuelle Effekte dürfen Trefferzonen und Gegnertelegraphie nicht verdecken.
- Tastatur und Controller müssen funktional gleichwertig prüfbar sein.

## Offene Fragen

Zusätzlich zur Entscheidungstabelle sind Kameraeinfluss, Pausenverhalten,
Zustandsunterbrechungen, Mehrfachtreffer, Kontaktgefahr und Zusammenspiel mit
Umweltgefahren noch nicht entschieden.

## Abnahmekriterien

- Ein Prototyp stellt alle vier bestätigten Handlungen ohne unfreigegebene
  Produktionszusage bereit.
- Spieler können Gegnerabsicht, eigene Aktion und Ergebnis unterscheiden.
- Jede Aktion besitzt dokumentierte Eingabe, erlaubte Zustände, Ausgabe,
  Abbruchregel, Feedback und Testfrage.
- Controller- und Tastaturnutzung sowie zentrale Barrierefreiheitsrisiken werden
  getestet.
- Balancingwerte bleiben außerhalb einer dokumentierten Freigabe veränderbar.

## Verwandte Konzeptseiten

- [Vertical Slice](../09-prototypes-and-tests/vertical-slice.md)
- [Gegnerentwicklung](../06-zuro-and-enemies/enemy-progression.md)
- [Gameplay und Fortschritt](../03-gameplay-and-progression/gameplay-and-progression.md)
- [Präsentationsrichtung](../08-art-audio-and-ui/presentation-direction.md)
