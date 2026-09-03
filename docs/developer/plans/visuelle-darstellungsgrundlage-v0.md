<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Visuelle Darstellungsgrundlage V0 dokumentieren

## Zweck und Gesamtbild

Aufgabe 21 führt die abgeschlossenen Ergebnisse des visuellen Testlabors an
einer zentralen technischen Stelle zusammen. Die Seite unterscheidet
verbindliche V0-Werte, weiterhin verfügbare Testvarianten und noch offene
Produktionsfragen. Zwei Laufzeitaufnahmen belegen die gewählten
Weltzustandsprofile. Spielcode, Grafiken und Mechaniken bleiben unverändert.

## Ausgangslage

Maßstab, Kamera, Pixel-Snap, Texturfilter sowie Nebel und Licht sind bereits in
Konzeptentscheidung, Funktionsdokumentation und abgeschlossenen Arbeitsplänen
festgehalten. Dadurch sind die richtigen Werte nachvollziehbar, aber über
mehrere Seiten verteilt. `docs/developer/` ist im Repository der vorgesehene
Ort für technische Dokumentation; ein konkurrierender neuer Ordner
`docs/technical/` wird deshalb nicht angelegt.

Parallel zu Aufgabe 21 hat der Benutzer `PyGitIndex 2.1.0` ausgeführt. Dessen
bereits vorhandene Navigations-, Index- und Legacy-Bereinigungen werden nicht
mit den fachlichen Änderungen vermischt, sondern anschließend in einem
eigenen Commit übernommen.

## Umfang und Nicht-Ziele

Im Umfang liegen die zentrale Darstellungsgrundlage, zwei dokumentierte
Referenzaufnahmen, Querverweise aus visueller Richtung und Testlabor,
ehrliche Grenzen bei Objektgrößen und Breitbildformaten, die Korrektur
veralteter Statusaussagen sowie der Fahrplanabschluss von Aufgabe 21.

Nicht im Umfang liegen neue Grafikinhalte, neue Räume, Spielmechaniken,
Balancewerte, Produktionssprites oder Arbeiten aus Aufgabe 22.

## Konkrete Schritte

1. Verbindliche Werte aus Ressourcen, Projekteinstellungen, Tests,
   Arbeitsplänen und ADR-0011 abgleichen.
2. Tatsächliche V0-Weltzustände als zwei reproduzierbare
   Dokumentationsaufnahmen erfassen und ihre Herkunft dokumentieren.
3. Eine zentrale technische Darstellungsseite unter
   `docs/developer/architecture/` erstellen.
4. Widersprüchliche oder inzwischen überholte Statusaussagen korrigieren und
   zentrale Querverweise ergänzen.
5. Aufgabe 21 im Gesamtfahrplan abschließen, Dokumentation und Projekt prüfen
   und den vorgesehenen Aufgaben-Commit erstellen.
6. Danach `PyGitIndex` erneut ausführen und ausschließlich seine generierten
   Index- und Bereinigungsänderungen separat committen.

## Fortschritt

- [x] 2026-09-03: Repository-Struktur, Regeln und aktuelle Quellen geprüft.
- [x] 2026-09-03: Tatsächliche Maßstabs-, Kamera-, Rendering- und
  Atmosphärenwerte abgeglichen.
- [x] 2026-09-03: Zentrale Darstellungsgrundlage und Referenzaufnahmen
  erstellt.
- [x] 2026-09-03: Querverweise, Einschränkungen und Fahrplanstatus
  aktualisiert.
- [x] 2026-09-03: Dokumentationsprüfungen, Standardlauf und Linux-Build
  erfolgreich ausgeführt.
- [x] 2026-09-03: Fachlichen Aufgabe-21-Commit `d8bb798` erstellt.
- [x] 2026-09-03: `PyGitIndex`-Ergebnis separat geprüft und für den
  eigenen Folge-Commit vorbereitet.

## Erkenntnisse und Überraschungen

- Die vorbereitete Textfassung nennt für den beschädigten Zustand `Gering`
  und `Kühl und gedämpft`. Im tatsächlichen Projekt und im abgeschlossenen
  Aufgabe-19-Protokoll sind jedoch `Mittel` und `Kühl und dunkel` ausgewählt.
  Die zentrale Dokumentation folgt dem geprüften Projektstand.
- Der 80-px-Held und das 32er Raster sind verbindlich. Tür-, Wand-, Möbel- und
  Wegmaße wurden dagegen noch nicht als allgemeine Produktionsregeln
  beschlossen; vorhandene Referenzgrafiken dürfen nicht stillschweigend dazu
  erklärt werden.
- Nicht ganzzahlige Fensterskalierung ist bereits Bestandteil des geprüften
  Verhaltens. Pixel-Snap richtet die sichtbare Kamera und das Heldenbild auf
  Ausgabepixel aus, ohne logische Physikpositionen zu runden.
- Aufgabe 17.2 ist nach dem erneuten direkten Sichttest abgeschlossen. Nur die
  getrennte Bewegungssteuerung V0 in Aufgabe 17.1 bleibt teilweise umgesetzt.
- Der erste Standardlauf nach der Indexumstellung fand drei veraltete
  Repository-Verträge: Tests erwarteten noch die alten
  `AUTO-GENERATED`-Marker und ein versteckter Medienindex verwies auf die
  entfernte `assets.md`. Die Verträge folgen nun `PyGitIndex 2.1.0`; der
  erneute Standardlauf ist erfolgreich.

## Entscheidungen

- Die zentrale technische Seite heißt
  `docs/developer/architecture/visuelle-darstellungsgrundlage-v0.md`.
- Die visuelle Konzeptseite und ADR-0011 bleiben Quellen für gestalterische
  Festlegungen; die neue Seite konsolidiert deren technische Anwendung und
  erzeugt keinen zweiten Kanon.
- Beschädigt verwendet als V0-Testlaborstandard `Mittel` und `Kühl und
  dunkel`, Wiederhergestellt `Gering` und `Warm und klar`.
- Unbeschlossene Objektmaße werden ausdrücklich als offen markiert.
- `PyGitIndex` besitzt für generierte Navigation und Legacy-Dubletten Vorrang
  und erhält einen vom Aufgabeninhalt getrennten Commit.

## Prüfungen

- `python3 /opt/pytools/PyGit/PyGitIndex.py`: erfolgreich; die neue
  Architekturseite, der Arbeitsplan und die Bildnachweise wurden indexiert.
- `.venv/bin/python -m pytest tools/tests/test_source_hygiene.py
  tools/tests/test_repository_metadata.py`: 20 Tests erfolgreich.
- `PATH=/tmp/etherfood-godot-4.7.2.cIHgoO:$PATH python3
  tools/control.py check`: erfolgreich; Doctor 12/12, Stil 75 Dateien,
  177 Python-Tests und Godot-Bootstrap-Integration bestanden.
- `XDG_DATA_HOME=/tmp/etherfood-export-data
  PATH=/tmp/etherfood-godot-4.7.2.cIHgoO:$PATH python3 tools/control.py export
  linux`: erfolgreich; validierter Linux-Release-Export mit 75.682.536 Byte.
- `git diff --check`: erfolgreich.

## Wiederholbarkeit und Wiederherstellung

Die Referenzaufnahmen werden direkt aus den vorhandenen Godot-Szenen und
Ressourcen erzeugt. Der Aufnahmelauf verwendet eine isolierte
`user://`-Einstellungsdatei und verändert weder Projektressourcen noch lokale
Spielstände. Der fachliche Commit und der Index-Commit bleiben getrennt
rücksetzbar.

## Ergebnis und Rückblick

Maßstab, Kamera, Skalierung, Pixel-Snap, Texturfilter sowie die beiden
Weltzustandsprofile sind nun an einer zentralen Stelle dokumentiert. Zwei
aktuelle Laufzeitaufnahmen belegen den sichtbaren Unterschied. Unbeschlossene
Produktionsmaße und Breitbildregeln bleiben ausdrücklich offen. Aufgabe 21 ist
im Fahrplan abgeschlossen; Aufgabe 22 ist der nächste direkte Schritt.
