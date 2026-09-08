<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Green-Hero-Pixelart im visuellen Testlabor

## Zweck und Gesamtbild

Das visuelle Testlabor erhält einen umschaltbaren Vergleich zwischen der
bereits eingebundenen animierten Ultra-Grafik und den lokal bereitgestellten
Pixelart-Standbildern des Green Hero. Die Figur bleibt in acht Richtungen
beweglich; beim Stehen und Gehen zeigt jede Richtung das passende einzelne
Pixelart-Bild. Der Vergleich verändert weder den derzeitigen Spielstandard
noch die Grafik des Heldenraums.

## Ausgangslage

Der gemeinsame `HeroCharacter` verwendet eine `SpriteFrames`-Ressource mit
acht Stand- und acht Gehfolgen der Ultra-Variante. Das Testlabor instanziiert
diesen Helden unverändert und kann bislang nur Maßstab, Filter und weitere
Darstellungswerte ändern.

Unter `.workspace/hero/greenhero/Animatzion-PixelArt/` liegen 16 ignorierte
Arbeitsdateien mit transparentem `265 × 265`-Canvas. Jede Figur besitzt eine
sichtbare Höhe von 245 Pixeln. Zwei diagonale Standbilder heißen lediglich
`02_hinten_links.png` und `03_vorne_Links.png`; sie entsprechen Nordwesten und
Südwesten. `1walk/greenhero_w_stand.png` zeigt die westliche Gehpose.

## Umfang und Nicht-Ziele

Zum Umfang gehören geprüfte und einheitlich benannte Laufzeitkopien, eine
Pixelart-`SpriteFrames`-Ressource mit 16 Einzelfolgen, die maßstabs- und
fußpunktgleiche Umschaltung im Themenbereich `Darstellung`, lokale Speicherung,
automatisierte Prüfungen und die deutsche Entwicklungsdokumentation.

Nicht zum Umfang gehören neue Zwischenframes, eine Entscheidung zugunsten
einer Grafikvariante, Änderungen an der Spielgrafik außerhalb des Labors,
Änderungen an Bewegung oder Kollision sowie eine Übernahme als Spielstandard.

## Konkrete Schritte

1. Quelle, Richtung, PNG-Format, Canvas, Transparenz, sichtbare Höhe und Hashes
   der 16 Bilder prüfen.
2. Die Bilder kopieren, im Laufzeitbaum einheitlich nach Aktion und Richtung
   benennen und als 16 einrahmige Godot-Folgen beschreiben.
3. Im Darstellungsmenü den lokalen Vergleich `Ultra animiert` / `Pixelart
   Standbilder` ergänzen und Maßstab sowie Fußanker beim Wechsel angleichen.
4. Auswahl und Migration der lokalen Testlabor-Einstellungen ergänzen; die
   Variante ausdrücklich nicht als übernehmbaren Spielstandard behandeln.
5. Ressourcen-, Menü-, Richtungs-, Bewegungs- und Persistenzverhalten testen
   sowie Feature- und Referenzdokumentation aktualisieren.
6. Erst fokussierte Prüfungen und anschließend den vollständigen Standardlauf
   ausführen.

## Fortschritt

- [x] 2026-09-08: Repository-Regeln, Testlabor, bestehende Heldenanimation und
  Planstandard gelesen.
- [x] 2026-09-08: Alle 16 Arbeitsdateien visuell und technisch geprüft und den
  acht Richtungen zugeordnet.
- [x] 2026-09-08: Laufzeitassets und Pixelart-Ressource ergänzt.
- [x] 2026-09-08: Umschaltung, lokale Speicherung und Menü ergänzt.
- [x] 2026-09-08: Automatisierte Prüfungen und Dokumentation ergänzt.
- [x] 2026-09-08: Fokussierte und vollständige Prüfungen ausgeführt.

## Erkenntnisse und Überraschungen

- Alle Bilder verwenden denselben `265 × 265`-Canvas und dieselbe sichtbare
  Höhe von 245 Pixeln. Damit lassen sich Größenwechsel über einen gemeinsamen
  Referenzmaßstab durchführen.
- Die Arbeitsnamen sind in drei Fällen nicht normgerecht, die Motive selbst
  vervollständigen aber eindeutig beide Richtungssätze.
- Die Pixelart-Dateien enthalten bewusst nur je eine Pose. Eine laufende Figur
  wechselt daher richtungsabhängig zur Gehpose, ohne innerhalb der Richtung zu
  animieren.
- Der vollständige Godot-Lauf deckt unabhängig von diesem Arbeitspaket bereits
  vorhandene Widersprüche zwischen versionierten Standardressourcen und ihren
  älteren Testerwartungen auf. Die neue Pixelart-Suite selbst bleibt darin
  fehlerfrei.

## Entscheidungen

- Die Pixelart bleibt eine lokale Laborvariante ohne goldene
  Spielstandard-Markierung. Eine Auswahl im Labor ändert den Heldenraum nicht.
- Die bestehende Ultra-Variante bleibt der Startwert. Alte lokale
  Einstellungsdateien werden mit diesem Wert auf das neue Schema migriert.
- Der Referenzfußpunkt liegt mittig einen Pixel unter der sichtbaren Figur bei
  `(132,5, 255)`; die sichtbare Höhe 245 wird wie die Ultra-Referenz auf 80
  Weltpixel normalisiert.

## Prüfungen

- `file`, `identify`, Alpha-Zuschnitt und `sha256sum` für alle 16 Quellen —
  bestanden: RGBA, `265 × 265`, sichtbare Höhe 245 und unterscheidbare Dateien.
- Kontaktbogen aller 16 Quellen — geprüft: Stand und Gehen sind jeweils in N,
  NE, E, SE, S, SW, W und NW vorhanden.
- `.venv/bin/python -m unittest discover -s tools/tests -p 'test_*.py' -v` —
  bestanden: 197 Tests.
- Gezielte Godot-4.7.2-Suites für Hero-Grafik, F5-Menü, Gameplay,
  Pixel-Snap und die bestehende Green-Hero-Animation — jeweils bestanden.
- `PATH=/workspace/.ci-bin:$PATH .venv/bin/python tools/control.py check` —
  ausgeführt: Doctor 12/12, Stilprüfung für 84 Dateien, 197 Python-Tests und
  Godot-Ressourcenimport bestanden. Die vollständige Godot-Integration blieb
  wegen bereits vorhandener Abweichungen der Standardressourcen rot:
  Heldenhöhe 96 statt der erwarteten 80 Weltpixel, Kamerazoom 0,75 statt 1,00,
  Lauf-/Sprinttempo 210/450 statt 220/400 sowie beschädigter Nebel `low` statt
  `medium`. Es trat kein Fehler mit dem Präfix `VisualLabHeroGraphics` auf.
- `git diff --check` — bestanden.

## Wiederholbarkeit und Wiederherstellung

Die ignorierten Arbeitsquellen werden nur gelesen und kopiert. Versionierte
Laufzeitdateien verwenden stabile Namen; Godots Cache unter `game/.godot/`
bleibt generiert. Die Ultra-Ressource bleibt unverändert und ist jederzeit der
unabhängige Rückfallwert des Labors.

## Ergebnis und Rückblick

Das Testlabor kann die animierte Ultra-Grafik und die 16 einrahmigen
Pixelart-Posen jetzt unmittelbar im selben Bewegungs-, Kamera- und
Maßstabskontext vergleichen. Stand und Gehen decken alle acht Richtungen ab;
Größe und Fußpunkt bleiben beim Wechsel stabil. Die Auswahl wird lokal
gespeichert, ist aber weder Spielstandard noch Änderung am Heldenraum.

Damit ist der technische Sichttest vorbereitet. Die ästhetische Entscheidung
bleibt absichtlich offen, bis beide Varianten im laufenden Labor beurteilt
wurden.
