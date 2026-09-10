---
title: ADR-0013 – Maßstabsbündel aus dem Testlabor entfernen
type: decision
status: accepted
updated: 2026-09-08
---

<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# ADR-0013 – Maßstabsbündel aus dem Testlabor entfernen

## Kontext

[ADR-0011](ADR-0011-massstab-v0.md) nahm Maßstab V0 an und ließ zwei
abweichende Vergleichsbündel im visuellen Testlabor bestehen. Das Labor bietet
Heldenhöhe, Tilegröße, Kamerazoom, Pixel-Snap und Texturfilter inzwischen als
einzeln einstellbare Werte an. Die zusätzliche Profilauswahl wiederholt diese
Möglichkeiten und kann unbeabsichtigt mehrere Einstellungen zugleich ändern.

## Entscheidung

Die gebündelte Auswahl `A → Maßstab V0 → C` und ihre drei unveränderlichen
Vergleichsressourcen werden entfernt. Maßstabswerte werden im `F5`-Menü nur
noch einzeln eingestellt und einzeln als Spielstandard übernommen.

Der angenommene Maßstab V0 selbst bleibt unverändert: `80 px` Heldenhöhe,
`32 × 32 px` Tilegröße, `1,00×` normale Spielansicht, `1920 × 1080` bei
`16:9`, Pixel-Snap und Nearest-Neighbor.

## Folgen

- Das Testlabor zeigt keinen Profilstatus und keine Bündelbestätigung mehr.
- Die früheren A- und C-Werte bleiben über die vorhandenen Einzeloptionen
  weiterhin testbar, bilden aber kein benanntes Profil.
- Eine Übernahme schreibt nur den gerade fokussierten Einzelwert.
- Die Aussage aus ADR-0011, nach der A und C als Bündel im Testlabor bleiben,
  wird durch diese Entscheidung ersetzt. Alle Produktionswerte aus ADR-0011
  bleiben gültig.
