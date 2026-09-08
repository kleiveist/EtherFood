"""Tests for the Green Hero Pixelart still-frame package."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path
import struct
import unittest


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
PACKAGE_ROOT = (
    REPOSITORY_ROOT
    / "game"
    / "assets"
    / "characters"
    / "heroes"
    / "green_hero"
    / "pixel_art"
)
MANIFEST_PATH = PACKAGE_ROOT / "stand_walk_manifest.json"
RESOURCE_PATH = PACKAGE_ROOT / "green_hero_stand_walk_pixel_art.tres"
PNG_SIGNATURE = b"\x89PNG\r\n\x1a\n"
EXPECTED_ANIMATIONS = (
    "stand_n",
    "stand_ne",
    "stand_e",
    "stand_se",
    "stand_s",
    "stand_sw",
    "stand_w",
    "stand_nw",
    "walk_n",
    "walk_ne",
    "walk_e",
    "walk_se",
    "walk_s",
    "walk_sw",
    "walk_w",
    "walk_nw",
)


class GreenHeroPixelArtAssetTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))

    def test_manifest_defines_all_directional_stills(self) -> None:
        animations = self.manifest["animations"]

        self.assertEqual(self.manifest["schema_version"], 1)
        self.assertEqual(self.manifest["variant"], "pixel_art")
        self.assertEqual(self.manifest["source_canvas"], [265, 265])
        self.assertEqual(self.manifest["defaults"]["frame_count"], 1)
        self.assertEqual(
            tuple(animation["name"] for animation in animations),
            EXPECTED_ANIMATIONS,
        )
        self.assertEqual(len({item["source_file"] for item in animations}), 16)
        self.assertEqual(len({item["runtime_file"] for item in animations}), 16)
        self.assertTrue(
            all(
                item["alpha_bounds"][1] == 10
                and item["alpha_bounds"][3] == 245
                for item in animations
            )
        )

    def test_runtime_pngs_match_the_audited_manifest(self) -> None:
        for animation in self.manifest["animations"]:
            with self.subTest(animation=animation["name"]):
                runtime_path = PACKAGE_ROOT / animation["runtime_file"]
                payload = runtime_path.read_bytes()

                self.assertEqual(hashlib.sha256(payload).hexdigest(), animation["sha256"])
                self.assertEqual(payload[:8], PNG_SIGNATURE)
                self.assertEqual(payload[12:16], b"IHDR")
                self.assertEqual(struct.unpack(">II", payload[16:24]), (265, 265))
                self.assertEqual(payload[24], 8)
                self.assertEqual(payload[25], 6)
                self.assertEqual(payload[28], 0)

    def test_sprite_frames_references_every_runtime_png_once(self) -> None:
        resource = RESOURCE_PATH.read_text(encoding="utf-8")

        self.assertEqual(resource.count('[ext_resource type="Texture2D"'), 16)
        self.assertEqual(resource.count('"duration": 1.0'), 16)
        for animation in self.manifest["animations"]:
            with self.subTest(animation=animation["name"]):
                resource_path = (
                    f"{self.manifest['resource_root']}/{animation['runtime_file']}"
                )
                self.assertEqual(resource.count(f'path="{resource_path}"'), 1)
                self.assertEqual(
                    resource.count(f'"name": &"{animation["name"]}"'),
                    1,
                )

    def test_runtime_textures_use_lossless_import_without_mipmaps(self) -> None:
        for animation in self.manifest["animations"]:
            with self.subTest(animation=animation["name"]):
                import_path = PACKAGE_ROOT / f"{animation['runtime_file']}.import"
                settings = import_path.read_text(encoding="utf-8")

                self.assertIn("compress/mode=0", settings)
                self.assertIn("mipmaps/generate=false", settings)
                self.assertIn("process/size_limit=0", settings)


if __name__ == "__main__":
    unittest.main()
