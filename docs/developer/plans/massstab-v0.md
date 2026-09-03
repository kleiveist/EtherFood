<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Maßstab V0

## Zweck und Gesamtbild

Aufgabe 20 wählt aus den vorhandenen Heldenhöhen, Tilegrößen und Kamerazooms
eine verbindliche Darstellungsgrundlage. Drei Kombinationen wurden im
visuellen Testlabor und im Heldenraum verglichen. Der Benutzer hat Kandidat B
ausgewählt; daraus entsteht das verbindlich benannte Profil `Maßstab V0`.

## Ausgangslage

Das Testlabor bietet Heldenhöhen von 64, 80 und 96 Weltpixeln, Tilegrößen von
32, 48 und 64 Weltpixeln sowie die Zoomstufen 0,75×, 1,00× und 1,50×. Das
Projekt verwendet vorläufig 1920 × 1080 im Seitenverhältnis 16:9. Aufgabe 17
hat Pixel-Snap geprüft; Aufgabe 18 bevorzugt Nearest-Neighbor. Der Heldenraum
arbeitet derzeit mit 80 Weltpixeln, einem 32er Raster und 1,50× Innenraumzoom.

## Umfang und Nicht-Ziele

Im Umfang liegen drei aus vorhandenen Werten gebildete Vergleichsprofile,
deren gemeinsame Anwendung im Testlabor, eine eindeutige Profilanzeige,
Persistenz über die bereits gespeicherten Einzelwerte, eine vollständige
Kombinationsmatrix, echte Rendervergleiche sowie Bewegungs-, Kamera-,
Kollisions-, Fenster- und Buildprüfungen.

Nicht im Umfang liegen neue Größenvarianten, neue Grafikassets, eine
großflächige Umstellung vorhandener Karten, neue Spielmechaniken oder eine
eigenmächtige gestalterische Endentscheidung. Aufgabe 21 bleibt die getrennte
systematische Ergebnisdokumentation.

## Konkrete Schritte

1. Vorhandene Größen-, Kamera-, Auflösungs-, Pixel-Snap- und Filterverträge
   aus Code, Tests und Dokumentation erfassen.
2. Drei deutlich unterscheidbare Kandidaten als gemeinsame Ressourcen aus
   ausschließlich vorhandenen Einzelwerten anlegen.
3. Im `F5`-Menü einen Kandidatenschalter ergänzen; eine manuelle Änderung
   einzelner Werte kehrt nachvollziehbar zum freien Vergleich zurück.
4. Diagnose um Vergleichsprofil, Referenzauflösung und Seitenverhältnis
   ergänzen.
5. Ressourcen, gemeinsames Anwenden, Laden, Diagnose und die vollständige
   Kombination aller vorhandenen Varianten automatisiert prüfen.
6. Kandidaten in beiden Weltzuständen und im Heldenraum rendern sowie
   Bewegungs-, Kamera-, Kollisions- und Fensterverhalten vergleichen.
7. Dem Benutzer die Kandidaten zur visuellen Auswahl vorlegen und die Aufgabe
   an diesem Entscheidungspunkt offen lassen.
8. Nach der Auswahl genau einen Kandidaten als `Maßstab V0` festlegen,
   Standardressourcen und Tests finalisieren, Build ausführen und committen.

## Fortschritt

- [x] 2026-09-03: Repository-Regeln, visuellen Kanon, Fahrplan, vorhandene
  Testwerte und aktuelle Laufzeitverträge geprüft.
- [x] 2026-09-03: Drei technische Vergleichskandidaten im Testlabor
  bereitstellen.
- [x] 2026-09-03: Automatische Kombinations- und Persistenztests ergänzen.
- [x] 2026-09-03: Render-, Bewegungs-, Kollisions- und Fensterprüfung
  durchführen.
- [x] 2026-09-03: Visuelle Endauswahl durch den Benutzer: Kandidat B.
- [x] 2026-09-03: Verbindliches Profil, Abschlussprüfung und Dokumentation.
- [x] 2026-09-03: Commit für Aufgabe 20 erstellen.

## Erkenntnisse und Überraschungen

- Die Referenzauflösung `1920 × 1080` und 16:9 sind bereits technisch im
  Projekt konfiguriert, laut visueller Richtung aber noch nicht endgültig
  freigegeben.
- Das Testlabor speichert bislang nur einzelne Werte. Ein Vergleichsprofil
  kann daraus beim Laden eindeutig erkannt werden, ohne ein zweites lokales
  Speichersystem einzuführen.
- Der Heldenraum verwendet ein 32er Raster, während sein 1,50× Zoom bereits
  als szenenabhängiges Innenraumprofil angelegt ist. Standard-Spielzoom und
  temporäre oder szenenspezifische Kameraüberlagerungen müssen getrennt
  bewertet werden.
- Das vorhandene Bedien- und Diagnosepanel war nach den zusätzlichen
  Profilzeilen in der realen 1280-×-720-Ausgabe zu niedrig. Beide Rahmen
  wurden innerhalb der logischen 1920-×-1080-Fläche verlängert; danach lagen
  alle Inhalte wieder vollständig im Panel.
- Ein Fenster mit 1000 × 600 Pixeln erzeugt wegen `aspect = keep` eine
  1000 × 562 Pixel große 16:9-Ausgabe. Die logische Fläche bleibt dabei
  1920 × 1080; der Vollbildmodus übernimmt denselben Vertrag.
- Kandidat A bietet im Außenvergleich die größte Übersicht, lässt den Helden
  bei der 1280-×-720-Ausgabe aber am kleinsten erscheinen. Kandidat C macht
  Held und Objekte sehr deutlich, schneidet dafür große Teile der
  Vergleichsfläche ab und weicht mit seinem 48er Raster vom Heldenraum ab.
  Kandidat B hält Held und kleine Objekte gut lesbar, zeigt mehr Umgebung als
  C und übernimmt mit 80 Pixeln und dem 32er Raster zwei bereits verwendete
  Heldenraumwerte. Der Benutzer hat diese Empfehlung visuell freigegeben.
- Im stark verkleinerten Headless-Test bewegt sich die gerasterte Kamera nicht
  in jedem Physikframe. Der Kameratest muss deshalb die tatsächliche
  Ausgabepixel-Rasterweite berücksichtigen und darf keine kontinuierliche
  Eins-zu-eins-Bewegung voraussetzen.

## Entscheidungen

- Kandidat B ist `Maßstab V0`: Heldenhöhe `80 px`, Tilegröße `32 × 32 px`,
  Standard-Zoom `1,00×`, Referenzauflösung `1920 × 1080`, 16:9, Pixel-Snap
  `AN` und Nearest-Neighbor.
- `1,00×` gilt für die normale Spielansicht. Kleine Räume und begründete
  Settings dürfen eigene Kameraprofile verwenden; der Heldenraum bleibt bei
  `1,50×`.
- Kandidaten A und C bleiben als Testprofile erhalten. Kein Profil ändert
  Kollisionsform, Bewegungsgeschwindigkeit, Kartenabmessung oder
  Referenzgrafik.

## Prüfungen

- `python3 tools/control.py style`: erfolgreich; 75 Quelldateien geprüft.
- Godot-Editorimport mit 4.7.2: erfolgreich; neue Klassen und Ressourcen
  erkannt.
- Bootstrap-Integrationstest mit Godot 4.7.2: erfolgreich. Die neue Suite
  prüft 54 Kombinationen aus zwei Weltzuständen, drei Heldenhöhen, drei
  Tilegrößen und drei Zoomstufen.
- Kandidatenprüfung: gemeinsames Anwenden und Laden, Diagnose, Pixel-Snap,
  Nearest-Neighbor sowie unveränderte Kollisions- und Bewegungskonfiguration
  erfolgreich.
- Echte OpenGL-Aufnahmen mit Mesa llvmpipe: A, B und C in beiden
  Weltzuständen, am Tile- und Referenzobjektvergleich sowie vorübergehend im
  Heldenraum gerendert. Bedien- und Diagnosepanel anschließend ohne
  Überlauf geprüft.
- Finale OpenGL-Kontrollaufnahme mit Maßstab V0: Profilname, 80-px-Held,
  32er Raster, 1,00×, Referenzauflösung, Pixel-Snap und Filter werden
  vollständig und ohne Panelüberlauf angezeigt.
- Fensterprüfung: 1280 × 720 sowie 1000 × 600 geprüft; die kleinere
  Fensterfläche rendert unverzerrt als 1000 × 562 im festen 16:9-Verhältnis.
  Vollbildmodus wurde aktiviert; die logische Referenz blieb 1920 × 1080.
- `PATH=/tmp/etherfood-godot-4.7.2.cIHgoO:$PATH python3 tools/control.py
  check`: erfolgreich; Umgebungsprüfung, Stilprüfung, 177 Python-Tests und
  Godot-Bootstrap-Integration bestanden.
- Projektstart mit Godot 4.7.2 im Headless-Modus: erfolgreich und ohne
  Laufzeitfehler.

## Wiederholbarkeit und Wiederherstellung

Kandidaten liegen als versionierte Ressourcen vor. Automatische Tests
verwenden einen isolierten `user://`-Pfad. Renderaufnahmen und lokale
Engine-Caches bleiben außerhalb des Repositorys. Die vorhandenen Einzelwerte
bleiben weiterhin manuell auswählbar.

## Ergebnis und Rückblick

### Maßstab V0

| Eigenschaft | Verbindlicher Wert |
|---|---|
| Heldenhöhe | 80 px |
| Tilegröße | 32 × 32 px |
| Standard-Zoom | 1,00× |
| Referenzauflösung | 1920 × 1080 |
| Seitenverhältnis | 16:9 |
| Pixel-Snap | AN |
| Texturfilter | Nearest-Neighbor |

### Prüfung

- Heldenraum getestet: Ja; 80-px-Held und 32er Raster stimmen überein.
- Visuelles Testlabor getestet: Ja; Maßstab V0 ist frischer Standard und als
  vollständiges Profil ladbar.
- Beschädigter Weltzustand getestet: Ja.
- Wiederhergestellter Weltzustand getestet: Ja.
- Bewegung fehlerfrei: Ja; alle Profile und 54 Kombinationen geprüft.
- Kamera fehlerfrei: Ja; Grenzen, Bewegung und drei Zoomstufen geprüft.
- Kollision fehlerfrei: Ja; Profile verändern keine Physikform.
- Vollbild getestet: Ja; logische Referenz bleibt 1920 × 1080.
- Fensterdarstellung getestet: Ja; 1280 × 720 und 1000 × 600 geprüft.

### Begründung

Die 80-px-Figur bleibt im Innen- und Außenvergleich deutlich, ohne den
sichtbaren Weltbereich so stark wie Kandidat C zu verkleinern. Das 32er Raster
passt zu den bestehenden Türen, Wegen und dem Heldenraum und vermeidet eine
unnötige Vergrößerung späterer Pixelart-Assets. `1,00×` bietet für die normale
Spielansicht den ausgewogensten Überblick. Kandidat A wurde wegen der kleineren
Figurenwirkung, Kandidat C wegen des engeren Ausschnitts und des abweichenden
48er Rasters verworfen. Der erlaubte kleine Innenraumzoom `1,50×` bewahrt die
settingabhängige Lesbarkeit, ohne den globalen Standard umzudeuten.
