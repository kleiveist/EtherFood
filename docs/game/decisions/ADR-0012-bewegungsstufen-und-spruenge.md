---
title: ADR-0012 – Bewegungsstufen und Sprünge erweitern
type: decision
status: accepted
updated: 2026-09-08
---

<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# ADR-0012 – Bewegungsstufen und Sprünge erweitern

## Kontext

Die mit [ADR-0010](ADR-0010-bewegungssteuerung-v0-vorziehen.md) vorgezogene
Tastatursteuerung unterschied normales Laufen, Schnelllauf und einen
fünfsekündigen Boost. Sie besaß nur drei bewegte Sprungprofile. Für das
Gameplay-Labor sollen alle grundlegenden Bewegungsstufen einzeln prüfbar sein.

## Entscheidung

Die vorläufige Steuerung unterscheidet Schleichen, Gehen, Laufen, Rennen und
Sprinten. Feststelltaste schaltet Gehen, eine einfache Richtungseingabe löst
Laufen aus und ein Doppel-Tap aktiviert Rennen bis zum Stillstand. Gehaltenes
Shift macht aus aktivem Rennen Sprinten; der bisherige Boosttimer entfällt.
Strg-Schleichen hat Vorrang.

Stehen, Gehen, Laufen, Rennen und Sprinten besitzen getrennte Sprungprofile.
Ein Sprung im Stillstand oder beim Schleichen ist rein senkrecht. Schleichen
pausiert dabei bis zur Landung. Die genauen Eingaben und Ausgangswerte stehen
unter [Bewegungssteuerung V0](../design/gameplay/bewegungssteuerung-v0.md).

## Folgen

- Die bisherige Schnelllaufstufe heißt Rennen; der Boost wird durch gehaltenes
  Sprinten ohne Ausdauerverbrauch ersetzt.
- Ausdauer bleibt eine spätere Mechanik.
- Fünf Geschwindigkeiten, fünf Sprunghöhen und vier Bewegungssprungweiten
  liegen datenbasiert in der versionierten Bewegungsressource.
- Das Gameplay-Labor darf diese Werte nur innerhalb dokumentierter Grenzen
  erproben.
- Aufgabe 83 bleibt für das endgültige Eingabesystem verantwortlich.
