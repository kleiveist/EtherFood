<!-- PYGINDEX:NAVIGATION START -->
[Zur Übersicht](index.md)
<!-- PYGINDEX:NAVIGATION END -->

# Arbeitsplan: Reproduzierbare Godot-Ressourcenimporte

## Zweck und Gesamtbild

Ein gemeinsamer Importablauf im Repository-Tooling soll einen frischen Checkout
vor kopflosen Spiel- und Testläufen zuverlässig vorbereiten. `godot4 import`,
`godot4 run`, `godot4 test` und das Release-Gate verwenden dafür denselben
Godot-Editorimport. Erst nach einem erfolgreichen Import darf der abhängige
Zielprozess starten.

## Ausgangslage

Die getrackten PNG-Quellen und ihre `.import`-Metadaten verweisen auf generierte
Texturen unter `game/.godot/imported/`. Dieser Cache ist zu Recht ignoriert. Das
bisherige Tooling startet Run oder Bootstrap-Integrationstest jedoch ohne eine
vorherige Importphase, sodass ein leerer Checkout mit fehlenden `.ctex`-Dateien
und vielen Folgefehlern scheitert.

## Umfang und Nicht-Ziele

Zum Umfang gehören die gemeinsame Befehlserzeugung und Prozessausführung, die
CLI-Orchestrierung, zwei voneinander unterscheidbare Godot-Gates, automatisierte
Regressionstests sowie deutsche Tooling-Dokumentation. CI bleibt beim
gemeinsamen Aufruf `python tools/control.py check`.

Nicht zum Umfang gehören getrackte Godot-Caches, Git LFS, neue Abhängigkeiten,
Änderungen an Quellgrafiken oder Szenen ohne nachgewiesenen Defekt, Änderungen
am Bootstrap-Erfolgsmarker sowie GPU- oder `DRI_PRIME`-Konfiguration.

## Konkrete Schritte

1. Bestehende Verträge, Tests, CI und Dokumentationsstruktur erfassen.
2. Importbefehl und eine wiederverwendbare, begrenzt laufende Ausführung in
   `g2dtool.godot` ergänzen.
3. CLI-Modus `import` einführen und Import plus Zielprozess für Run, Test und
   beide Template-Aliase gemeinsam orchestrieren.
4. Das Release-Gate um `Godot resource import` erweitern und den
   Integrationstest hart davon abhängig machen.
5. Unit- und Hygienetests für Befehle, Reihenfolge, Abbruchverhalten, Marker,
   Cache-Ausschluss und Dokumentationsstruktur ergänzen.
6. Tooling-Dokumentation, Einstiegsseiten, Changelog und gegebenenfalls CI
   aktualisieren.
7. Erst die fokussierten, danach die vollständigen vorgeschriebenen Prüfungen
   ausführen und diesen Plan nur mit tatsächlichen Ergebnissen abschließen.

## Fortschritt

- [x] 2026-09-03: Vorgeschriebene Repository-Regeln, Dokumentationsseiten,
  Tooling-Module, zugehörige Tests, CI und `.gitignore` gelesen.
- [x] 2026-09-03: Arbeitsplan angelegt und manuell in die Planübersicht
  aufgenommen.
- [x] 2026-09-03: Gemeinsames Godot-Import-Tooling und CLI-Verhalten
  implementiert.
- [x] 2026-09-03: Release-Gate mit harter Importabhängigkeit erweitert.
- [x] 2026-09-03: Verhaltensregressionen für Befehl, Reihenfolge, Abbruch,
  Aliase, Nutzerargumente und Erfolgsmarker ergänzt.
- [x] 2026-09-03: Repository- und Dokumentationshygienetests ergänzt.
- [x] 2026-09-03: Aktive deutsche Dokumentation und Changelog aktualisiert.
- [x] 2026-09-03: Alle in der Arbeitsumgebung möglichen Prüfungen ausgeführt
  und tatsächliche Ergebnisse dokumentiert; echte Godot-Läufe bleiben mangels
  Binärdatei offen.

## Erkenntnisse und Überraschungen

- Der bestehende Testbefehl ist bereits auf den Repository-eigenen
  `bootstrap_integration_test.gd` und dessen expliziten Erfolgsmarker
  ausgerichtet. Diese Absicherung bleibt unverändert verbindlich.
- Die CI stellt Godot bereits plattformübergreifend als `godot4` im `PATH`
  bereit und ruft danach das gemeinsame Release-Gate auf. Ein separater
  Workflow-Import wäre daher redundant.
- In der Arbeitsumgebung gibt es keinen Befehl `python`; `python3` 3.11.2 ist
  vorhanden. Erst der vorhandene Installer stellte `pytest` in der ignorierten
  `.venv` bereit.
- Der bisherige Live-Repository-Test für Release-Metadaten erwartete ein leeres
  `Unveröffentlicht`. Das widersprach der vorgeschriebenen Changelog-Pflege.
  Der Release-Befehl blockiert offene Einträge weiterhin; nur der Test erwartet
  diesen normalen Entwicklungszustand nun ausdrücklich.
- Ein nutzerseitiger Lauf unter Arch Linux mit Godot 4.7.2 importierte alle 24
  Assets erfolgreich und startete anschließend den Spielprozess. Die danach
  ausgegebene `DRI_PRIME`-Warnung verhinderte den Ablauf nicht.

## Entscheidungen

- Der Importbefehl wird in `g2dtool.godot` neben den vorhandenen
  Befehlserzeugern implementiert; dafür ist kein zusätzliches Modul nötig.
- Import und Integrationstest bleiben getrennte Gate-Schritte. Nur diese
  beiden Schritte besitzen eine harte Abhängigkeit; Doctor, Stil und
  Python-Tests werden weiterhin unabhängig gesammelt ausgeführt.
- Nutzerargumente werden ausschließlich an den eigentlichen Run- oder
  Testbefehl gehängt, niemals an den vorbereitenden Import.
- `.github/workflows/ci.yml` bleibt unverändert: Alle Matrixjobs stellen Godot
  bereits im `PATH` bereit und erhalten den Import über den gemeinsamen
  `check`-Aufruf ohne redundanten Workflow-Schritt.

## Prüfungen

- `python -m pytest tools/tests/test_godot.py tools/tests/test_check.py
  tools/tests/test_cli.py -q` — nicht gestartet: `python` fehlt im `PATH`
  (Exit 127).
- `python3 -m pytest tools/tests/test_godot.py tools/tests/test_check.py
  tools/tests/test_cli.py -q` — nicht gestartet: Das systemweite Python 3.11.2
  enthält kein `pytest`.
- `PYTHONPATH=tools/src:tools/tests python3 -m unittest
  tools/tests/test_godot.py tools/tests/test_check.py tools/tests/test_cli.py` —
  bestanden, 43 Tests.
- `PYTHONPATH=tools/src:tools/tests python3 -m unittest
  tools/tests/test_godot.py tools/tests/test_check.py tools/tests/test_cli.py
  tools/tests/test_source_hygiene.py` — bestanden, 59 Tests.
- `python3 game/tools/generate_scale_reference_assets.py --check` — bestanden;
  21 deterministische Visual-Lab-Assets und 2 optimierte Nebeltexturen geprüft.
- `python3 tools/control.py style` — bestanden, 75 Quelldateien geprüft.
- `python3 tools/control.py godot4 import` — nicht ausführbar (Exit 1): Godot 4
  wurde in dieser Arbeitsumgebung nicht gefunden; kein echter Import erfolgt.
- `python3 tools/control.py install --yes` — `.venv`, lokales Tooling und die
  deklarierte Entwicklungsvoraussetzung `pytest` eingerichtet; Gesamt-Exit 1,
  weil Godot 4 weiterhin fehlt.
- `.venv/bin/python -m pytest tools/tests/test_godot.py
  tools/tests/test_check.py tools/tests/test_cli.py -q` — bestanden, 43 Tests.
- `.venv/bin/python -m pytest tools/tests/test_godot.py
  tools/tests/test_check.py tools/tests/test_cli.py
  tools/tests/test_source_hygiene.py tools/tests/test_release.py -q` —
  bestanden, 74 Tests.
- Erster `python3 tools/control.py check` nach Changelog-Pflege — 187 von 188
  Python-Tests bestanden; der Live-Release-Test erwartete fälschlich einen
  leeren unveröffentlichten Abschnitt. Godot fehlte ebenfalls.
- `python3 tools/control.py check` nach Korrektur des Testvertrags — Stilgate
  und 188 Python-Tests bestanden; Gesamt-Exit 1 ausschließlich wegen fehlendem
  Godot 4. Der Integrationstest wurde nach einer einzelnen Import-Skip-Meldung
  nicht gestartet; es erschien keine `.ctex`-Fehlerkaskade.
- `git diff --check` — bestanden, keine Whitespacefehler.
- `git ls-files "game/.godot/**"` — keine Ausgabe; keine Godot-Cachepfade
  getrackt.
- `git ls-files "*.ctex"` — keine Ausgabe; keine `.ctex`-Dateien getrackt.
- `git status --short` — ausschließlich die beabsichtigten Tooling-, Test-,
  Plan-, Changelog- und Dokumentationsänderungen; `.venv` und Godot-Caches
  erscheinen nicht.
- `python tools/control.py godot4 run` — vom Benutzer unter Arch Linux mit
  Godot 4.7.2 ausgeführt: vollständiger Import von 24 Assets abgeschlossen und
  der nachfolgende Spielprozess gestartet.

## Wiederholbarkeit und Wiederherstellung

Der Import darf beliebig oft ausgeführt werden; Godot aktualisiert seinen
ignorierten Cache aus den getrackten Quellen. Nach einem frischen Clone oder dem
Entfernen lokaler Caches stellt `python tools/control.py godot4 import` den
Zustand wieder her. Ein fehlgeschlagener Import lässt sich nach Behebung des
ersten gemeldeten Quellfehlers erneut starten. Es werden weder Cache-Artefakte
noch lokale Rechnerpfade versioniert.

## Ergebnis und Rückblick

Das Repository besitzt nun einen expliziten, wiederverwendeten Editorimport und
eine harte Importabhängigkeit für Run, Test und Release-Gate. Automatisierte
Tests belegen Befehlsform, Argumentgrenzen, Reihenfolge und Fehlerabbruch. Die
Dokumentation erklärt Cache-Grenze, lokale und CI-Abläufe sowie
Wiederherstellung. Ein echter Godot-Import und der echte Bootstrap-Test konnten
in dieser Arbeitsumgebung nicht ausgeführt werden, weil keine Godot-4-Binärdatei
verfügbar ist; dieser verbleibende Prüfpunkt ist nicht als bestanden markiert.
Der zusätzlich vom Benutzer ausgeführte End-to-End-Lauf bestätigte Import und
anschließenden Spielstart auf Arch Linux mit Godot 4.7.2.
