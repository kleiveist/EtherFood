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
Sie dienen dem sichtbaren Vergleich. Abgeschlossene Einzeltests halten ihre
bestätigten Entscheidungen hier fest, ohne offene Folgefragen vorwegzunehmen.

## Route und Zugang

```text
visual_lab
```

Die Route `visual_lab` darf nur in Entwicklungsbuilds erreichbar sein. In der
normalen Spielversion sind weder der Menüpunkt noch ein direkter Aufruf dieser
Route verfügbar. Das Testlabor ist eine reine Entwicklungsfunktion und kein
Bestandteil der Spielhandlung.

Die Bedienhilfe beginnt eingeklappt. `F5` blendet die Tastenübersicht sowie die
bedienbaren Schalter für Maßstabsprofile, Nebel, Licht, Pixel-Snap und
Texturfilter ein oder aus; ein kleiner Hinweis auf `F5` bleibt im
eingeklappten Zustand sichtbar. Aktuelle Größen-, Zoom-, Welt- und
Fensterwerte gehören nicht in diese Übersicht, sondern ausschließlich in die
Diagnoseanzeige. Der Zustand der Bedienhilfe wird nicht gespeichert.

## Laufende Testergebnisse

### Pixel-Snap und Kamerazoom – 2. September 2026

Der folgende Ausgangsbefund hat die erste Abnahme von Aufgabe 17 aufgehoben:

| Einstellung | Ergebnis | Status |
|---|---|---|
| Figur | 80 px | vorläufig geeignet |
| Tiles | 32 × 32 px | vorläufig geeignet |
| Texturfilter | Nearest-Neighbor | bevorzugter Kandidat |
| Pixel-Snap bei 1,00× | kein sichtbares Flackern | bestanden |
| Pixel-Snap bei 1,50× | Held flackert bei Bewegung | nicht bestanden |
| Welt-/Dungeonkamera | 1,00× | bevorzugter Kandidat |
| Kleine Innenräume | 1,50× | später als Szenenprofil freigegeben |

Pixel-Snap war damit noch nicht abschließend abgenommen. Der Fehler trat bei
`1920 × 1080` reproduzierbar auf, während `1,50 ×` im Fenster mit
`1280 × 720` durch dessen Skalierung von zwei Dritteln effektiv auf
`1,00 ×` Ausgabeskalierung kam und ruhig wirkte.

Die erste Korrektur rundete nicht die physische Position des
`CharacterBody2D`, sondern koppelte Heldenbild und Kamera auf einem groben
Weltpixelraster. Zusätzlich blieb Godots globales Transform-Snap aktiv. Der
anschließende praktische Nachtest hat diese Lösung am selben Tag verworfen:

| Einstellung | Praktischer Gegenbefund | Status |
|---|---|---|
| `1,00×`, Pixel-Snap AN | Welt schimmert und flackert bei Bewegung stark | nicht bestanden |
| `1,50×`, Pixel-Snap AN | Welt schimmert und flackert bei Bewegung stark | nicht bestanden |
| Pixel-Snap AUS | Kanten flackern wie vor der Korrektur | nicht bestanden |
| Heldenanzeige | bleibt gegenüber der Kamera fixiert | Teilproblem gelöst |

Die Bildanalyse hatte zwar gleich ausgerichtete Einzelmuster verglichen, aber
die ungleichmäßige zeitliche Bewegung nicht ausreichend bewertet. Das grobe
Raster erzeugte bei `1,50 ×` beispielsweise eine `6/6/3`-Pixel-Kadenz. Das
globale Transform-Snap rundete zudem verschachtelte Weltobjekte unabhängig
voneinander. Beides erklärt, warum AN im direkten Spieltest unruhiger wirkte.

Die zweite Korrektur verwendet deshalb ein gemeinsames, rein visuelles Raster
von genau einem Ausgabepixel. Seine Weltweite wird aus Kamerazoom und
Fensterskalierung berechnet. Kamera und Heldenbild bleiben in ihrer
vorhandenen Hierarchie; Viewport-Transform-Snap, Vertex-Snap und
Kamera-Smoothing bleiben AUS. Eine feste Viertelpixelphase hält Kanten von der
numerisch instabilen Rundungsgrenze fern; bei Nearest-Neighbor bleibt sie ohne
weiche Zwischenpixel. Bewegung, `move_and_slide()` und Kollision bleiben
unverändert.

Die automatisierte Wiederholung umfasst horizontale, vertikale und diagonale
Bewegung sowie getrennt verfolgte Ausschnitte für Held, Tilefläche und
Weltobjekte:

| Einstellung | Technisches Ergebnis der zweiten Korrektur | Status |
|---|---|---|
| `1,00×`, Pixel-Snap AN, Nearest | ganze Ausgabepixelschritte; Muster stabil | bestanden |
| `1,50×`, Pixel-Snap AN, Nearest | kleinste 5-/6-Pixel-Kadenz; Muster stabil | bestanden |
| Pixel-Snap AUS, Nearest | unveränderte freie Vergleichsbewegung | bekannte Kantenunruhe |
| Fenster 1920 × 1080 | keine grobe 3-/6-Pixel-Kadenz mehr | bestanden |
| Fenster 1280 × 720 | Fensterskalierung im Ausgaberaster berücksichtigt | bestanden |

Der anschließende direkte Bewegungstest wurde am 3. September 2026 abgenommen;
Pixel-Snap gilt damit als getestet. Aufgabe 20 hat `1,50×` anschließend als
zulässiges Szenenprofil für kleine Innenräume bestätigt; die normale
Spielansicht bleibt `1,00×`.

Der angezeigte Weltzustand `Beschädigt` bezeichnet ausschließlich den Zustand
des jeweiligen Tests. Beschädigte und wiederhergestellte Welt bleiben
gleichberechtigte Spiel- und Testzustände; keiner von beiden ist eine globale
Darstellungsregel.

## Maßstab V0

Der Benutzer hat am 3. September 2026 Kandidat B als verbindlichen
`Maßstab V0` ausgewählt:

| Eigenschaft | Verbindlicher Wert |
|---|---|
| Heldenhöhe | 80 px |
| Tilegröße | 32 × 32 px |
| Standard-Zoom | 1,00× |
| Referenzauflösung | 1920 × 1080 |
| Seitenverhältnis | 16:9 |
| Pixel-Snap | AN |
| Texturfilter | Nearest-Neighbor |

`1,00×` bezeichnet die normale Spielansicht. Kleine Räume dürfen wie der
Heldenraum über ein Szenenprofil `1,50×` verwenden; weitere
Setting-spezifische Profile bleiben möglich. Der Held kennt diese
Szenenentscheidung nicht selbst. Die verbindliche Begründung steht in
[ADR-0011](../../concept/entscheidungen/ADR-0011-massstab-v0.md).

Für Regressionen bewahrt das Testlabor zwei abweichende Kombinationen auf:

| Profil | Heldenhöhe | Tilegröße | Kamera | Schwerpunkt |
|---|---:|---:|---:|---|
| A · Weite Übersicht | 64 px | 32 × 32 px | 0,75× | größter sichtbarer Weltbereich |
| Maßstab V0 | 80 px | 32 × 32 px | 1,00× | verbindliche normale Spielansicht |
| C · Nah und groß | 96 px | 48 × 48 px | 1,50× | maximale Figuren- und Objektnähe |

Alle drei Profile enthalten die Referenzauflösung `1920 × 1080`, 16:9,
Pixel-Snap `AN` und Nearest-Neighbor. Der Knopf `Maßstabsprofil` im
`F5`-Menü schaltet `A → Maßstab V0 → C` als vollständige Bündel um. Eine
manuelle Änderung von Heldenhöhe, Tilegröße, Zoom, Pixel-Snap oder Filter
kennzeichnet den Zustand als `Freier Vergleich`.

Eine frische oder unvollständige Testlabor-Konfiguration lädt `Maßstab V0`.
Die vorhandene Datei `user://visual_lab_settings.cfg` speichert weiterhin die
Einzelwerte; daraus wird beim Laden das passende Profil erkannt. Die
verbindliche Ressourcenquelle ist
`game/shared/resources/visual_baseline_v0.tres`, nicht die lokale
Einstellungsdatei. Bestehende Karten wurden nicht großflächig umgebaut. Der
Heldenraum liest die Heldenhöhe aus dem Maßstab und verwendet dasselbe 32er
Raster, behält aber sein passendes kleines Innenraumprofil mit `1,50×`.

Die verbindlichen Ergebnisse des gesamten Testlabors sind in der
[visuellen Darstellungsgrundlage V0](../architecture/visuelle-darstellungsgrundlage-v0.md)
zusammengeführt. Diese Funktionsseite behält die ausführlichen historischen
Vergleiche und die Bedienung des Labors bei.

## Inhalt des Testlabors

### 1. Helden-Testfläche

Die Helden-Testfläche ermöglicht:

```text
- Spielfigur anzeigen
- normale, schnelle, verstärkte und schleichende Bewegung in vier Richtungen
- Standard-, Lauf- und Boostsprung
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
Prototyp und keine endgültige Art-Bible. Die abweichenden umschaltbaren
Größenwerte bleiben Testwerte; Maßstab V0 ist davon eindeutig getrennt.

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
- Nebelstärken je Weltzustand
- Lichtprofile je Weltzustand
```

Die umschaltbaren Tilegrößen, Heldenhöhen und Kameraansichten stammen aus der
visuellen Richtung V0. Der sichtbare Vergleich ist abgeschlossen; die
Varianten bleiben für spätere Regressionen verfügbar.

#### Pixel-Snap-Vergleich

Im mit `F5` geöffneten Testlabor-Menü schaltet ein fokussier- und anklickbarer
Knopf zwischen `Pixel-Snap: AN` und `Pixel-Snap: AUS`. `X` bietet denselben
Wechsel direkt während der Bewegung. Der boolesche Zustand wird gemeinsam mit
den vorhandenen Testwert-Presets gespeichert und beim nächsten Öffnen geladen.
Ältere Version-1-Dateien ohne den Schlüssel bleiben gültig und verwenden den
Standard `AN`.

Der Schalter rastert ausschließlich die visuellen Positionen von Kamera und
Heldenbild auf ganze Ausgabepixelschritte. Das globale Viewport-Transform-Snap
bleibt AUS, damit verschachtelte Weltobjekte nicht unabhängig voneinander
gerundet werden. Logische Positionen, Bewegung, Kollisionsformen und
Kameragrenzen werden nicht verändert. Beim Verlassen des Testlabors werden die
vorherigen Viewport-Einstellungen wiederhergestellt. In der Diagnose bleiben
rohe und gerasterte Positionen getrennt sichtbar.

Der erste Vergleich nur bei `1280 × 720` reichte für die Abnahme nicht aus,
weil die Fensterskalierung dort den Kamerazoom `1,50 ×` zu einer ganzzahligen
Ausgabeskalierung machte. Der korrigierte Vergleich prüft deshalb zusätzlich
`1920 × 1080` und echte Bewegung in drei Richtungen. Details und der
chronologische Ausgangsbefund stehen unter
[Laufende Testergebnisse](#laufende-testergebnisse). Der anschließende
Sichttest hat Held, Kamera und Welt bei `1,00×` und `1,50×` bestätigt.
Aufgabe 20 ordnet diese Ausgabepixel-Ausrichtung dem verbindlichen Maßstab V0
zu.

#### Texturfilter-Vergleich

Neben Pixel-Snap steht im `F5`-Menü ein zweiter fokussier- und anklickbarer
Knopf. Er wechselt zwischen `Texturfilter: Nearest-Neighbor` und
`Texturfilter: Weich`; `N` ermöglicht denselben Wechsel während des laufenden
Tests. Die ID `nearest` oder `soft` wird zusammen mit den vorhandenen
Testwerten gespeichert. Version-1-Presets ohne gültige Filter-ID verwenden
Nearest-Neighbor.

Die Umschaltung erfasst ausschließlich die 51 texturierten `Sprite2D`-
Instanzen unter `TestWorld`: den Held, den texturierten Vergleichsboden, die
Größenreferenzen und die Sprites beider Weltzustände. Sie ändert weder die
globale Projekteinstellung noch Szenenressourcen. Beim Verlassen werden alle
vorherigen Instanzwerte wiederhergestellt. Vektorgezeichnete Tile-Raster und
Kollisionsformen besitzen keine Texturabtastung und bleiben deshalb in beiden
Varianten identisch.

Der vorläufige Vergleich wurde bei 1280 × 720 mit aktivem Pixel-Snap, kontrollierten
Schritten von 2,2 Weltpixeln und 124 echten OpenGL-Aufnahmen durchgeführt.
Getestet wurden alle drei Zoomstufen, Stillstand und Bewegung des Helden,
Kameraverfolgung, texturierter Boden, Referenzobjekte sowie beschädigter und
wiederhergestellter Weltzustand.

| Testbereich | Nearest-Neighbor | Weich |
|---|---|---|
| Held im Stillstand | harte Silhouette und klare Innenpixel | bei nicht ganzzahliger Ausgabe sichtbar geglättet |
| Held in Bewegung | klare Pixel, Rasterkadenz bleibt sichtbar | weichere Kanten, aber dieselbe Rasterkadenz |
| Kameraverfolgung | unveränderte logische Folgebewegung | unveränderte logische Folgebewegung |
| Zoom Nah, 1,50× | bei der getesteten Ausgabe pixelgleich zu Weich | bei exakter Ausrichtung kein sichtbarer Gewinn |
| Zoom Mittel, 1,00× | schärfer, vereinzelt ungleich breite Ausgabepixel | deutlich mehr Mischfarben und Unschärfe |
| Zoom Weit, 0,75× | härter, sehr feine Details können ausdünnen | etwas ruhiger, aber feine Details verschmelzen |
| Tiles und Kanten | texturierter Boden bleibt klar; Vektorraster unverändert | Boden wird weich; Vektorraster unverändert |
| Weltobjekte | Materialpixel und Konturen bleiben lesbar | Konturen und kleine Materialwechsel verwischen |
| beschädigter Weltzustand | Schäden und kahle Vegetation bleiben klar | feine Schadenskanten werden weicher |
| wiederhergestellter Weltzustand | Pflanzen und Gebäudedetails bleiben klar | kleine Blatt- und Mauerpixel verschmelzen |

Die ganzzahlige Ausgabe des nahen Zooms ergab zwischen beiden Filtern keine
abweichenden Pixel. Beim mittleren Zoom änderten sich je nach Bildbereich rund
13.000 Ausgabepixel; die weiche Variante erzeugte dort wesentlich mehr
interpolierte Farben. Im weiten Zoom war der Unterschied kleiner, weil beide
Varianten bereits auf die halbe Ausgabegröße verkleinerten.

Die Kamerafahrten zeigten für beide Filter dieselbe Folge gerasterter Schritte:
nah überwiegend 2 bis 3 Pixel, mittel 1 bis 2 Pixel und weit vereinzelt ein
Haltebild vor einem 2-Pixel-Schritt. Weiche Filterung ändert diese Bewegung
nicht, sondern kaschiert Kanten lediglich durch Farbmischung. Bewegung,
Kollision, Kameragrenzen und Pixel-Snap-Zustand blieben unverändert.

Nearest-Neighbor wurde damit zum bevorzugten Kandidaten. Der anschließende
Vergleich mit allen drei Zoomstufen wurde am 3. September 2026 abgenommen;
Aufgabe 18 gilt damit als abgeschlossen. Aufgabe 20 hat den Filter als
Standard für Pixelart in Maßstab V0 übernommen. Bewusst weich angelegte
Atmosphäreneffekte bleiben davon ausgenommen.

#### Nebel und Licht

Stand: 3. September 2026.

`V` wechselt weiterhin zwischen beschädigter und wiederhergestellter Welt.
`B` beziehungsweise der Nebelknopf im `F5`-Menü durchläuft die drei
Nebelstärken des aktiven Zustands. `L` beziehungsweise der Lichtknopf
durchläuft dessen zwei Lichtprofile. Die Auswahl wird für beide Weltzustände
getrennt im vorhandenen Testlabor-Preset gespeichert; ein Zustandswechsel
stellt die zuletzt gewählte Kombination dieses Zustands wieder her. Alte
Version-1-Presets ohne diese Werte und unbekannte IDs verwenden die
bevorzugten Varianten.

Die deckungsgleiche Vergleichsfläche misst jetzt `1440 × 810` Pixel. Sie
verbindet das vorhandene Haus mit einem offenen Laufweg, zwölf Bäumen und
einer Sägewerk-Teststation. Haus, Wald und Sägewerk besitzen paarige
beschädigte und wiederhergestellte Prototypgrafiken. Diese Zusammenstellung
ist ausschließlich eine nicht-kanonische Entwicklungskulisse; sie legt weder
einen Ort noch eine Spielmechanik fest.

Die bisherigen geraden Nebelbänder wurden durch zwei wolkige RGBA-Texturen
ersetzt. Sie besitzen unregelmäßige Bänke, Lücken und 16 abgestufte
Transparenzwerte. Das Bildgenerator-Ergebnis wurde auf ein logisches
`720 × 405`-Raster reduziert, mit Nearest-Neighbor auf `1440 × 810`
verdoppelt, zustandsabhängig eingefärbt und ohne Metadaten komprimiert. Der
beschädigte Nebel bleibt höchstens 68 Prozent, der wiederhergestellte
höchstens 38 Prozent deckend. Die Variantensteuerung verändert weiterhin nur
Sprite-Deckkraft und flächige Farbmodulation; Shader, Physik und Spielmechanik
bleiben unberührt.

##### Beschädigter Weltzustand

- Gewählte Nebelstärke: Mittel
- Gewähltes Lichtprofil: Kühl und dunkel
- Helligkeit: Sehr dunkel
- Kontrast: Mittel
- Farbstimmung: Kühl und entsättigt
- Sichtbarkeit des Helden: Im Stillstand und bei Bewegung in allen drei
  Zoomstufen erhalten; selbst die hohe Nebelvariante verdeckt ihn nicht.
  Hauskontur, beschädigtes Sägewerk, Weg und kahle Waldsilhouetten bleiben
  unterscheidbar.
- Bekannte Probleme: Die Varianten sind bewusst auf die vorhandene
  Testlabor-Vorschau begrenzte Prototypwerte. Die hohe Nebelstufe ist nur ein
  Vergleichsextrem und keine Produktionsvorgabe.

##### Wiederhergestellter Weltzustand

- Gewählte Nebelstärke: Gering
- Gewähltes Lichtprofil: Warm und klar
- Helligkeit: Hell
- Kontrast: Hoch
- Farbstimmung: Leicht warm
- Sichtbarkeit des Helden: Im Stillstand und bei Bewegung in allen drei
  Zoomstufen erhalten; Figur, Weg, arbeitendes Sägewerk und dichter Wald
  bleiben klar getrennt.
- Bekannte Probleme: Die warme Farblage und die geringe Nebelstärke sind
  vorläufige Vergleichswerte. Eine endgültige Palette oder ein finales
  Atmosphärenasset wird daraus noch nicht abgeleitet.

##### Technische Prüfung

- Getestete Zoomstufen: Weit `0,75×`, Mittel `1,00×` und Nah `1,50×`.
- Verhalten bei Kamerabewegung: 72 OpenGL-Bewegungsaufnahmen mit je zwölf
  Bildern pro Zustand und Zoom wurden auf der vergrößerten Fläche verglichen.
  Nebel, Licht, Haus, Wald und Sägewerk blieben gemeinsam an der Welt
  verankert; es trat kein separates Springen oder Flackern einer
  Atmosphärenlage auf.
- Verhalten beim Weltzustandswechsel: Alle 36 Kombinationen aus zwei
  Zuständen, drei Nebelstärken, zwei Lichtprofilen und drei Zoomstufen wurden
  gerendert. Der Wechsel hinterließ keine Ebene und keinen Farbwert des
  vorherigen Zustands.
- Auswirkungen auf die Leistung: In einem isolierten
  Software-OpenGL-Lauf mit je 360 Frames erreichten die bevorzugten Profile
  auf der vergrößerten Fläche 64,20 Frames/s (beschädigt) und 61,66 Frames/s
  (wiederhergestellt). Beide Läufe blieben auch im softwaregerenderten
  llvmpipe-Vergleich oberhalb von 60 Frames/s; die statischen Wolkenbilder
  benötigen keine laufende Atmosphärenberechnung.
- Preset-Speicherung geprüft: Ja; aktive und inaktive Zustandsauswahl werden
  gespeichert, geladen und bei ungültigen IDs kontrolliert zurückgesetzt.
- Lesbarkeit und Kollision: Die Render- und Laufzeittests bestätigten
  sichtbare Helden-, Hindernis- und Grenzkonturen in beiden Zuständen. Die
  vergrößerte Kulisse fügt keine Kollisionsform hinzu; Bewegung,
  `move_and_slide()` und die vorhandenen Testhindernisse blieben unverändert.

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
- rohe Spielerkoordinaten und gerasterte Heldenanzeige
- rohe und gerasterte Kameraposition, tatsächliches Kamerazentrum und Weltanker
- Kameraprofil, Darstellungsraster, Rasterphase und Fensterskalierung
- Basis- und aktiver Kamerazoom
- aktueller Bewegungs- und Sprungzustand
- gewählte Tilegröße
- gewählte Figurengröße
- aktives Maßstabsprofil oder freier Vergleich
- Referenzauflösung und Seitenverhältnis
- aktiver Weltzustand
- aktive Nebelstärke
- aktives Lichtprofil
- aktiver Pixel-Snap-Zustand
- aktiver Texturfilter
```

Die Anzeigen machen die jeweils aktive Testkonfiguration unmittelbar
erkennbar und sind nicht für normale Spielbuilds bestimmt.

`F3` beziehungsweise Controller-Select/Back schaltet das Diagnosepanel mit
FPS, roher Heldenposition, gerasterter Heldenanzeige, rohem und gerastertem
Kameraziel, tatsächlichem Kamerazentrum, Weltanker, Maßstabsprofil,
Referenzauflösung, Seitenverhältnis, Kameraprofil, Basis- und Aktivzoom,
Bewegungs- und Sprungzustand, Figuren-, Tile-, Weltzustands-, Nebel-,
Lichtprofil-, Pixel-Snap-, Viewport-Transform-Snap-, Vertex-Snap-,
Darstellungsraster-, Rasterphasen-, Texturfilter-, Fenster- und
Fensterskalierungswerten.
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
- noch offene Grafikentscheidungen nicht ohne ihren vorgesehenen Vergleich
  vorweggenommen werden.
