---
title: "Testprotokoll"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---

[← Prototypen und Tests](index.md)

# Testprotokoll

## Zweck

Das Testprotokoll verknüpft Konzeptannahmen, begrenzte Prototypen,
Beobachtungen und daraus folgende Entscheidungen. Es ist kein Erfolgsbericht
und enthält keine erfundenen Ergebnisse.

## Aktueller Stand

Es wurde noch kein `ether-food`-Konzeptprototyp in diesem Protokoll ausgewertet.
Der aktuelle Status ist daher nicht „bestanden“, sondern „noch nicht getestet“.

| Test-ID | Datum | Annahme | Dokument/Version | Prototyp | Ergebnis | Folgeentscheidung |
| --- | --- | --- | --- | --- | --- | --- |
| — | — | Noch kein Test erfasst | — | — | noch nicht getestet | — |

## Pflichtinhalt eines Eintrags

Jeder Eintrag dokumentiert zu prüfende Annahme, Prototypumfang, bewusste
Nicht-Ziele, Testaufbau, Beobachtungen, vorher festgelegte Erfolgskriterien,
Ergebnis und daraus folgende Entscheidung. Dafür ist die
[Prototyptestvorlage](../templates/prototype-test-template.md) zu verwenden.

## Spielerperspektive

Beobachtungen beschreiben wahrnehmbares Verhalten und Verständnis der Spieler,
nicht nur die Absicht des Entwurfs. Interpretationen werden von Rohbeobachtungen
getrennt.

## Regeln, Eingaben und Ausgaben

Eingaben sind eine versionierte Annahme, ein begrenzter Testaufbau und
beobachtbare Kriterien. Ausgaben sind protokollierte Beobachtungen und eine
Entscheidung: akzeptieren, ändern, erneut testen, verwerfen oder vertagen.

## Systemabhängigkeiten und veränderbare Werte

Jeder Test nennt beteiligte Systeme und die verwendeten Prototypwerte. Eine
Wertänderung zwischen Durchläufen wird dokumentiert, damit Ergebnisse
vergleichbar bleiben.

## Feedback

Spiel-, UI-, Grafik- und Audiofeedback wird danach bewertet, ob es verstanden
wurde. Technische Logs ergänzen die Beobachtung, ersetzen sie aber nicht.

## Sonderfälle und Risiken

- Nachträglich formulierte Erfolgskriterien verzerren Ergebnisse.
- Prototypfehler und Konzeptfehler müssen unterschieden werden.
- Kleine Stichproben begründen keine allgemeine Gewissheit.
- Personenbezogene oder sensible Testdaten gehören nicht in dieses Repository.

## Offene Fragen

- Welche Testpersonen und Umgebungen sind für den ersten Slice geeignet?
- Welche Beobachtungen können ohne personenbezogene Daten erfasst werden?
- Wer entscheidet nach einem uneindeutigen Ergebnis über den nächsten Schritt?

## Abnahmekriterien

- Kein Testeintrag fehlt eine vorher benannte Annahme und Erfolgskriterien.
- Beobachtung, Interpretation und Entscheidung sind getrennt nachvollziehbar.
- Jede Folgeentscheidung verlinkt betroffene Konzeptdokumente und aktualisiert
  gegebenenfalls deren Status.

## Verwandte Dokumente

- [Vertical Slice](vertical-slice.md)
- [Konzeptfahrplan](../00-overview/concept-roadmap.md)
- [Entscheidungsprotokoll](../10-decisions-and-archive/decision-log.md)
- [Dokumentationsgovernance](../01-baseline/documentation-governance.md)
