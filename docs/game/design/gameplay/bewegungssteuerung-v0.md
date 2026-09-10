---
title: Bewegungssteuerung V0
type: design
status: accepted
updated: 2026-09-08
---

<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Bewegungssteuerung V0

## Geltungsbereich

Diese Fassung legt die vorläufige Tastaturbewegung und die zugehörigen
Top-down-Sprünge fest. Freie Tastenbelegung, vollständige
Controllerunterstützung und Barrierefreiheitsoptionen folgen in ihren späteren
Aufgaben. Geschwindigkeiten und Sprungwerte sind sicher begrenzte
Ausgangswerte für Tests und noch keine endgültige Balance.

Ausdauer, Sprungangriffe, Ausweichen, Schleichrolle und Ausweich-Backflip sind
noch keine aktiven Spielmechaniken.

## Eingaben

| Eingabe | Wirkung |
|---|---|
| Strg halten und WASD oder Pfeiltasten verwenden | Schleichen |
| Feststelltaste einschalten und WASD oder Pfeiltasten verwenden | Gehen |
| WASD oder Pfeiltasten verwenden | Laufen |
| dieselbe Richtung innerhalb von 0,30 Sekunden erneut drücken | Rennen |
| beim aktiven Rennen zusätzlich Shift halten | Sprinten |
| Leertaste | Sprung passend zum Zustand beim Absprung |

Die Feststelltaste schaltet den Gehmodus bei jedem echten Tastendruck ein oder
aus. Rennen bleibt auch bei einem Richtungswechsel aktiv. Es endet, sobald die
Figur vollständig stehen bleibt; eine Toleranz von `0,12 s` verhindert, dass
der notwendige kurze Zwischenraum eines Richtungswechsels als Stillstand
zählt.

Sprinten ist kein eigener zeitlich begrenzter Boost. Es setzt aktives Rennen
und gehaltenes Shift voraus. Beim Loslassen von Shift fällt die Figur auf
Rennen zurück. Eine Ausdauermechanik folgt später.

Alle vier Richtungsaktionen behandeln WASD und Pfeiltasten gleich.
Tastatur-Wiederholungen gelten weder als zweiter Richtungsdruck noch als
erneutes Umschalten der Feststelltaste. Diagonale Bewegung ist nicht schneller
als gerade Bewegung.

## Bewegungszustände

| Zustand | Ausgangsgeschwindigkeit |
|---|---:|
| Schleichen | 60 Weltpixel pro Sekunde |
| Gehen | 100 Weltpixel pro Sekunde |
| Laufen | 220 Weltpixel pro Sekunde |
| Rennen | 310 Weltpixel pro Sekunde |
| Sprinten | 400 Weltpixel pro Sekunde |

Die Priorität lautet:

```text
Bewegungssperre
→ Schleichen
→ Sprinten
→ Rennen
→ Gehen
→ Laufen
```

Schleichen hat damit Vorrang vor Gehmodus, Rennen und Sprinten. Der Rennzustand
bleibt während des Schleichens erhalten, solange die Figur nicht stehen
bleibt.

## Kamera beim Schleichen

Schleichen setzt den aktiven Kamerazoom sofort auf `1,50×`. Beim Loslassen von
Strg kehrt die Kamera zum Profil der aktuellen Szene zurück. Welt, Dungeon und
große Gebäude verwenden in dieser Arbeitsfassung `1,00×`; kleine Innenräume
verwenden `1,50×`. Der Held meldet nur den Schleichzustand und kennt das
Szenenprofil nicht.

## Top-down-Sprünge

Der physische Bodenanker des Helden bleibt während des Sprungs auf der
Kollisions- und Y-Sortierebene. Nur die sichtbare Figur folgt einer Höhenkurve;
der Schatten bleibt am Bodenanker. Massive Wände und Kartenhindernisse bleiben
auch während eines Sprungs wirksam.

| Zustand beim Absprung | Sprung | Dauer | Höhe | Zielweite |
|---|---|---:|---:|---:|
| Stillstand oder Schleichen | Stehsprung | 0,32 s | 24 px | 0 px |
| Gehen | Gehsprung | 0,28 s | 20 px | 32 px |
| Laufen | Laufsprung | 0,32 s | 24 px | 48 px |
| Rennen | Rennsprung | 0,40 s | 30 px | 80 px |
| Sprinten | Sprintsprung | 0,48 s | 36 px | 112 px |

Ein Stehsprung bewegt den Bodenanker nicht horizontal. Ein Sprung während des
Schleichens ist immer ein Stehsprung: Schleichen wird beim Absprung
unterbrochen und nach der Landung wieder aktiv, falls Strg weiterhin gehalten
wird.

Bei einem Bewegungssprung bestimmt die Richtung beim Absprung die
Hauptrichtung. Eine leichte Richtungsanpassung in der Luft ist möglich. Es
gibt keinen Doppel- oder erneuten Luftsprung und keine Interaktion während
eines Sprungs. Niedrige überspringbare Hindernisse erhalten später eine eigene
Regel und Kollisionskategorie.

## Sichere Testbereiche

Das Gameplay-Labor begrenzt alle zur Laufzeit veränderbaren Werte:

| Wertart | Minimum | Maximum | Schrittweite |
|---|---:|---:|---:|
| Bewegungsgeschwindigkeit | 40 px/s | 500 px/s | 5 px/s |
| Sprunghöhe | 8 px | 64 px | 1 px |
| Weite eines Bewegungssprungs | 16 px | 160 px | 1 px |

Die Stehsprungweite ist fest `0 px` und besitzt deshalb keinen Regler.
