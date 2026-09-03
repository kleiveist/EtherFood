---
title: ADR-0010 – Bewegungssteuerung V0 vorziehen
status: accepted
updated: 2026-09-03
---
<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# ADR-0010 – Bewegungssteuerung V0 vorziehen

## Kontext

Die endgültige Verwaltung von Eingaben, Controllern, Tastenbelegung und
Eingabekonflikten ist im Gesamtfahrplan erst für Aufgabe 83 vorgesehen. Die
offene Pixel-Snap-Abnahme benötigt jedoch schon jetzt unterschiedliche Lauf-,
Schleich- und Sprungzustände, damit sie nicht nur eine einzelne langsame
Gehbewegung bewertet.

## Entscheidung

Vor dem erneuten Pixel-Snap-Test wird Aufgabe 17.1 als begrenzte
Tastatursteuerung umgesetzt. Ihre verbindlichen Spielregeln stehen unter
[Bewegungssteuerung V0](../30-spielmechanik/bewegungssteuerung-v0.md). Aufgabe
17.2 testet Pixel-Snap danach mit allen neuen Bewegungszuständen.

Aufgabe 83 bleibt für das endgültige Eingabesystem einschließlich freier
Tastenbelegung, vollständiger Controllerunterstützung und systematischer
Konfliktbehandlung verantwortlich. Aufgabe 84 bleibt für
Barrierefreiheitsoptionen verantwortlich.

## Folgen

- Die gemeinsame Heldenklasse erhält jetzt eine datenbasierte
  Bewegungszustandsmaschine.
- Die V0-Tastaturbelegung darf in späteren Aufgaben erweitert oder nach einer
  neuen dokumentierten Entscheidung angepasst werden.
- Pixel-Snap und Bewegungslogik bleiben zwei getrennte Aufgaben und Commits.
- Die V0-Zahlenwerte gelten als Testwerte, nicht als abgeschlossene Balance.
