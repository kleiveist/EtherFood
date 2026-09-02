<!-- AUTO-GENERATED:backlink START -->
[← Zurück](features.md)
<!-- AUTO-GENERATED:backlink END -->
# Funktion: Visuelles Testlabor

## Zweck

Das visuelle Testlabor ist eine interne Entwicklungsszene. Dort werden
Grafik, Maßstab, Kamera und Weltzustände getestet, ohne den eigentlichen
Spielabschnitt ständig verändern zu müssen.

Die Versuche folgen der
[visuellen Richtung V0](../../concept/60-produktion/visuelle-richtung-v0.md).
Sie dienen dem sichtbaren Vergleich und nehmen keine endgültige
Grafikentscheidung vorweg.

## Route und Zugang

```text
visual_lab
```

Die Route `visual_lab` darf nur in Entwicklungsbuilds erreichbar sein. In der
normalen Spielversion sind weder der Menüpunkt noch ein direkter Aufruf dieser
Route verfügbar. Das Testlabor ist eine reine Entwicklungsfunktion und kein
Bestandteil der Spielhandlung.

## Inhalt des Testlabors

### 1. Helden-Testfläche

Die Helden-Testfläche ermöglicht:

```text
- Spielfigur anzeigen
- Bewegung in vier Richtungen
- Idle- und Laufanimation testen
- Figurengröße vergleichen
- Schatten und Kollisionskörper anzeigen
```

### 2. Größenvergleich

Gemeinsam darzustellen sind:

```text
- Held
- normale Tür
- Hauswand
- Baum
- kleiner Gegner
- großer Gegner-Platzhalter
```

Damit wird geprüft, ob alle Größen zueinander passen. Die Vergleichsobjekte
sind originale EtherFood-Prototypassets und noch keine fertigen
Produktionsgrafiken. Sie werden durch ein lokales, deterministisches
Hilfsskript ohne Netzwerkzugriff erzeugt.

Alle Größenreferenzen verwenden dieselbe schräge Top-down-Spielperspektive.
Bei Figuren bleiben Kopfoberseite, Schultern und der mittige Bodenanker
lesbar; Gebäude zeigen Dachfläche, Dachkante und eine schmale südliche Wand.
Frontale Fassaden, Porträts und seitliche Plattformdarstellungen sind für
Weltobjekte im Vergleich nicht zulässig. Der bewegliche Held und die
nicht kollidierbaren Referenzobjekte werden anhand ihrer Bodenanker nach Y
sortiert, während die Maßstabsbeschriftungen stets darüber liegen.

Der derzeitige klassische 16-Bit-RPG-Stil ist eine Arbeitsrichtung für den
Prototyp und keine endgültige Art-Bible. Auch die sichtbaren Zielhöhen und
alle umschaltbaren Größenwerte bleiben vorläufige Testwerte.

### 3. Grafikvarianten

Umschaltbar sein sollen:

```text
- verschiedene Tilegrößen
- verschiedene Heldenhöhen
- naher Kamerazoom
- mittlerer Kamerazoom
- weiter Kamerazoom
- Pixel-Snap ein und aus
- Texturfilterung zum Vergleich
```

Die zu vergleichenden Tilegrößen, Heldenhöhen und Kameraansichten stammen aus
der visuellen Richtung V0. Die endgültige Auswahl erfolgt erst nach dem
sichtbaren Vergleich.

### 4. Weltzustände

Mindestens ein Testbereich besitzt zwei umschaltbare Zustände:

```text
Beschädigte Welt
↔
Wiederhergestellte Welt
```

Verglichen werden:

```text
- Farben
- Nebel
- Pflanzen
- Licht
- Boden
- Gebäudeschäden
```

Der Zustandswechsel dient ausschließlich dem direkten visuellen Vergleich.
Er benötigt weder Handlung noch Speichersystem.

### 5. Diagnoseanzeigen

Entwickler sollen folgende Anzeigen unabhängig voneinander umschalten können:

```text
- Kollisionsformen
- aktuelle FPS
- Spielerkoordinaten
- aktueller Kamerazoom
- gewählte Tilegröße
- gewählte Figurengröße
- aktiver Weltzustand
```

Die Anzeigen machen die jeweils aktive Testkonfiguration unmittelbar
erkennbar und sind nicht für normale Spielbuilds bestimmt.

## Nicht enthalten

```text
- richtige Handlung
- Dialoge
- Speicherstände
- vollständiges Kampfsystem
- endgültiger Held
- endgültige Gegner
- produktionsfertige Weltkarte
- fertige Spielgrafiken
```

## Prüfung

Das visuelle Testlabor ist ausreichend festgelegt, wenn:

- sein Zweck als unabhängige interne Entwicklungsszene eindeutig beschrieben
  ist,
- alle fünf Testbereiche dokumentiert sind,
- beschädigte und wiederhergestellte Welt direkt verglichen werden können,
- die umschaltbaren Diagnoseanzeigen festgelegt sind,
- `visual_lab` ausdrücklich nur in Entwicklungsbuilds erreichbar ist und
- noch keine endgültige Grafikentscheidung vorweggenommen wird.
