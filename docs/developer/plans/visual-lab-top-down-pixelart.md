<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Top-down-Pixelart im visuellen Testlabor

## Zweck und Gesamtbild

Der Größenvergleich im visuellen Testlabor soll wie ein spielbarer Ausschnitt
eines klassischen Top-down-RPG-Prototyps wirken. Originale, lokal und
deterministisch erzeugte Pixelgrafiken ersetzen die technischen Formen, ohne
Maßstab, Bewegung, Kollision, Kamera, gespeicherte Testwerte oder die
Weltzustandsfunktion zu verändern.

## Ausgangslage

Der Arbeitsbaum war zu Beginn sauber. `main` enthielt bereits die neueren
Anpassungen an Weltzustandsvorschau und Ingame-Zeitrechnung. Held und fünf
Größenreferenzen bestanden aus `Polygon2D`-Formen; der Vergleichsboden war
eine einfarbige Weltfläche und die Anzeige bestand aus ungerahmten Labels.

Der vollständige Kontrolllauf hatte bereits vor diesem Umbau drei bekannte,
auf veralteten Dokumentationspfaden beruhende Fehler. Die Godot-Prüfungen und
172 von 175 Python-Prüfungen waren erfolgreich. Diese fremden
Dokumentationsbaustellen werden nicht stillschweigend verändert.

## Umfang und Nicht-Ziele

Im Umfang liegen die sichtbare Heldendarstellung, fünf Größenreferenzen,
Vergleichsboden, Testlabor-HUD, zugehörige Tests und knappe visuelle
Dokumentation. Die Assets entstehen ohne Netzwerkzugriff durch ein
reproduzierbares Python-Hilfsskript aus geometrischen Pixeloperationen.

Nicht geändert werden Objekt- und Presetgrößen, Kamera- und Tilewerte,
Bewegungsgeschwindigkeit, Kollisionskörper, Kameragrenzen,
Einstellungsschema, Weltzustandslogik oder Menüführung. Animationen,
Gegnerlogik, neue Kollisionen und Produktionsassets bleiben außerhalb dieses
Plans.

## Konkrete Schritte

1. Deterministischen Assetgenerator und begrenzte gemeinsame Farbpalette
   anlegen; transparente PNGs für Held und Referenzen sowie eine Pixelboden-
   Fläche erzeugen.
2. Heldenszene auf ein nach unten blickendes, fußverankertes `Sprite2D`
   umstellen und ausschließlich `Appearance` für 64/80/96 Weltpixel skalieren.
3. Fünf Referenzen bei identischen Positionen auf `Sprite2D` umstellen,
   gemeinsame Bodenlinie und Zielhöhen sichern sowie Y-Sortierung aktivieren.
4. Vergleichsboden und Testlabor-Anzeige als kantige Pixelart-/HUD-Fläche
   gestalten; Hinweise und Bedienung unverändert erhalten.
5. Laufzeittests auf Texturen, Alpha-Sichtgrenzen, Bodenanker, Filterung,
   fehlende Referenzkollisionen, Y-Sortierung und bestehende Abläufe anpassen.
6. Bestehende visuelle Dokumentation knapp ergänzen, Assets visuell prüfen und
   die geforderten automatischen sowie interaktiven Prüfungen ausführen.

## Fortschritt

- [x] Git-Stand, Repository-Regeln, Szene, Skripte und betroffene Tests geprüft.
- [x] Unveränderliche Werte und vorhandene fremde Kontrolllauf-Fehler erfasst.
- [x] Originalassets und Generator erstellt und reproduzierbar verifiziert.
- [x] Held, Referenzen, Boden, Y-Sortierung und HUD umgebaut.
- [x] Tests und Dokumentation aktualisiert.
- [x] Aufgabenbezogene automatische Prüfungen abgeschlossen. Die echte
  interaktive GUI-Abnahme erfolgt mit Zustimmung des Benutzers extern.
- [x] Pixelart-Stand mit der vorgegebenen Commit-Nachricht als `a743558`
  committed.
- [x] Nach ausdrücklicher Umfangserweiterung die drei veralteten
  Dokumentationsprüfungen an die bestehende vereinfachte Struktur angepasst.
- [x] Vollständigen Kontrolllauf anschließend erfolgreich wiederholt.

## Erkenntnisse und Überraschungen

- Der bestehende Held besitzt eine sichtbare Referenzhöhe von 76 Weltpixeln,
  obwohl die aktiven Presets 64, 80 und 96 Weltpixel lauten. Das neue Sprite
  kann deshalb direkt mit 80 Pixeln Referenzhöhe angelegt werden; seine
  Fußposition bleibt dabei unverändert.
- Das Lab startet ohne gespeicherte Werte derzeit mit 64 Weltpixeln. Die
  Aufgabenbeschreibung nennt 80 Weltpixel als Standard, daher wird nur der
  Fallback auf das bereits vorhandene mittlere Preset berichtigt. Bereits
  gespeicherte Presets bleiben wirksam.
- Die Vergleichsobjekte liegen bereits gemeinsam bei Welt-Y 1760. Ihre lokalen
  X-Positionen und die gemeinsame Grundlinie können vollständig erhalten
  bleiben.
- Godot 4.7.2 importiert alle sieben PNGs ohne Mipmaps. Der lokale
  CanvasItem-Standard ist linear, daher setzen alle neuen `Sprite2D`-Knoten
  Nearest-Neighbor ausdrücklich am Knoten und verändern keine globale
  Darstellung anderer Szenen.
- Der Headless-Dummy-Renderer kann die Szene logisch testen, aber nicht
  aufnehmen: `--write-movie` endet bei `texture_2d_get` mit einem Absturz.
  Der normale Start findet weder X11 (`libXcursor.so.1`) noch eine nutzbare
  Wayland-Anbindung. Eine echte interaktive Sichtprüfung ist in diesem
  Container deshalb nicht möglich.
- Der erste vollständige Kontrolllauf scheiterte an Tests, die in Commit
  `3fe672f` bewusst entfernte redundante Dokumentationsdateien und den vor
  `00-zeitdarstellung/` gültigen Zeitrechnungs-Pfad erwarteten. Der Benutzer
  erweiterte den Umfang anschließend ausdrücklich. Die Prüfungen wurden auf
  aktuelle `index.md`-Einstiege und den Zeitdarstellungs-Pfad berichtigt, ohne
  die entfernten Doppeldateien wiederherzustellen.

## Entscheidungen

- Alle Sprites erhalten ihren Ursprung unten mittig; ihre sichtbare
  Alpha-Grenze reicht exakt von der oberen Pixelkante bis zum Bodenanker.
- Die Pixelgrafiken werden auf einem groben Raster ohne Anti-Aliasing erzeugt
  und mit Nearest-Neighbor dargestellt. Es entstehen keine Laufzeitabhängigkeit
  und keine externen Inhalte.
- Referenzlabels bleiben an ihren vorhandenen Objektknoten, erhalten jedoch
  einen absoluten hohen Z-Index. So bleiben Pfade stabil und die Texte werden
  weder von Objekten noch von deren Y-Sortierung verdeckt.
- `TestWorld` und `ScaleComparison` bilden eine verschachtelte Y-sortierte
  Hierarchie, sodass der bewegliche Held anhand seines Fußpunkts vor oder
  hinter den nicht kollidierbaren Referenzen gezeichnet werden kann.

## Prüfungen

- `python game/tools/generate_scale_reference_assets.py --check`: erfolgreich,
  sieben bytegleiche Originalassets bestätigt.
- `python tools/control.py style`: erfolgreich für 59 Dateien.
- `godot4 --headless --path game --script
  res://tests/bootstrap_integration_test.gd`: erfolgreich. Darin liefen unter
  anderem Textur-, Alpha-Höhen-, Bodenanker-, Preset-, Speicher-,
  Weltzustands-, Menü- und RouteHost-Prüfungen.
- `python -m pytest tools/tests/test_repository_metadata.py
  tools/tests/test_source_hygiene.py`: 20 Tests erfolgreich.
- `python tools/control.py check`: nach der freigegebenen Korrektur vollständig
  erfolgreich; Doctor 12/12, Stilprüfung, 175/175 Python-Tests und
  Godot-Integrationstest bestanden.
- `git diff --check`: erfolgreich.
- Lokale deterministische Größenreihen-Übersicht: visuell geprüft; gemeinsame
  Perspektive, Silhouetten, Materialtrennung, Beleuchtungsrichtung,
  Pixelkanten und Bodenanker wirken stimmig.
- `godot4 --path game`: ausgeführt, aber ohne X11-/Wayland-Displaytreiber mit
  Exitcode 1 beendet. Die interaktive Prüfung wurde ausdrücklich als externe
  Abnahme vereinbart und wird nicht als lokal erfolgreich ausgegeben.

## Wiederholbarkeit und Wiederherstellung

Der Assetgenerator überschreibt ausschließlich die namentlich festgelegten
PNG-Dateien in `game/assets/prototypes/scale_references/`. Wiederholtes
Ausführen muss identische Prüfsummen ergeben. Godots `.godot/`-Importcache
bleibt ignoriert und wird nicht committed. Jede Änderung erfolgt additiv oder
gezielt per Patch; fremde Änderungen werden nicht zurückgesetzt.

## Ergebnis und Rückblick

Der Umbau ist vollständig implementiert und als `a743558` committed. Held,
Gegner, Eingang, Gebäudesegment und Baum besitzen eine zusammenhängende dunkle
Fantasy-Palette, harte Pixelkanten, Top-down-Silhouetten und unveränderte
Bodenanker. Der Vergleichsboden und das kantige HUD lösen die technische
Diagrammwirkung ab; die echte GUI-Abnahme bleibt transparent als externer
Schritt ausgewiesen.

Nach der freigegebenen Erweiterung sichern die Dokumentationstests nun die
vereinfachte Struktur mit `index.md`-Einstiegen und dem getrennten
Zeitdarstellungsbereich ab. Der vollständige Release-Kontrolllauf ist
erfolgreich.
