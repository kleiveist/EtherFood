---
title: Rekonstruktionssystem
status: draft-design
updated: 2026-08-30
---
<!-- AUTO-GENERATED:backlink START -->
[← Back](40-world-systems.md)
<!-- AUTO-GENERATED:backlink END -->
# Rekonstruktionssystem

## Zweck

Das Rekonstruktionssystem übersetzt das Befreien von Monsterhöhlen in sichtbare, spielbare Weltveränderung. Es ist die wichtigste Verbindung zwischen Kampf und Weltaufbau.

## Rekonstruktionseinheiten

Jede Region kann in wiederherstellbare Einheiten gegliedert werden:

- Geländeabschnitt;
- Naturknoten;
- Bewohner- oder Seelengruppe;
- Gebäude oder Stadtfunktion;
- Erinnerungsknoten;
- Fähigkeit oder Fähigkeitsverbesserung.

## Auslöser

Eine Rekonstruktion kann ausgelöst werden durch:

- das Besiegen eines Höhlenkerns;
- das Schließen eines Siegels;
- das Reinigen mehrerer miteinander verbundener Monsterquellen;
- das Lösen einer Erinnerungsaufgabe;
- den Schutz einer zurückgekehrten Seele;
- einen regionalen Bosskampf.

## Darstellung

Die Veränderung soll nach Möglichkeit direkt im Spielraum sichtbar werden. Geeignete Formen sind:

- Landschaft baut sich vor den Augen des Spielers auf;
- Farbe, Licht und Geräusche kehren zurück;
- neue Wege wachsen oder werden freigelegt;
- Bewohner erscheinen nicht abstrakt im Menü, sondern beziehen konkrete Orte;
- eine Stadt entwickelt sich in mehreren erkennbaren Stufen.

## Technische Konsequenz

Die Welt benötigt persistente Zustände pro Rekonstruktionseinheit. Quests, Kollisionen, Gegner, Navigation, Dialoge und Musik müssen auf diese Zustände reagieren können. Das System sollte datengetrieben sein, damit Regionen nicht ausschließlich über individuelle Skripte gebaut werden müssen.
