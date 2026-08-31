<!-- AUTO-GENERATED:backlink START -->
[← Zurück](architecture.md)
<!-- AUTO-GENERATED:backlink END -->
# Szenen- und Zustandsfluss

Dieses Dokument beschreibt ausschließlich den Szenenfluss des ersten
spielbaren Prototyps. Es beschreibt noch nicht alle Szenen des vollständigen
Spiels.

## 1. Grundprinzip

Eine Szene ist ein eigenständiger technischer Spielbereich oder Bildschirm.

Beispiele:

- Titelbildschirm
- Hauptmenü
- Heldenraum
- Turmabschnitt
- Mitwirkende

Der vorhandene `SceneRouter` übernimmt den Wechsel zwischen den Hauptszenen.

## 2. Hauptfluss

Der erste spielbare Prototyp verwendet folgenden Ablauf:

```text
Spielstart
→ title
→ main_menu
→ hero_room
→ tower_slice
→ Ende des Prototyps
```

## 3. Szenen

### `title`

Der Titelbildschirm erscheint direkt nach dem Spielstart.

Er enthält vorläufig:

- Spieltitel
- Hintergrundbild oder Platzhalter
- Hinweis zum Fortfahren

Nach einer Bestätigung wird `main_menu` geöffnet.

### `main_menu`

Das Hauptmenü enthält:

- Fortsetzen
- Neues Spiel
- Einstellungen
- Mitwirkende
- Spiel beenden

`Neues Spiel` öffnet die Szene `hero_room`.

### `hero_room`

Der Heldenraum ist die erste spielbare Szene.

Hier kann der Spieler:

- die Spielfigur bewegen,
- die Kamera testen,
- mit einem Objekt oder dem Ratgeber interagieren,
- den Ausgang in Richtung Turm benutzen.

Beim Verlassen des Heldenraums wird der Weg zum Turm beziehungsweise direkt
der vorläufige Turmabschnitt geladen.

### `tower_slice`

`tower_slice` ist ein kleiner Testabschnitt des Turms.

Die Szene dient später zum Testen von:

- Bewegung,
- Kollision,
- Kampf,
- Gegnern,
- Interaktionen,
- Weltrekonstruktion.

Der Abschluss dieser Szene markiert das vorläufige Ende des ersten spielbaren
Prototyps.

Die vollständige Größe und Raumaufteilung des Turms wird in diesem Dokument
noch nicht festgelegt.

### `credits`

Diese Szene zeigt die Mitwirkenden.

Mit der Zurück-Aktion gelangt der Spieler wieder zum Hauptmenü.

### `visual_lab`

Diese Szene ist ein internes visuelles Testlabor.

Sie wird nur in Entwicklungsbuilds angezeigt und dient zum Testen von:

- Figurengröße,
- Pixelmaßstab,
- Kamera,
- Tiles,
- Beleuchtung,
- Animationen,
- zerstörten und wiederhergestellten Objekten.

Sie ist kein Bestandteil der normalen Spielhandlung.

## 4. Dauerhafte UI-Ebene

Folgende Elemente sind keine vollständigen Hauptszenen:

- Pause-Menü
- Einstellungen
- HUD
- Szenenübergänge
- Bestätigungsdialoge

Diese Elemente werden über der aktuellen Spielszene angezeigt.

## 5. Pause-Menü

Das Pause-Menü kann während einer Spielszene geöffnet werden.

Es enthält:

- Fortsetzen
- Einstellungen
- Zum Hauptmenü
- Spiel beenden

Das Pause-Menü ersetzt nicht die aktuelle Hauptszene.

## 6. Szenenwechsel

Beim Wechsel einer Hauptszene wird die bisherige Hauptszene entfernt und die
neue Hauptszene geladen.

Beispiele:

```text
title → main_menu
main_menu → hero_room
hero_room → tower_slice
credits → main_menu
```

Ungültige Routen müssen verständlich protokolliert werden.

## 7. Nicht Bestandteil dieses Dokuments

Noch nicht beschrieben werden:

- vollständiges Grasland,
- Sägewerk,
- Wasserwerk,
- Lichterhaus,
- Dorf,
- spätere Dungeons,
- Abschnitte 2 bis 8,
- einzelne Turmräume,
- endgültige Dateinamen aller Spielszenen,
- Checkpoints,
- vollständiges Speichersystem.
