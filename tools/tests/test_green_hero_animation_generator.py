"""Tests for the deterministic Green Hero animation package generator."""

from importlib import util
import json
from pathlib import Path
import sys
from tempfile import TemporaryDirectory
from types import ModuleType
import unittest


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
GAME_ROOT = REPOSITORY_ROOT / "game"
GENERATOR_PATH = GAME_ROOT / "tools" / "generate_green_hero_animations.py"
PACKAGE_ROOT = (
    GAME_ROOT
    / "assets"
    / "characters"
    / "heroes"
    / "green_hero"
    / "ultra"
)
MANIFEST_PATH = PACKAGE_ROOT / "stand_walk_manifest.json"
RESOURCE_PATH = PACKAGE_ROOT / "green_hero_stand_walk_ultra.tres"


def _load_generator() -> ModuleType:
    spec = util.spec_from_file_location("green_hero_generator_under_test", GENERATOR_PATH)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load generator at {GENERATOR_PATH}")
    module = util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


class GreenHeroAnimationGeneratorTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.generator = _load_generator()

    def test_manifest_defines_exact_stand_walk_direction_contract(self) -> None:
        package = self.generator.load_package(MANIFEST_PATH)
        actual = tuple(
            (animation.name, animation.source_key)
            for animation in package.animations
        )
        expected = (
            ("stand_n", "w"),
            ("stand_ne", "wd"),
            ("stand_e", "d"),
            ("stand_se", "sd"),
            ("stand_s", "s"),
            ("stand_sw", "sa"),
            ("stand_w", "a"),
            ("stand_nw", "wa"),
            ("walk_n", "w"),
            ("walk_ne", "wd"),
            ("walk_e", "d"),
            ("walk_se", "sd"),
            ("walk_s", "s"),
            ("walk_sw", "sa"),
            ("walk_w", "a"),
            ("walk_nw", "wa"),
        )

        self.assertEqual(actual, expected)
        self.assertEqual(sum(item.frame_count for item in package.animations), 256)
        self.assertTrue(
            all(
                (item.columns, item.rows, item.frame_order)
                == (4, 4, tuple(range(16)))
                for item in package.animations
            )
        )
        self.assertTrue(all(item.loop for item in package.animations))
        self.assertTrue(
            all(
                item.frame_durations_ms == (120,) * 16
                for item in package.animations
            )
        )
        self.assertEqual(package.source_canvas, (640, 640))
        self.assertEqual(package.reference_pose.animation, "stand_s")
        self.assertEqual(package.reference_pose.frame, 0)
        self.assertEqual(package.reference_pose.alpha_bounds, (158, 7, 386, 618))
        self.assertEqual(package.reference_pose.foot_anchor, (320, 625))
        self.assertEqual(package.reference_pose.height_pixels, 618)
        self.assertEqual(package.reference_pose.world_height, 80)

    def test_runtime_assets_and_generated_resource_are_current(self) -> None:
        package = self.generator.load_package(MANIFEST_PATH)

        self.generator.validate_runtime_assets(package, PACKAGE_ROOT)
        generated = self.generator.generate_resource(package)

        self.assertEqual(RESOURCE_PATH.read_text(encoding="utf-8"), generated)
        self.assertEqual(generated.count('[sub_resource type="AtlasTexture"'), 256)
        self.assertEqual(generated.count('[ext_resource type="Texture2D"'), 16)

    def test_all_runtime_textures_use_lossless_import_without_mipmaps(self) -> None:
        package = self.generator.load_package(MANIFEST_PATH)

        for animation in package.animations:
            with self.subTest(animation=animation.name):
                import_path = PACKAGE_ROOT / f"{animation.runtime_file}.import"
                settings = import_path.read_text(encoding="utf-8")
                self.assertIn("compress/mode=0", settings)
                self.assertIn("mipmaps/generate=false", settings)
                self.assertIn("process/size_limit=0", settings)

    def test_invalid_direction_source_mapping_is_rejected(self) -> None:
        manifest = json.loads(MANIFEST_PATH.read_text(encoding="utf-8"))
        manifest["animations"][0]["source_key"] = "a"
        with TemporaryDirectory() as temporary_directory:
            invalid_manifest = Path(temporary_directory) / "manifest.json"
            invalid_manifest.write_text(
                json.dumps(manifest),
                encoding="utf-8",
                newline="\n",
            )

            with self.assertRaisesRegex(
                self.generator.AnimationPackageError,
                "wrong source_key for stand_n",
            ):
                self.generator.load_package(invalid_manifest)


if __name__ == "__main__":
    unittest.main()
