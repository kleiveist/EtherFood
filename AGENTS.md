<!-- AUTO-GENERATED:backlink START -->
[← Zurück](README.md)
<!-- AUTO-GENERATED:backlink END -->
# Repository-Regeln für ether-food

Beginne bei der [Dokumentationsübersicht](docs/index.md).

- Das deutsche Spielkonzept unter [`docs/concept/`](docs/concept/index.md) ist
  die einzige aktuelle Quelle für Kanon, Handlung, Welt und Spielmechanik.
- Die Projektdokumentation wird auf Deutsch geführt. Code, Befehle, Pfade und
  technische Bezeichner dürfen Englisch bleiben.
- Die geerbte
  [Forge2D-Grundlage](docs/.forge2d-template/index.md) bleibt unverändert auf
  Englisch und dient nur als technische und historische Referenz.
- Halte die Dokumentation einfach, verständlich und nah an der tatsächlichen
  Entwicklung. Führe keine zweite Konzeptfassung und keinen Sprachspiegel.
- Änderungen an bereits angenommenem Kanon benötigen eine nachvollziehbare
  Entscheidung unter `docs/concept/entscheidungen/`.
- Komplexe technische Arbeiten verwenden fortlaufend gepflegte Pläne unter
  `docs/developer/plans/` und folgen [`.agent/PLANS.md`](.agent/PLANS.md).
- Aktualisiere Tests und passende Dokumentation, wenn sich Verhalten ändert.
  Es gelten die geerbten Python- und GDScript-Stilregeln.
- Verwende keine zerstörerischen Git-Befehle, übernimm keine Geheimnisse und
  füge keine ungeprüften Abhängigkeiten hinzu. Generierte Caches, Binärdateien
  und lokale Rechnerpfade gehören nicht ins Repository.
- Führe zuerst die schnellsten passenden Prüfungen aus. Der vollständige
  Standardlauf ist `python tools/control.py check`. Melde nur tatsächlich
  ausgeführte Prüfungen.
