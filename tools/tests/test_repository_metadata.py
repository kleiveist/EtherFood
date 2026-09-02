"""Tests for the reviewed GitHub repository metadata contract."""

from __future__ import annotations

import json
from pathlib import Path
import re
import unittest


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
METADATA_PATH = REPOSITORY_ROOT / ".github" / "repository-metadata.json"
GUIDE_PATH = (
    REPOSITORY_ROOT
    / "docs"
    / "developer"
    / "project-identity.md"
)
EXPECTED_DESCRIPTION = (
    "Ein Top-down-Action-RPG über den Wiederaufbau einer verlorenen Welt, "
    "die Rückkehr ihrer Zivilisationen und vergessene Erinnerungen."
)
EXPECTED_TOPICS = (
    "2d-game",
    "action-rpg",
    "game-development",
    "gdscript",
    "godot",
    "godot-4",
    "python",
    "top-down",
)
TOPIC_PATTERN = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")


class RepositoryMetadataTests(unittest.TestCase):
    def setUp(self) -> None:
        self.metadata = json.loads(METADATA_PATH.read_text(encoding="utf-8"))

    def test_contract_has_only_reviewed_fields(self) -> None:
        self.assertEqual(
            set(self.metadata),
            {"schema_version", "description", "homepage", "topics"},
        )
        self.assertEqual(self.metadata["schema_version"], 1)

    def test_description_is_concise_and_matches_readme_identity(self) -> None:
        description = self.metadata["description"]
        readme = (REPOSITORY_ROOT / "README.md").read_text(encoding="utf-8")

        self.assertEqual(description, EXPECTED_DESCRIPTION)
        self.assertLessEqual(len(description), 160)
        self.assertNotIn("\n", description)
        self.assertIn(EXPECTED_DESCRIPTION, " ".join(readme.split()))

    def test_topics_are_focused_unique_and_github_compatible(self) -> None:
        topics = self.metadata["topics"]

        self.assertEqual(tuple(topics), EXPECTED_TOPICS)
        self.assertEqual(topics, sorted(topics))
        self.assertEqual(len(topics), len(set(topics)))
        self.assertLessEqual(len(topics), 20)
        for topic in topics:
            with self.subTest(topic=topic):
                self.assertRegex(topic, TOPIC_PATTERN)
                self.assertLessEqual(len(topic), 50)

    def test_homepage_is_intentionally_omitted(self) -> None:
        self.assertIsNone(self.metadata["homepage"])

    def test_project_identity_documents_audit_and_template_origin(self) -> None:
        guide = " ".join(GUIDE_PATH.read_text(encoding="utf-8").split())
        required_text = (
            ".github/repository-metadata.json",
            EXPECTED_DESCRIPTION,
            "Forge2D Template",
            'template_id = "forge2d-template"',
            "g2dtool",
        )

        for text in required_text:
            with self.subTest(text=text):
                self.assertIn(text, guide)

    def test_documentation_entry_points_link_the_metadata_guide(self) -> None:
        entry_points = (
            REPOSITORY_ROOT / "docs" / "index.md",
            REPOSITORY_ROOT / "docs" / "developer" / "index.md",
        )
        for path in entry_points:
            with self.subTest(path=path.relative_to(REPOSITORY_ROOT)):
                self.assertIn(
                    "project-identity.md",
                    path.read_text(encoding="utf-8"),
                )


if __name__ == "__main__":
    unittest.main()
