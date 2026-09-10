<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Begehbarer Heldenraum

## Zweck und Gesamtbild

Der Platzhalter hinter „Neues Spiel“ wird durch den ersten begehbaren
Gameplay-Raum ersetzt. Der vorhandene Held bewegt sich innerhalb eines
vorläufigen 2560 × 1440 Weltpixel großen Steinraums, kollidiert mit dessen
Grenzen und zwei Testhindernissen und wird von seiner Kamera verfolgt.

## Ausgangslage

Die Route `hero_room` zeigt nur „Spielbarer Raum folgt“. Die wiederverwendbare
Heldenszene bringt Bewegung, eine 28 × 16 Weltpixel große Fußkollision und eine
standardmäßig deaktivierte Kamera bereits mit. Das visuelle Testlabor besitzt
eigene gespeicherte Werte, die den Heldenraum nicht beeinflussen dürfen.

## Umfang und Nicht-Ziele

Umgesetzt werden Raumdarstellung, Außenwände, zwei Steinblöcke, Heldenspawn,
feste Prototypwerte für Held und Kamera, ein Debug-Hinweis und die vorhandene
Rückkehr zum Hauptmenü. Nicht enthalten sind Dialoge, Ratgeber, Interaktionen,
Ausgänge, Speichern, Kampf, ein Pause-Menü oder finale Raum- und Tilegrafik.

## Konkrete Schritte

1. Platzhalterszene in eine Welt-, Hintergrund- und Oberfläche-Struktur
   überführen.
2. Initialisierung von Spawn, Heldengröße und Kamera im Raumskript ergänzen.
3. Einen isolierten Laufzeittest für Aufbau, feste Werte, Physik und Navigation
   erstellen und in den Bootstrap-Lauf aufnehmen.
4. Bestehende Bootstrap-Erwartungen vom Platzhalter auf den begehbaren Raum
   umstellen.
5. schnelle Tests, vollständigen Standardlauf und den verfügbaren Godot-Lauf
   ausführen; GUI-Prüfung im Container versuchen und das Ergebnis festhalten.

## Fortschritt

- 2026-09-02: Ausgangslage, vorhandene Heldenszene und Anforderungen geprüft.
- 2026-09-02: Steinraum, Physikgrenzen, Hindernisse, Spawn, feste Kamera und
  Debug-Hinweis umgesetzt.
- 2026-09-02: Laufzeittest ergänzt und veraltete Bootstrap-Erwartungen
  ersetzt.
- 2026-09-02: Automatische Prüfungen abgeschlossen; die grafische Abnahme
  bleibt wegen der fehlenden Display-Bibliotheken der Docker-Sitzung extern.

## Erkenntnisse und Überraschungen

- Die Heldenszene erfüllt bereits die geforderte Fußkollision und besitzt die
  nötige Kamerakomponente; ihre Bewegungslogik muss nicht dupliziert werden.
- Ein absichtlich widersprüchlicher Testlabor-Speicherstand eignet sich als
  Regressionstest dafür, dass die Raumwerte wirklich unabhängig bleiben.

## Entscheidungen

- Der Raum verwendet ausschließlich feste Konstanten und liest bewusst keine
  Konfiguration des visuellen Testlabors.
- Die vorläufige Darstellung besteht aus Godot-eigenen Polygonen mit harten
  Kanten und erzeugt keine neue Laufzeitabhängigkeit.

## Prüfungen

- Erfolgreich: `python tools/control.py check` mit 175 Python-Tests, Stilprüfung
  und Godot-Integrationstest.
- Erfolgreich: Godot-Projektimport und Skriptprüfung im Headless-Editor.
- Erfolgreich: `godot4 --headless --path game --script
  res://tests/bootstrap_integration_test.gd`.
- Ausgeführt, im Container technisch nicht möglich: `godot4 --path game` kann
  weder X11 noch Wayland initialisieren, weil `libXcursor.so.1`,
  `libwayland-client.so.0` und ein Display fehlen. Die visuelle und manuelle
  Eingabeprüfung erfolgt daher außerhalb dieses Containers.

## Wiederholbarkeit und Wiederherstellung

Die Szene und Tests sind vollständig im Repository beschrieben. Wiederholte
Testläufe dürfen nur Godots ignorierte Import- und Laufzeitcaches verändern.
Der Heldenraum besitzt keine persistenten Einstellungen.

## Ergebnis und Rückblick

„Neues Spiel“ öffnet jetzt einen begehbaren Prototypraum mit fester
Heldengröße, Folgekamera, vier kollidierbaren Außenwänden und zwei
kollidierbaren Steinblöcken. Der Platzhalter wurde entfernt, die Rückkehr zum
Hauptmenü blieb erhalten und Testlabor-Presets beeinflussen die Szene nicht.
