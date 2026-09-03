<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Funktion: Titelbild und Menüführung

## Ziel

Diese Seite legt verbindlich fest, wie der Spieler vom Spielstart durch die
Menüs bis in den Heldenraum gelangt. Sie beschreibt außerdem die gemeinsame
Navigation mit Tastatur und Controller sowie das Verhalten des Pause-Menüs.

## Spielstart

```text
Spiel wird gestartet
→ Titelbildschirm erscheint
→ beliebige Bestätigungstaste
→ Hauptmenü öffnet sich
```

Die Bestätigung kann über Tastatur oder Controller erfolgen. Der Weg bis zum
Beginn des Spiels lautet vollständig:

```text
Spielstart
→ Titelbildschirm
→ Hauptmenü
→ Neues Spiel
→ gegebenenfalls Überschreiben des vorhandenen Spielstands bestätigen
→ Heldenraum
```

Wird die Warnung abgebrochen, bleibt der vorhandene Spielstand erhalten und
der Spieler kehrt in das Hauptmenü zurück.

## Hauptmenü

Das Hauptmenü enthält in dieser Reihenfolge:

```text
Fortsetzen
Neues Spiel
Einstellungen
Mitwirkende
Spiel beenden
```

- **Fortsetzen** setzt einen vorhandenen Spielstand fort. Der Menüpunkt ist
  deaktiviert, solange kein Spielstand existiert.
- **Neues Spiel** startet den Heldenraum. Existiert bereits ein Spielstand,
  muss der Spieler dessen Überschreiben zuvor ausdrücklich bestätigen.
- **Einstellungen** öffnet das Einstellungsmenü.
- **Mitwirkende** öffnet die Credits.
- **Spiel beenden** öffnet eine Bestätigungsabfrage. Erst die ausdrückliche
  Bestätigung beendet das Spiel.

Beim Öffnen des Hauptmenüs erhält der erste verfügbare Menüpunkt automatisch
den Fokus. Deaktivierte Menüpunkte werden bei der Navigation übersprungen.
Damit liegt der Fokus ohne Spielstand auf **Neues Spiel** und mit vorhandenem
Spielstand auf **Fortsetzen**.

## Navigation und Zurück

Alle verfügbaren Menüpunkte müssen vollständig mit Tastatur und Controller
erreichbar und bedienbar sein. Beide Eingabearten unterstützen mindestens:

- den Fokus zwischen verfügbaren Menüpunkten zu bewegen,
- den fokussierten Menüpunkt zu bestätigen und
- zur vorherigen Menüebene zurückzukehren.

Eine Maus darf für die Menübedienung nicht erforderlich sein. Die konkreten
Tasten und Controller-Belegungen werden hier noch nicht festgelegt.

**Zurück** führt immer auf die unmittelbar vorherige Menüebene:

- vom Einstellungsmenü oder den Credits zurück in das Hauptmenü,
- von den Pause-Einstellungen zurück in das Pause-Menü,
- aus einer Bestätigungsabfrage zurück in das Menü, das sie geöffnet hat, und
- vom Hauptmenü zurück auf den Titelbildschirm.

Der Titelbildschirm ist die oberste Ebene und besitzt keine vorherige
Menüebene.

## Pause-Menü

Das Pause-Menü enthält:

```text
Fortsetzen
Einstellungen
Zum Hauptmenü
Spiel beenden
```

Das laufende Spiel ist angehalten, solange das Pause-Menü oder eine von ihm
geöffnete Unterebene sichtbar ist.

- **Fortsetzen** schließt das Pause-Menü und setzt das Spiel fort.
- **Einstellungen** öffnet das Einstellungsmenü innerhalb der Pause.
- **Zum Hauptmenü** öffnet eine Bestätigungsabfrage. Der Wechsel erfolgt erst
  nach ausdrücklicher Bestätigung.
- **Spiel beenden** öffnet ebenfalls eine Bestätigungsabfrage.

Kann beim Wechsel zum Hauptmenü oder beim Beenden nicht gespeicherter
Fortschritt verloren gehen, muss die jeweilige Abfrage deutlich davor warnen.
Ein Abbruch schließt nur die Abfrage und führt zurück in das Pause-Menü. So
geht Fortschritt nicht durch eine einzelne versehentliche Eingabe verloren.

Auch im Pause-Menü erhält der erste verfügbare Menüpunkt automatisch den Fokus
und die vollständige Tastatur- und Controller-Navigation gilt unverändert.

## Entwicklungsmenü

Das Hauptmenü von Entwicklungsbuilds zeigt später zusätzlich folgenden
internen Menüpunkt:

```text
Visuelles Testlabor
```

**Visuelles Testlabor** ist kein Bestandteil der normalen Spielversion. Der
Menüpunkt wird dort weder angezeigt noch bei der Fokus-Navigation
berücksichtigt.

## Noch nicht festlegen

```text
- endgültiges Menüdesign
- Hintergrundgrafik
- Logo
- Animationen
- mehrere Speicherplätze
- genaue Audioeinstellungen
- Programmcode
```

## Prüfung

Die Beschreibung ist erfüllt, wenn:

- alle Menüpunkte des Haupt- und Pause-Menüs vorhanden sind,
- der Weg vom Spielstart über **Neues Spiel** bis zum Heldenraum eindeutig ist,
- **Zurück** auf jeder Menüebene zur vorherigen Ebene führt,
- alle verfügbaren Menüpunkte mit Tastatur und Controller bedienbar sind,
- ein Verlassen des laufenden Spiels nicht versehentlich ungespeicherten
  Fortschritt verwirft und
- **Visuelles Testlabor** ausschließlich in Entwicklungsbuilds erscheint.
