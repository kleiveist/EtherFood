<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Nebel- und Lichtvergleich im visuellen Testlabor

## Zweck und Gesamtbild

Aufgabe 19 vervollständigt den vorhandenen Vergleich zwischen beschädigtem
und wiederhergestelltem Weltzustand. Beide Zustände erhalten mehrere
umschaltbare Nebel- und Lichtvarianten, eindeutige Diagnosewerte und getrennt
gespeicherte Auswahlen. Am Ende stehen je eine bevorzugte, weiterhin
vorläufige Kombination sowie eine technische und visuelle Testmatrix über
alle drei Zoomstufen. Nach Nutzerfeedback wird die erste kleine Vorschau zu
einer begehbaren Haus-, Wald- und Sägewerkfläche erweitert und der bandförmige
Nebel durch bildtechnisch optimierte Wolkenstrukturen ersetzt.

## Ausgangslage

`WorldStatePreview` besaß zu Beginn eine `720 × 420` große, deckungsgleiche
beschädigte und wiederhergestellte Hausvorschau, je ein Fog-Sprite und einfache
farbige Lichtpolygone. `VisualLab` wechselt den Zustand mit der vorhandenen Aktion
`dev_world_state_toggle`, speichert dessen ID im Version-1-Preset und zeigt ihn
im Menü sowie in der Diagnose. Die Atmosphäre selbst war fest in der Szene
verdrahtet und nicht als Variante vergleichbar.

## Umfang und Nicht-Ziele

Im Umfang liegen je drei Nebelstärken und je zwei Lichtprofile für beide
Weltzustände, zwei Bedienelemente im vorhandenen `F5`-Menü, konfliktfreie
Debug-Aktionen, Diagnose, rückwärtskompatible Preset-Persistenz,
Laufzeittests und echte Rendervergleiche. Die Prüfung umfasst Held, Boden,
Weltobjekte, Hindernis- und Kollisionsdarstellung, Kamerabewegung sowie die
Zoomstufen 0,75×, 1,00× und 1,50×. Die Nachprüfung erweitert die
Weltzustandsfläche auf `1440 × 810`, ergänzt paarige Sägewerk- und
Waldprototypen und bindet zwei optimierte wolkige RGBA-Nebelbilder ein.

Nicht geändert werden Spielmechanik, Bewegung, Physik, Pixel-Snap-Verfahren,
Texturfilterverfahren, Heldenraum, Ratgeber-Dialog, kanonische Weltorte,
endgültige Produktionsgrafik oder die für Aufgabe 20 vorgesehenen
verbindlichen Maßstabswerte.

## Konkrete Schritte

1. Die vorhandenen Fog- und Lichtlagen über klar benannte, zustandsabhängige
   Varianten steuerbar machen, ohne Kollisionen oder Spielmechanik zu ändern.
2. Im `F5`-Menü je einen fokussierbaren Nebel- und Lichtknopf ergänzen und
   beide Funktionen über eigene Debug-Aktionen erreichbar machen.
3. Beschädigte und wiederhergestellte Auswahl getrennt im bestehenden
   Version-1-Preset speichern; alte oder ungültige Werte fallen auf die
   bevorzugten Varianten zurück.
4. Diagnose um `Weltzustand`, `Nebel` und `Lichtprofil` ergänzen und bestehende
   Welt-, Kamera-, Bewegungs-, Filter-, Pixel-Snap- und Kollisionsverträge
   unverändert halten.
5. Automatische Tests für Varianten, Eingaben, Fokus, Diagnose, Speicherung,
   Zustandswechsel, Zoommatrix, Bewegung und Isolation ergänzen.
6. Alle Kombinationen rendern, die bevorzugten Varianten bei allen drei
   Zoomstufen und während Kamerabewegung vergleichen sowie Lesbarkeit und
   Leistung messen.
7. Ergebnis in der technischen Funktionsdokumentation festhalten,
   Gesamtfahrplan auf Aufgabe 20 weiterführen und den vollständigen
   Standardlauf ausführen.
8. Nach Nutzerfeedback die Testfläche mit paarigen Wald- und
   Sägewerk-Prototypen vergrößern, echte wolkige Nebeltexturen einbinden und
   Render-, Bewegungs-, Leistungs- und Regressionstests wiederholen.

## Fortschritt

- [x] 2026-09-03: Nachprüfung nach Nutzerfeedback: Weltzustandsfläche auf
  eine begehbare Haus-, Wald- und Sägewerk-Testzone vergrößern und die
  bisherigen Nebelbänder durch bildtechnisch optimierte, wolkige Texturen
  ersetzen.
- [x] 2026-09-03: Repository-Regeln, visuellen Kanon, vorhandene Szene,
  Preset-Vertrag und Tests geprüft.
- [x] 2026-09-03: Umfang, Variantenmodell und bevorzugte Startkombinationen
  festgelegt.
- [x] 2026-09-03: Nebel- und Lichtvarianten implementiert.
- [x] 2026-09-03: Bedienung, Diagnose und Persistenz integriert.
- [x] 2026-09-03: Automatische Regressionstests ergänzt.
- [x] 2026-09-03: Render- und Leistungsmatrix ausgeführt und ausgewertet.
- [x] 2026-09-03: Dokumentation und Gesamtfahrplan abgeschlossen sowie
  Aufgaben-Commit vorbereitet.

## Erkenntnisse und Überraschungen

- Die erste 720 × 420 große Vergleichsfläche zeigt jeweils nur Haus, Einzelbaum
  und drei Pflanzen. Für längere Bewegungs-, Kamera- und Nebelprüfungen ist sie
  trotz bestandener Matrix zu klein; Aufgabe 19 bleibt bis zur vergrößerten
  Nachprüfung wieder aktiv.
- Die bisherigen Nebelgrafiken bestehen aus zwei geraden Polygonbändern mit
  regelmäßig ausgestanzten Löchern. Das ist technisch transparent, wirkt aber
  nicht wolkig genug und wird deshalb durch echte Raster-Nebeltexturen ersetzt.
- Nebel und Licht bleiben getrennte Canvas-Ebenen. Die erste Bandtextur war
  technisch funktional, erfüllte aber die gewünschte wolkige Bildwirkung
  nicht. Zwei neue RGBA-Nebelbilder ersetzen deshalb nur diese Bildquelle;
  ein Shader bleibt unnötig.
- `G` ist bereits der Vergrößerung des Tile-Rasters zugeordnet und `N` dem
  Texturfilter. Die Atmosphärenaktionen benötigen deshalb andere Kürzel.
- Die Weltzustandsvorschau liegt im selben `TestWorld` wie der steuerbare Held.
  Auf `1440 × 810` bietet sie nun eine fast viermal so große Fläche mit offenem
  Weg, zwölf Bäumen und Sägewerk. Der Held kann länger unter denselben Nebel-
  und Lichtlagen bewegt werden.
- Die aus einem Bildgenerator-Ergebnis abgeleiteten Nebeltexturen besitzen 16
  Transparenzstufen, freie Sichtlücken und breite, unregelmäßige Wolkenbänke.
  Ihre maximalen Alpha-Werte von 68 beziehungsweise 38 Prozent verhindern
  eine undurchsichtige Farbfläche.
- Die 72 neu gerenderten Bewegungsbilder zeigen keine eigene Bewegungsphase
  der statischen Atmosphärenlagen. Haus, Wald, Sägewerk, Licht und Nebel
  bleiben beim Kameranachlauf gemeinsam verankert.
- Die beiden bevorzugten Profile erreichten auf der deutlich größeren Fläche
  im Software-OpenGL-Lauf 64,20 beziehungsweise 61,66 Frames/s. Damit blieben
  beide 360-Frame-Messreihen selbst unter llvmpipe oberhalb von 60 Frames/s.

## Entscheidungen

- Beschädigt bietet `Gering`, `Mittel` und `Hoch`; bevorzugt ist `Mittel`.
  Wiederhergestellt bietet `Aus`, `Gering` und `Mittel`; bevorzugt ist
  `Gering`.
- Beschädigt bietet `Kühl und gedämpft` sowie `Kühl und dunkel`; bevorzugt ist
  `Kühl und dunkel`. Wiederhergestellt bietet `Neutral und klar` sowie
  `Warm und klar`; bevorzugt ist `Warm und klar`.
- Nebelstärke und Lichtprofil werden pro Weltzustand getrennt gespeichert.
  Ein Zustandswechsel stellt dessen letzte Auswahl wieder her.
- Die Varianten verwenden harte Sprite-Abtastung und flächige Farbmischung.
  Sie verschieben keine CanvasItems und führen keine räumliche
  Weichzeichnung ein.
- Haus, Wald und Sägewerk bilden eine ausschließlich technische
  Vergleichskulisse. Sie ändern weder Kanon noch Weltkarte und erhalten keine
  neuen Kollisionen oder Interaktionen.
- Grund, Weg, Gebäude, Bäume und Sägewerk bleiben deterministisch erzeugt. Die
  zwei bildgenerierten Nebeldateien werden separat dokumentiert und durch den
  Generator-Check auf `1440 × 810` sowie höchstens 250 kB geprüft.
- Die vorhandene Taste `V` bleibt ausschließlich für den Weltzustandswechsel
  zuständig. `B` wechselt Nebel, `L` das Lichtprofil; dieselben Funktionen sind
  als Knöpfe im `F5`-Menü erreichbar.

## Prüfungen

- `python3 tools/control.py style`: erfolgreich, 73 Dateien.
- Godot-Editorimport mit Godot 4.7.2: ohne Parser- oder Ressourcenfehler.
- `godot4 --headless --path game --script
  res://tests/bootstrap_integration_test.gd`: erfolgreich; einschließlich
  Varianten, Diagnose, Preset, Zustandswechsel, Zoommatrix, Bewegung,
  Kollision und Szenenisolation.
- 36 erneuerte OpenGL-Aufnahmen bei 1280 × 720: zwei Zustände, drei
  Nebelstärken, zwei Lichtprofile und drei Zoomstufen auf der vergrößerten
  Fläche vollständig verglichen.
- 72 erneuerte OpenGL-Bewegungsaufnahmen: je zwölf Bilder pro Zustand und
  Zoom; die gemeinsamen Welt- und Atmosphärenlagen blieben ohne separates
  Springen oder Flackern verankert.
- Je 360 Software-OpenGL-Frames: 64,20 Frames/s für beschädigt und 61,66
  Frames/s für wiederhergestellt; beide Messreihen stabil.
- `.venv/bin/python -m pytest tools/tests/test_godot_project.py
  tools/tests/test_source_hygiene.py tools/tests/test_repository_metadata.py
  -q`: 40 Tests erfolgreich.
- `python3 game/tools/generate_scale_reference_assets.py --check`: 21
  deterministische Testlabor-Assets und zwei optimierte Nebeltexturen
  verifiziert.
- Godot-Projektstart im Headless-Modus über fünf Frames: erfolgreich.
- `python3 tools/control.py check`: erfolgreich; Doctor 12/12, Stil 73
  Dateien, 177 Python-Tests und Godot-Integration.
- Offizielles Godot-4.7.2-Exportvorlagenarchiv gegen die veröffentlichte
  SHA-512-Prüfsumme verifiziert. `python3 tools/control.py export linux`
  erzeugte anschließend erfolgreich einen Release-Build mit 75.655.096 Byte.
  Die exportierte Binärdatei startete im Headless-Modus über fünf Frames
  fehlerfrei.

## Wiederholbarkeit und Wiederherstellung

Automatische Tests verwenden weiterhin einen isolierten `user://`-Pfad und
entfernen ihre Preset-Datei. Renderaufnahmen, Messdaten, das unbearbeitete
Bildgenerator-Ergebnis und Engine-Caches bleiben außerhalb des Repositorys.
Nur die zwei optimierten RGBA-Nebeltexturen und ihre üblichen Godot-Importdaten
werden eingecheckt. Kollisionsformen und dauerhafte lokale Anmeldedaten bleiben
unberührt.

## Ergebnis und Rückblick

Bevorzugt werden `Mittel` und `Kühl und dunkel` für den beschädigten sowie
`Gering` und `Warm und klar` für den wiederhergestellten Zustand. Die beiden
Kombinationen sind auf den ersten Blick verschieden, halten Held und
Weltobjekte aber in allen drei Zoomstufen lesbar. Die `1440 × 810` große,
nicht-kanonische Haus-, Wald- und Sägewerkkulisse ermöglicht längere
Bewegungs- und Kameraprüfungen. Auswahl, Diagnose und Preset-Persistenz arbeiten
zustandsgetrennt; Bewegung, Kamera und Kollision bleiben unverändert. Neben den
deterministischen Kulissenprototypen entstanden zwei optimierte Wolkenbilder;
Shader oder Spielmechaniken wurden nicht ergänzt. Nach erfolgreicher Abnahme
folgt Aufgabe 20 als eigener Arbeitsschritt.
