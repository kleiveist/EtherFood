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

Die Bedienhilfe beginnt eingeklappt. `F5` blendet die Tastenübersicht und den
bedienbaren Pixel-Snap-Schalter ein oder aus; ein kleiner Hinweis auf `F5`
bleibt im eingeklappten Zustand sichtbar. Aktuelle Größen-, Zoom-, Welt- und
Fensterwerte gehören nicht in diese Übersicht, sondern ausschließlich in die
Diagnoseanzeige. Der Zustand der Bedienhilfe wird nicht gespeichert.

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

#### Pixel-Snap-Vergleich

Im mit `F5` geöffneten Testlabor-Menü schaltet ein fokussier- und anklickbarer
Knopf zwischen `Pixel-Snap: AN` und `Pixel-Snap: AUS`. `X` bietet denselben
Wechsel direkt während der Bewegung. Der boolesche Zustand wird gemeinsam mit
den vorhandenen Testwert-Presets gespeichert und beim nächsten Öffnen geladen.
Ältere Version-1-Dateien ohne den Schlüssel bleiben gültig und verwenden AUS.

Der Schalter setzt ausschließlich den Transform-Snap des aktiven Viewports.
Logische Positionen, Bewegung, Kollisionsformen und Kameragrenzen werden nicht
gerundet. Beim Verlassen des Testlabors wird die vorherige Viewport-Einstellung
wiederhergestellt. In der Diagnose bleiben Heldenposition, tatsächliches
Kamerazentrum und Weltanker mit zwei Nachkommastellen getrennt sichtbar.

Der Vergleich wurde im 1280-×-720-Testfenster mit kontrollierten Schritten von
2,2 Weltpixeln und allen drei Zoomstufen neu gerendert. Nach ganzzahliger
Ausrichtung blieb ein 200-×-100-Weltausschnitt mit AN in jeder Aufnahme
unverändert. Mit AUS änderten sich abhängig vom Zoom wiederholt bis zu 1.000
Pixel im selben Ausschnitt. Beim ausgerichteten Helden blieb AN im nahen und
mittleren Zoom stabil und änderte im weiten Zoom höchstens 8 Pixel; mit AUS
waren es bis zu 182 Pixel. Damit ist AN für feine Pixelmuster sichtbar ruhiger.

Die logische Kamera folgte in beiden Varianten gleichmäßig und ohne
zusätzlichen Sprung. Die gerasterte Bildschirmbewegung bleibt jedoch
zwangsläufig abgestuft: Im nahen Zoom wurden 2- bis 3-Pixel-, im mittleren
1- bis 2-Pixel-Schritte sichtbar. Im weiten Zoom zeigte AN vereinzelt ein
Haltebild mit anschließendem 2-Pixel-Schritt. AUS wirkt dort fließender,
erzeugt dafür das gemessene Flimmern zwischen Pixelpositionen. Für den
derzeitigen Prototyp gilt daher folgende Versuchsempfehlung:

| Bereich | Empfehlung | Begründung |
|---|---|---|
| Held | AN | Silhouette und innere Pixel bleiben in allen Zoomstufen ruhiger. |
| Kamera | AN für die Viewport-Darstellung | Die Welt bleibt stabil; die logische Kamera bleibt ungerundet und die weite Zoomkadenz muss weiter beobachtet werden. |
| Welt | AN | Tiles und feste Weltobjekte flimmern beim Kameraschwenk deutlich weniger. |

Das ist noch keine endgültige Pixelart-Regel. Texturfilter, Maßstab und Zoom
werden erst nach dem anschließenden Filtervergleich gemeinsam festgelegt.

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

Die Testgrafiken sind originale, lokal reproduzierbare Prototypassets. Der
Größenvergleich und der Weltzustandsvergleich teilen eine dunkle
Top-down-Pixelsprache; feinere Materialpixel ersetzen reine Diagrammformen,
ohne daraus bereits eine finale Art-Bible abzuleiten.

### 5. Diagnoseanzeigen

Entwickler sollen folgende Anzeigen unabhängig voneinander umschalten können:

```text
- Kollisionsformen
- aktuelle FPS
- Spielerkoordinaten
- tatsächliches Kamerazentrum und Weltanker
- aktueller Kamerazoom
- gewählte Tilegröße
- gewählte Figurengröße
- aktiver Weltzustand
- aktiver Pixel-Snap-Zustand
```

Die Anzeigen machen die jeweils aktive Testkonfiguration unmittelbar
erkennbar und sind nicht für normale Spielbuilds bestimmt.

`F3` beziehungsweise Controller-Select/Back schaltet das Diagnosepanel mit
FPS, Helden-, Kamera-, Weltanker-, Figuren-, Tile-, Weltzustands-, Pixel-Snap-
und Fensterwerten.
`F4` schaltet davon unabhängig eine eigene Zeichnung der vorhandenen
Helden-, Hindernis- und Weltgrenzen-Kollisionen. Beide Anzeigen beginnen bei
jedem Öffnen ausgeschaltet und werden nicht in den Testlabor-Einstellungen
gespeichert. Das Diagnosepanel aktualisiert seine Werte ungefähr alle
0,2 Sekunden. Die Kollisionszeichnung liest die bestehenden Physikformen nur
aus und verändert weder sie noch Godots globale Debug-Hinweise.

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
