---
title: ADR-0010 – Texturfilter der Pixelart-Spielwelt
status: accepted
updated: 2026-09-02
---
<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# ADR-0010 – Texturfilter der Pixelart-Spielwelt

## Kontext

Die visuelle Richtung verlangt scharf und kontrolliert dargestellte
Pixelart, lässt für atmosphärische Effekte aber bewusst weichere Gestaltung
zu. Held, Referenzobjekte und beide Weltzustände verwendeten im Prototyp
bereits Nearest-Neighbor. Vor einer verbindlichen Regel mussten
Nearest-Neighbor und lineare weiche Filterung bei allen drei Kamera-Zooms, in
Bewegung und in beiden Weltzuständen direkt verglichen werden.

## Entscheidung

**Nearest-Neighbor ist der Standardfilter für die Pixelart-Spielwelt.** Dies
gilt für Figuren, texturierte Tiles und Pixelart-Weltobjekte.

Weiche Filterung ist keine globale Alternative. Sie darf nur lokal für einen
konkret geprüften Darstellungsbereich verwendet werden, der nicht als
Pixelart gelesen werden soll, etwa einen künftig hochauflösend gestalteten
Licht-, Nebel- oder Magieeffekt. Der aktuelle Prototyp benötigt keine solche
Ausnahme.

## Folgen

Pixelart-Elemente setzen Nearest-Neighbor ausdrücklich oder erben es aus einem
eindeutig begrenzten Pixelart-Bereich. Eine Ausnahme muss im visuellen
Testlabor gegen den Standard geprüft und dokumentiert werden; sie darf keine
anderen Spielszenen umstellen.

Bei nicht ganzzahligen Verkleinerungen bleiben ungleich breite Pixel,
Rasterkadenz und der mögliche Verlust sehr feiner Details sichtbar. Diese
Nachteile werden bei Maßstab und Zoom gelöst oder bewusst akzeptiert. Die
gesamte Spielwelt weich zu filtern ist dafür keine zulässige Kompensation.
