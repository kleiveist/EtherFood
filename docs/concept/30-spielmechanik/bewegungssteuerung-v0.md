---
title: Bewegungssteuerung V0
status: accepted
updated: 2026-09-03
---

<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Bewegungssteuerung V0

## Geltungsbereich

Diese Arbeitsfassung legt die Tastaturbewegung fest, die vor dem erneuten
Pixel-Snap-Test benötigt wird. Freie Tastenbelegung, vollständige
Controllerunterstützung und Barrierefreiheitsoptionen folgen weiterhin in den
dafür vorgesehenen späteren Aufgaben. Geschwindigkeiten und Sprungwerte sind
Testwerte und noch keine endgültige Balance.

## Eingaben

| Eingabe | Wirkung |
|---|---|
| WASD oder Pfeiltasten | normales Laufen |
| dieselbe Richtung innerhalb von 0,30 Sekunden erneut drücken und halten | Schnelllauf |
| Shift beim zweiten Richtungsdruck halten | fünf Sekunden Boostlauf |
| Strg halten | Schleichen |
| Leertaste | Sprung passend zum Bewegungszustand beim Absprung |

Shift allein löst keinen Sprung aus. Alle vier Richtungsaktionen behandeln
WASD und Pfeiltasten gleich. Tastatur-Wiederholungen gelten nicht als zweiter
Richtungsdruck.

## Laufzustände

| Zustand | Geschwindigkeit |
|---|---:|
| Schleichen | 100 Weltpixel pro Sekunde |
| normales Laufen | 220 Weltpixel pro Sekunde |
| Schnelllauf | 310 Weltpixel pro Sekunde |
| Boostlauf | 400 Weltpixel pro Sekunde |

Schnelllauf und Boost bleiben bei diagonaler Bewegung und bei einem
Richtungswechsel aktiv. Wenn kurz keine Richtung gehalten wird, schützt eine
Wechseltoleranz von 0,12 Sekunden den Schnelllauf. Danach beendet vollständiges
Loslassen den Schnelllauf. Diagonale Bewegung ist nicht schneller als gerade
Bewegung.

Ein Boost läuft höchstens fünf Sekunden. Eine erneute Doppelrichtung während
dieser Zeit verlängert ihn nicht. Danach fällt die Bewegung bei weiterhin
aktivem Schnelllauf auf Schnelllauf zurück. Schleichen hat Vorrang vor Boost
und Schnelllauf; der Boosttimer läuft währenddessen weiter.

Die Priorität lautet:

```text
Bewegungssperre
→ Schleichen
→ Boostlauf
→ Schnelllauf
→ normales Laufen
```

## Kamera beim Schleichen

Schleichen setzt den aktiven Kamerazoom sofort auf 1,50×. Beim Loslassen von
Strg kehrt die Kamera zum Profil der aktuellen Szene zurück. Welt, Dungeon und
große Gebäude verwenden in dieser Arbeitsfassung 1,00×; kleine Innenräume
verwenden 1,50×. Der Held meldet nur den Schleichzustand und kennt das
Szenenprofil nicht.

## Top-down-Sprünge

Der physische Bodenanker des Helden bleibt während des Sprungs auf der
Kollisions- und Y-Sortierebene. Nur die sichtbare Figur folgt einer Höhenkurve;
der Schatten bleibt am Bodenanker. Massive Wände und Kartenhindernisse bleiben
auch während eines Sprungs wirksam.

| Zustand beim Absprung | Sprung | Dauer | Höhe | Zielentfernung |
|---|---|---:|---:|---:|
| normal oder Stillstand | Standard | 0,32 s | 24 px | 48 px |
| Schnelllauf | Lauf | 0,40 s | 30 px | 80 px |
| Boostlauf | Boost | 0,48 s | 36 px | 112 px |
| Schleichen | Standard | 0,32 s | 24 px | 48 px |

Die Richtung beim Absprung bestimmt die Hauptsprungrichtung. Ohne gehaltene
Richtung gilt die Blickrichtung. Eine leichte Richtungsanpassung in der Luft
ist möglich. Es gibt keinen Doppel- oder erneuten Luftsprung und keine
Interaktion während eines Sprungs. Niedrige überspringbare Hindernisse erhalten
später eine eigene Regel und Kollisionskategorie.
