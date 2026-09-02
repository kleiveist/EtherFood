<!-- AUTO-GENERATED:backlink START -->
[← Zurück](index.md)
<!-- AUTO-GENERATED:backlink END -->
# Arbeitsplan: Erste Ratgeber-Interaktion

## Zweck und Gesamtbild

Der begehbare Heldenraum erhält seine erste einfache Interaktion. Der Held
kann sich einem sichtbaren Ratgeber nähern, einen kontextabhängigen Hinweis
sehen und eine kurze Prototypnachricht öffnen und schließen. Während der
Nachricht ruht die Bewegung.

## Ausgangslage

Der Heldenraum besitzt Bewegung, Kamera und Kollisionen, aber noch keine
interaktiven Figuren. Die Heldenszene wird bereits im Heldenraum und im
visuellen Testlabor wiederverwendet. Der kanonische Ratgeberentwurf zeigt einen
großen Hut mit zwei Augen, einen winzigen Körper und einen Besen; sein Name und
sein endgültiges Design bleiben offen.

## Umfang und Nicht-Ziele

Umgesetzt werden eine Eingabeaktion, ein kleiner wiederverwendbarer
Interaktionsbereich, ein original aus Godot-Formen aufgebauter
Ratgeberplatzhalter, ein Reichweitenhinweis sowie genau eine Nachricht. Nicht
enthalten sind ein allgemeines Dialogsystem, mehrere Seiten, Antworten,
Quests, Folgebewegung, Animationen, der Talisman oder ein Raumausgang.

## Konkrete Schritte

1. `gameplay_interact` für E und Controller-A konfigurieren.
2. Wiederverwendbaren `InteractableArea`-Vertrag und den 96-Weltpixel-Detektor
   des Helden ergänzen.
3. Ratgeberszene mit Hut, Augen, Kleinkörper, Besen und Schatten erstellen.
4. Ratgeber, Reichweitenhinweis und einfaches Nachrichtenpanel im Heldenraum
   verbinden.
5. Laufzeittests für Reichweite, nächstes Ziel, Eingaben, Bewegungssperre,
   Schließreihenfolge und bestehende Routen ergänzen.
6. Standardprüfung, expliziten Headless-Test und verfügbaren GUI-Startversuch
   ausführen.

## Fortschritt

- 2026-09-02: Arbeitsbaum, Kanon, vorhandene Heldenszene und Referenzentwurf
  geprüft.
- 2026-09-02: Eingabeaktion, Interaktionsvertrag und Heldendetektor ergänzt.
- 2026-09-02: Originalen Ratgeberplatzhalter aus Godot-Formen sowie Hinweis
  und Nachrichtenpanel in den Heldenraum eingebaut.
- 2026-09-02: Laufzeittests für Reichweite, Zielauswahl, beide Eingabearten,
  Bewegungssperre und Esc-Reihenfolge ergänzt.
- 2026-09-02: Automatische Prüfungen abgeschlossen; die grafische Abnahme
  bleibt wegen der fehlenden Display-Bibliotheken der Docker-Sitzung extern.

## Erkenntnisse und Überraschungen

- Der beibehaltene Entwurf ist ausdrücklich nur eine Arbeitsrichtung mit noch
  offener Produktionsfreigabe. Die Laufzeitdarstellung übernimmt deshalb
  keine Bildpixel, sondern nur die kanonischen Erkennungsmerkmale.
- Die Quellhygiene verbietet physische Eingabeklassen im Laufzeitcode. Das
  Wiederholungsfiltern bleibt deshalb bei Godots aktionsbasierter Abfrage, die
  Echo-Ereignisse standardmäßig nicht als neuen Tastendruck wertet.

## Entscheidungen

- Der Held wählt das nächste gültige `InteractableArea` innerhalb seiner
  Detektorüberschneidungen; die Eingabe bleibt kontextuell im Heldenraum.
- Der Ratgeber blockiert die Physik nicht, weil er schwebt und seine Fläche nur
  der Interaktion dient.
- Das Nachrichtenpanel ist lokale Prototyp-UI und keine Vorentscheidung für
  die spätere Dialogarchitektur.

## Prüfungen

- Erfolgreich: Godot-Projektimport und Skriptprüfung im Headless-Editor.
- Erfolgreich: Bootstrap-Integration einschließlich des neuen Laufzeittests.
- Erfolgreich: `python tools/control.py check` mit 175 Python-Tests,
  GDScript-Stilprüfung für 66 Dateien und Godot-Integrationstest.
- Ausgeführt, im Container technisch nicht möglich: `godot4 --path game` kann
  weder X11 noch Wayland initialisieren, weil `libXcursor.so.1`,
  `libwayland-client.so.0` und ein Display fehlen. Die visuelle und manuelle
  Eingabeprüfung erfolgt daher außerhalb dieses Containers.

## Wiederholbarkeit und Wiederherstellung

Alle Formen, Szenen und Tests liegen als Textressourcen im Repository. Es gibt
keine Downloads, neuen Abhängigkeiten oder persistenten Interaktionszustände.
Wiederholte Testläufe dürfen nur ignorierte Godot-Caches erzeugen.

## Ergebnis und Rückblick

Der Heldenraum enthält jetzt den sichtbaren Ratgeber, einen kontextabhängigen
Interaktionshinweis und eine einzelne Prototypnachricht. E und Controller-A
öffnen und schließen sie, Esc schließt sie vor einer Navigation, und die
Heldenbewegung wird nur während der offenen Nachricht angehalten. Der
wiederverwendbare Detektor verändert das visuelle Testlabor nicht.
