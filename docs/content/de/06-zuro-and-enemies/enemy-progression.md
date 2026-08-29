---
title: "Gegnerentwicklung"
language: de
status: draft
version: "0.1"
source_of_truth: true
translation_status: blocked-until-concept-complete
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](06-zuro-and-enemies.md)
<!-- AUTO-GENERATED:backlink END -->
[← Zuro und Gegnerentwicklung](index.md)

# Gegnerentwicklung

## Zweck des Dokuments

Dieses Dokument strukturiert normale Gegnerentwicklung unabhängig vom
Zuro-Arbeitsbegriff. Eine Gleichsetzung oder Kopplung ist nicht bestätigt.

## Bestätigte Entscheidungen

Gefahren und Gegner gehören zum Core Loop, und der Vertical Slice enthält
mindestens einen einfachen Gegner. Welche Gegner sich wie entwickeln, ist noch
nicht entschieden.

## Aktueller Arbeitsentwurf

Zu klären sind Zweck der Entwicklung, betroffene Einheit, Auslöser,
Verhaltensänderung, Werteänderung, räumliche Reichweite, Persistenz und
Spielerreaktion. Zuro wird dabei nur als mögliche, ungeklärte Abhängigkeit
geführt.

## Spielerperspektive und Spielerfantasie

Der Spieler soll Gefahren lernen, erkennen und mit dem bestätigten Kampfumfang
bewältigen können. Ob Entwicklung Anpassung, Eskalation, regionale Vielfalt,
fortschrittsabhängige Herausforderung oder etwas anderes bedeutet, ist offen.

## Regeln und Ablauf

Noch nicht entschieden sind Entstehung, Platzierung, Wiedererscheinen,
Veränderung vorhandener Gegner, Skalierung neuer Gegner, Rücksetzung und
Beziehung zum Weltzustand.

## Eingaben

Mögliche, nicht bestätigte Eingaben sind Gebiet, Spielfortschritt,
Wiederherstellungszustand, Zeit, Spielerhandlung oder Zuro. Keine davon darf
ohne Entscheidung implementiert werden.

## Ausgaben

Mögliche, nicht bestätigte Ausgaben sind Verhalten, Zusammensetzung,
Fähigkeiten, Werte, Auftreten oder Belohnung. Konkrete Gegnerlisten und Zahlen
sind nicht Teil dieses Entwurfs.

## Systemabhängigkeiten

Kampf, Weltzustand, Landschaft, Fortschritt, Spawn-/Speicherlogik, UI und Audio
sind relevante Abhängigkeiten. Eine Zuro-Verbindung benötigt eine eigenständige
Entscheidung in beiden Dokumenten.

## Veränderbare und später zu balancierende Werte

Gegneranzahl, Häufigkeit, Wahrnehmung, Bewegung, Angriff, Gesundheit,
Widerstände, Belohnungen und Skalierungsgrößen bleiben offen und numerisch
unbestimmt.

## Visuelles, akustisches und UI-Feedback

Gegnertyp, Absicht und relevante Zustandsänderung müssen in der Top-down-Ansicht
lesbar sein. Wie Entwicklung signalisiert wird, ist noch nicht entschieden und
muss ohne alleinige Farbcodierung funktionieren.

## Sonderfälle und Risiken

- Automatische Skalierung kann Fortschritt entwerten.
- Unsichtbare Entwicklung kann neue Niederlagen willkürlich wirken lassen.
- Bereits vorhandene und neu erzeugte Gegner dürfen nicht inkonsistent behandelt
  werden, ohne dass dies erklärt ist.
- Kopplung an Wiederherstellung darf positive Weltveränderung nicht pauschal
  bestrafen.

## Offene Fragen

- Warum benötigt das Spiel Gegnerentwicklung?
- Welche Einheit entwickelt sich und wann?
- Was bleibt beim Gebietswechsel, Speichern oder Wiederherstellen erhalten?
- Welche Lern- und Gegenmaßnahmen erhält der Spieler?
- Gibt es eine Verbindung zu Zuro, und welchen eigenständigen Zweck behält jedes
  System?

## Abnahmekriterien

- Systemzweck, betroffene Einheit, Auslöser, Ergebnis und Persistenz sind
  dokumentiert.
- Entwicklung bleibt lesbar, begrenzt und durch Spielerentscheidungen
  beantwortbar.
- Der Vertical-Slice-Gegner kann ohne unfreigegebene globale Skalierung getestet
  werden.
- Eine Zuro-Kopplung existiert nur nach dokumentierter Freigabe.

## Verwandte Konzeptseiten

- [Zuro-System](zuro-system.md)
- [Kampfsystem](../04-combat/combat-system.md)
- [Gameplay und Fortschritt](../03-gameplay-and-progression/gameplay-and-progression.md)
- [Vertical Slice](../09-prototypes-and-tests/vertical-slice.md)
