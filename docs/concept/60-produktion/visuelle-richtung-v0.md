---
title: Visuelle Richtung V0
status: accepted
updated: 2026-09-02
---
<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Visuelle Richtung V0

## Verbindlicher visueller Kern

EtherFood verwendet moderne Top-down-Pixel-Art.

Der visuelle Grundstil verbindet:

- düstere mittelalterliche Fantasy,
- eine beschädigte und neblige Welt,
- klare Silhouetten,
- eine gut erkennbare Spielfigur,
- einen deutlich sichtbaren Unterschied zwischen zerstörter und
  wiederhergestellter Welt.

Die Pixel-Art soll nicht wie eine technisch begrenzte alte Konsolengrafik
wirken. Moderne 2D-Techniken dürfen verwendet werden, solange Formen,
Figuren und interaktive Objekte gut lesbar bleiben.

## Moderne Pixel-Art

Die Pixel-Art entsteht durch bewusst gesetzte Pixel, Formen, Konturen,
Materialien und Animationen. Sie wird nicht durch eine künstlich niedrige
Bildschirmauflösung erzwungen.

Das Spiel darf eine hochauflösende interne Darstellung verwenden.

Für Beleuchtung und Atmosphäre dürfen moderne Techniken getestet werden:

- dynamisches 2D-Licht,
- Schatten,
- Partikeleffekte,
- Nebeleffekte,
- Shader,
- Ebeneneffekte,
- sanfte Lichtverläufe,
- kontrollierte Nachbearbeitung.

Pixel-Art-Sprites und Tiles sollen scharf und kontrolliert dargestellt
werden. Atmosphärische Effekte wie Licht, Nebel oder Magie dürfen bewusst
weicher gestaltet sein.

## Auflösung und Seitenverhältnis

Die vorläufige Referenzauflösung für Entwicklung und Tests ist:

- 1920 × 1080 Pixel,
- Seitenverhältnis 16:9.

Diese Auflösung ist noch keine endgültige technische Festlegung.

Das Spiel soll später auch breitere Bildschirmformate unterstützen.
Insbesondere sollen folgende Seitenverhältnisse getestet werden:

- 16:9,
- 21:9,
- 32:9.

Für die technische Planung ist das Seitenverhältnis wichtiger als die
physische Größe des Monitors.

Noch offen ist, wie zusätzliche Bildschirmbreite genutzt wird. Zu testen
sind insbesondere:

1. Die Spielwelt wird rechts und links weiter sichtbar.
2. Der spielerisch relevante Bildbereich bleibt begrenzt und die
   zusätzlichen Flächen werden für Atmosphäre oder Benutzeroberfläche
   verwendet.
3. Eine Mischform aus erweitertem Weltbild und begrenzter Kampfsicht wird
   eingesetzt.

Breitere Bildschirme dürfen Kämpfe, Gegnererkennung und Bossmechaniken
nicht unbeabsichtigt vereinfachen.

Die Benutzeroberfläche muss unabhängig vom Seitenverhältnis sinnvoll
positioniert bleiben.

## Kamera

Die Kamera folgt im ersten Prototyp der Spielfigur und bleibt zunächst
auf sie ausgerichtet.

Noch getestet werden:

- Kamerazoom,
- sichtbarer Weltbereich,
- leichte Kameraverzögerung,
- Kamerabegrenzungen,
- Verhalten in kleinen Räumen,
- Verhalten bei Kämpfen und Bossen.

Die endgültige Kameraführung wird erst nach dem visuellen Testlabor
festgelegt.

## Offene Stiltests

Im visuellen Testlabor werden verschiedene moderne
Pixel-Art-Ausprägungen miteinander verglichen.

### Detailgrad

- klare und reduzierte Pixel-Art,
- mittlerer Detailgrad,
- stark detaillierte moderne Pixel-Art.

### Figurenproportionen

- kompakte und stärker stilisierte Figuren,
- ausgewogene Fantasy-Proportionen,
- etwas natürlichere Proportionen.

### Konturen

- keine festen Außenkonturen,
- selektive Konturen,
- deutlichere dunkle Konturen.

### Beleuchtung

- einfache klare Beleuchtung,
- dynamische Licht- und Schatteneffekte,
- atmosphärische Beleuchtung mit Nebel und Shadern.

### Animation

- deutlich abgestufte Pixelanimation,
- mittlere Animationsdichte,
- flüssigere moderne Pixelanimation.

Diese Varianten sind Tests und noch keine endgültigen Stilentscheidungen.

## Größen für das visuelle Testlabor

### Tilegrößen

- 32 × 32 Pixel,
- 48 × 48 Pixel,
- 64 × 64 Pixel.

### Ungefähre Höhe der Spielfigur

- 64 Pixel,
- 80 Pixel,
- 96 Pixel.

### Kameraansichten

- nah,
- mittel,
- weit.

Die Größen werden immer gemeinsam mit Türen, Gegnern, Bäumen, Gebäuden
und interaktiven Objekten getestet. Keine dieser Größen ist bereits
verbindlich.

Die aktuelle Größenvergleichsreihe verwendet originale Prototypassets in
einer gemeinsamen schrägen Top-down-Perspektive. Weltobjekte dürfen dort
nicht frontal oder seitlich dargestellt werden: Figuren zeigen die
Kopfoberseite und ihren Bodenanker, Gebäude eine sichtbare Dachfläche und
Bäume ihre Krone. Eine klassische 16-Bit-RPG-Formsprache dient dabei nur als
Arbeitsrichtung für gute Lesbarkeit. Sie ist weder eine finale Art-Bible noch
eine Abkehr vom modernen visuellen Grundstil. Die Größenwerte bleiben
vorläufig.

## Weltzustände

### Verbindliches Spielprinzip

Die Welt besitzt beschädigte und wiederhergestellte Zustände.

Handlungen des Spielers können Bereiche, Gebäude, Pflanzen, Bewohner und
andere Teile der Welt dauerhaft wiederherstellen.

Der Unterschied zwischen beiden Zuständen muss unmittelbar sichtbar und
verständlich sein.

### Vorläufige Darstellung im Prototyp

Beschädigter Zustand:

- Nebel,
- schwächeres oder kälteres Licht,
- beschädigte Gebäude,
- abgestorbene oder geschwächte Pflanzen,
- reduzierte Farbwirkung,
- sichtbare Spuren des Weltverfalls.

Wiederhergestellter Zustand:

- weniger Nebel,
- klareres oder wärmeres Licht,
- reparierte Gebäude,
- lebendige Pflanzen,
- stärkere Farbwirkung,
- sichtbare Rückkehr von Leben und Aktivität.

Diese konkreten Farben und Effekte gelten nur als Arbeitsfassung für den
Prototyp. Die endgültige Farbpalette wird später festgelegt.

## Noch nicht festlegen

```text
- endgültige Farbpalette
- endgültiger Detailgrad
- endgültige Tilegröße
- endgültige Figurengröße
- endgültiger Kamerazoom
- endgültiges Verhalten auf Breitbildschirmen
- endgültige Licht- und Shadertechnik
- endgültiges Heldendesign
- endgültige Gegnerdesigns
- endgültiges Logo
- finales Game-Cover
```

## Erledigt, wenn

- moderne Top-down-Pixel-Art als Grundstil dokumentiert ist,
- HD-Darstellung ausdrücklich erlaubt ist,
- moderne Licht-, Nebel- und Shadertechnik berücksichtigt wird,
- 16:9 als vorläufige Referenz feststeht,
- 21:9 und 32:9 als offene Tests dokumentiert sind,
- die größeren Tile- und Figurentests enthalten sind,
- feste Weltzustände und vorläufige Darstellung getrennt sind,
- alle noch offenen Stilfragen eindeutig markiert sind.
