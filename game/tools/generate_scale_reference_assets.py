#!/usr/bin/env python3
"""Generate EtherFood's original Visual Lab prototype PNG assets.

The generator uses only Python's standard library. It performs no network
access and deliberately draws on a four-world-pixel grid without antialiasing.
Run with ``--check`` to verify that committed PNGs match the deterministic
output byte for byte.
"""

from __future__ import annotations

import argparse
import struct
import sys
import zlib
from collections.abc import Callable, Iterable
from pathlib import Path

Color = tuple[int, int, int, int]
Point = tuple[int, int]

TRANSPARENT: Color = (0, 0, 0, 0)
INK: Color = (20, 29, 34, 255)
INK_SOFT: Color = (31, 43, 45, 255)
GROUND: Color = (39, 64, 58, 255)
GROUND_DARK: Color = (29, 49, 48, 255)
GROUND_LIGHT: Color = (53, 81, 67, 255)
MOSS: Color = (73, 101, 70, 255)
STONE_DARK: Color = (56, 59, 57, 255)
STONE: Color = (104, 101, 85, 255)
STONE_LIGHT: Color = (156, 145, 111, 255)
WOOD_DARK: Color = (55, 34, 27, 255)
WOOD: Color = (105, 61, 34, 255)
WOOD_LIGHT: Color = (157, 99, 48, 255)
GOLD_DARK: Color = (119, 82, 35, 255)
GOLD: Color = (213, 169, 73, 255)
SKIN_DARK: Color = (112, 67, 51, 255)
SKIN: Color = (187, 126, 78, 255)
SKIN_LIGHT: Color = (220, 166, 102, 255)
GREEN_DEEP: Color = (25, 62, 48, 255)
GREEN_DARK: Color = (34, 84, 53, 255)
GREEN: Color = (61, 119, 66, 255)
GREEN_LIGHT: Color = (119, 158, 79, 255)
PURPLE_DEEP: Color = (46, 29, 53, 255)
PURPLE_DARK: Color = (75, 35, 71, 255)
PURPLE: Color = (112, 48, 83, 255)
RED: Color = (142, 57, 65, 255)
RED_LIGHT: Color = (185, 76, 72, 255)
STEEL_DARK: Color = (54, 64, 70, 255)
STEEL: Color = (103, 116, 116, 255)
STEEL_LIGHT: Color = (162, 161, 139, 255)

SCALE = 4
OUTPUT_DIR = (
    Path(__file__).resolve().parents[1]
    / "assets"
    / "prototypes"
    / "scale_references"
)


class Canvas:
    """Tiny deterministic RGBA raster canvas with hard-edged primitives."""

    def __init__(self, width: int, height: int, fill: Color = TRANSPARENT) -> None:
        self.width = width
        self.height = height
        self.pixels = bytearray(fill * (width * height))

    def set_pixel(self, x: int, y: int, color: Color) -> None:
        if 0 <= x < self.width and 0 <= y < self.height:
            offset = (y * self.width + x) * 4
            self.pixels[offset : offset + 4] = bytes(color)

    def rect(self, x: int, y: int, width: int, height: int, color: Color) -> None:
        for draw_y in range(max(0, y), min(self.height, y + height)):
            for draw_x in range(max(0, x), min(self.width, x + width)):
                self.set_pixel(draw_x, draw_y, color)

    def polygon(self, points: Iterable[Point], color: Color) -> None:
        vertices = tuple(points)
        min_x = max(0, min(point[0] for point in vertices))
        max_x = min(self.width - 1, max(point[0] for point in vertices))
        min_y = max(0, min(point[1] for point in vertices))
        max_y = min(self.height - 1, max(point[1] for point in vertices))
        for y in range(min_y, max_y + 1):
            for x in range(min_x, max_x + 1):
                if _point_in_polygon(x + 0.5, y + 0.5, vertices):
                    self.set_pixel(x, y, color)

    def disc(
        self,
        center_x: int,
        center_y: int,
        radius_x: int,
        radius_y: int,
        color: Color,
    ) -> None:
        for y in range(center_y - radius_y, center_y + radius_y + 1):
            for x in range(center_x - radius_x, center_x + radius_x + 1):
                normalized_x = ((x - center_x) / max(1, radius_x)) ** 2
                normalized_y = ((y - center_y) / max(1, radius_y)) ** 2
                if normalized_x + normalized_y <= 1.0:
                    self.set_pixel(x, y, color)

    def line(self, start: Point, end: Point, color: Color, width: int = 1) -> None:
        x_0, y_0 = start
        x_1, y_1 = end
        delta_x = abs(x_1 - x_0)
        step_x = 1 if x_0 < x_1 else -1
        delta_y = -abs(y_1 - y_0)
        step_y = 1 if y_0 < y_1 else -1
        error = delta_x + delta_y
        while True:
            self.rect(x_0 - width // 2, y_0 - width // 2, width, width, color)
            if x_0 == x_1 and y_0 == y_1:
                break
            doubled_error = 2 * error
            if doubled_error >= delta_y:
                error += delta_y
                x_0 += step_x
            if doubled_error <= delta_x:
                error += delta_x
                y_0 += step_y

    def upscale(self, factor: int) -> "Canvas":
        scaled = Canvas(self.width * factor, self.height * factor)
        for y in range(self.height):
            for x in range(self.width):
                offset = (y * self.width + x) * 4
                color = tuple(self.pixels[offset : offset + 4])
                scaled.rect(x * factor, y * factor, factor, factor, color)  # type: ignore[arg-type]
        return scaled

    def blit(self, source: "Canvas", left: int, top: int) -> None:
        for source_y in range(source.height):
            for source_x in range(source.width):
                source_offset = (source_y * source.width + source_x) * 4
                color = tuple(source.pixels[source_offset : source_offset + 4])
                if color[3] != 0:
                    self.set_pixel(left + source_x, top + source_y, color)  # type: ignore[arg-type]

    def png_bytes(self) -> bytes:
        signature = b"\x89PNG\r\n\x1a\n"
        header = struct.pack(">IIBBBBB", self.width, self.height, 8, 6, 0, 0, 0)
        scanlines = bytearray()
        row_size = self.width * 4
        for y in range(self.height):
            scanlines.append(0)
            start = y * row_size
            scanlines.extend(self.pixels[start : start + row_size])
        return signature + _png_chunk(b"IHDR", header) + _png_chunk(
            b"IDAT", zlib.compress(bytes(scanlines), level=9)
        ) + _png_chunk(b"IEND", b"")

    def alpha_bounds(self) -> tuple[int, int, int, int] | None:
        visible: list[tuple[int, int]] = []
        for y in range(self.height):
            for x in range(self.width):
                if self.pixels[(y * self.width + x) * 4 + 3] != 0:
                    visible.append((x, y))
        if not visible:
            return None
        return (
            min(point[0] for point in visible),
            min(point[1] for point in visible),
            max(point[0] for point in visible),
            max(point[1] for point in visible),
        )


def _point_in_polygon(x: float, y: float, points: tuple[Point, ...]) -> bool:
    inside = False
    previous_x, previous_y = points[-1]
    for current_x, current_y in points:
        crosses = (current_y > y) != (previous_y > y)
        if crosses:
            edge_x = (previous_x - current_x) * (y - current_y) / (
                previous_y - current_y
            ) + current_x
            if x < edge_x:
                inside = not inside
        previous_x, previous_y = current_x, current_y
    return inside


def _png_chunk(kind: bytes, payload: bytes) -> bytes:
    checksum = zlib.crc32(kind)
    checksum = zlib.crc32(payload, checksum)
    return struct.pack(">I", len(payload)) + kind + payload + struct.pack(">I", checksum)


def hero_idle_down() -> Canvas:
    image = Canvas(14, 20)
    image.polygon(
        [(4, 1), (5, 0), (9, 0), (11, 2), (12, 6), (10, 9), (4, 9), (2, 6), (3, 2)],
        INK,
    )
    image.polygon(
        [(4, 2), (6, 1), (9, 1), (11, 3), (11, 6), (9, 8), (4, 8), (3, 6), (3, 3)],
        WOOD_DARK,
    )
    image.rect(4, 2, 6, 2, WOOD)
    image.rect(4, 4, 7, 2, SKIN)
    image.rect(5, 4, 3, 1, SKIN_LIGHT)
    image.rect(5, 6, 5, 2, SKIN_DARK)
    image.rect(6, 6, 1, 1, INK)
    image.rect(9, 6, 1, 1, INK)
    image.polygon(
        [
            (2, 8),
            (4, 7),
            (10, 7),
            (12, 8),
            (13, 12),
            (12, 16),
            (10, 17),
            (4, 17),
            (1, 15),
            (1, 11),
        ],
        INK,
    )
    image.polygon(
        [(3, 9), (5, 8), (9, 8), (11, 9), (11, 15), (9, 16), (4, 16), (2, 14), (2, 11)],
        STEEL_DARK,
    )
    image.rect(4, 9, 6, 2, STEEL)
    image.rect(3, 10, 2, 5, WOOD)
    image.rect(10, 10, 2, 5, WOOD_DARK)
    image.rect(5, 11, 4, 1, GOLD)
    image.rect(5, 12, 5, 4, PURPLE_DARK)
    image.rect(6, 12, 1, 3, RED)
    image.rect(4, 16, 3, 2, INK)
    image.rect(8, 16, 3, 2, INK)
    image.rect(4, 17, 2, 3, WOOD_DARK)
    image.rect(9, 17, 2, 3, WOOD_DARK)
    image.rect(4, 19, 2, 1, STEEL_LIGHT)
    image.rect(9, 19, 2, 1, STEEL_LIGHT)
    image.set_pixel(11, 9, STEEL_LIGHT)
    return image.upscale(SCALE)


def small_enemy() -> Canvas:
    image = Canvas(17, 14)
    image.rect(4, 12, 4, 2, INK)
    image.rect(10, 12, 4, 2, INK)
    image.polygon(
        [
            (1, 7),
            (4, 5),
            (5, 2),
            (6, 2),
            (7, 0),
            (9, 2),
            (11, 0),
            (12, 3),
            (13, 5),
            (16, 7),
            (15, 11),
            (12, 12),
            (5, 12),
            (1, 10),
        ],
        INK,
    )
    image.disc(9, 5, 4, 4, PURPLE)
    image.rect(6, 2, 5, 2, RED_LIGHT)
    image.rect(5, 4, 7, 3, PURPLE_DARK)
    image.rect(6, 6, 2, 1, INK)
    image.rect(10, 6, 2, 1, INK)
    image.set_pixel(7, 6, GOLD)
    image.set_pixel(10, 6, GOLD)
    image.polygon(
        [(2, 7), (5, 6), (8, 8), (11, 7), (15, 8), (14, 10), (11, 11), (6, 11), (2, 10)],
        PURPLE_DARK,
    )
    image.rect(5, 8, 8, 2, RED)
    image.rect(7, 9, 4, 3, PURPLE_DEEP)
    image.set_pixel(5, 7, RED_LIGHT)
    image.rect(4, 13, 4, 1, RED)
    image.rect(10, 13, 4, 1, RED)
    return image.upscale(SCALE)


def door_entrance() -> Canvas:
    image = Canvas(21, 28)
    image.polygon([(2, 0), (18, 0), (21, 8), (18, 12), (2, 12), (0, 8)], INK)
    image.polygon([(3, 1), (17, 1), (19, 7), (17, 9), (3, 9), (1, 7)], WOOD_DARK)
    image.polygon([(4, 2), (16, 2), (18, 7), (16, 8), (3, 8)], WOOD)
    image.line((4, 3), (17, 7), WOOD_LIGHT)
    image.line((8, 1), (6, 8), INK_SOFT)
    image.line((14, 1), (15, 8), INK_SOFT)
    image.rect(1, 9, 19, 17, INK)
    image.rect(2, 10, 17, 15, STONE_DARK)
    image.rect(3, 11, 4, 4, STONE)
    image.rect(14, 11, 4, 4, STONE)
    image.rect(2, 16, 5, 4, STONE)
    image.rect(14, 16, 5, 4, STONE)
    image.rect(3, 21, 4, 3, STONE_LIGHT)
    image.rect(14, 21, 4, 3, STONE)
    image.rect(6, 11, 9, 15, INK)
    image.rect(7, 12, 7, 14, WOOD_DARK)
    image.rect(8, 13, 5, 13, WOOD)
    image.line((10, 13), (10, 25), WOOD_LIGHT)
    image.rect(12, 19, 1, 1, GOLD)
    image.rect(5, 26, 11, 2, INK)
    image.rect(6, 26, 9, 1, STONE_LIGHT)
    return image.upscale(SCALE)


def house_wall() -> Canvas:
    image = Canvas(75, 36)
    image.polygon([(4, 0), (70, 0), (75, 17), (70, 23), (4, 23), (0, 17)], INK)
    image.polygon([(5, 1), (69, 1), (73, 16), (69, 20), (4, 20), (2, 16)], WOOD_DARK)
    image.polygon([(6, 2), (68, 2), (71, 15), (68, 18), (4, 18)], WOOD)
    for x in range(8, 69, 10):
        image.line((x, 2), (x - 3, 18), INK_SOFT)
        image.line((x + 1, 3), (x + 7, 3), WOOD_LIGHT)
    image.rect(2, 19, 71, 5, INK)
    image.rect(3, 20, 69, 2, WOOD_LIGHT)
    image.rect(2, 23, 71, 12, INK)
    image.rect(3, 23, 69, 11, STONE_DARK)
    for x in range(4, 70, 9):
        color = STONE if x % 18 == 4 else STONE_LIGHT
        image.rect(x, 24, 7, 4, color)
    for x in range(0, 72, 10):
        color = STONE_LIGHT if x % 20 == 0 else STONE
        image.rect(x + 3, 29, 8, 4, color)
    image.rect(48, 24, 12, 9, INK)
    image.rect(50, 25, 8, 6, PURPLE_DEEP)
    image.rect(51, 25, 3, 2, STEEL_LIGHT)
    image.rect(54, 28, 4, 3, STEEL_DARK)
    image.rect(1, 34, 73, 2, INK)
    image.rect(3, 34, 69, 1, STONE_LIGHT)
    image.rect(0, 35, 75, 1, STONE_DARK)
    return image.upscale(SCALE)


def large_enemy() -> Canvas:
    image = Canvas(43, 32)
    image.rect(9, 28, 9, 4, INK)
    image.rect(25, 28, 9, 4, INK)
    image.polygon(
        [
            (8, 10),
            (13, 5),
            (16, 5),
            (17, 1),
            (20, 0),
            (25, 1),
            (26, 5),
            (31, 6),
            (36, 10),
            (41, 17),
            (40, 25),
            (34, 29),
            (27, 29),
            (22, 27),
            (17, 29),
            (9, 29),
            (3, 25),
            (2, 17),
        ],
        INK,
    )
    image.disc(21, 8, 8, 7, PURPLE_DEEP)
    image.polygon([(16, 3), (20, 1), (25, 2), (27, 6), (25, 12), (17, 12), (14, 7)], PURPLE)
    image.rect(16, 4, 7, 3, RED)
    image.rect(17, 4, 5, 1, RED_LIGHT)
    image.rect(16, 8, 3, 2, INK)
    image.rect(24, 8, 3, 2, INK)
    image.set_pixel(17, 8, GOLD)
    image.set_pixel(25, 8, GOLD)
    image.rect(19, 11, 6, 2, INK)
    image.disc(10, 17, 8, 8, PURPLE_DARK)
    image.disc(33, 17, 8, 8, PURPLE_DARK)
    image.rect(4, 17, 7, 7, RED)
    image.rect(32, 17, 7, 7, RED)
    image.rect(8, 12, 8, 3, STEEL)
    image.rect(28, 12, 7, 3, STEEL_DARK)
    image.polygon([(14, 12), (29, 12), (33, 19), (29, 27), (14, 27), (10, 19)], STEEL_DARK)
    image.polygon([(16, 13), (27, 13), (30, 19), (27, 25), (16, 25), (13, 19)], PURPLE)
    image.rect(15, 15, 13, 2, RED)
    image.rect(19, 16, 5, 8, PURPLE_DEEP)
    image.rect(10, 27, 9, 3, PURPLE_DEEP)
    image.rect(24, 27, 9, 3, PURPLE_DEEP)
    image.rect(10, 31, 8, 1, STEEL_LIGHT)
    image.rect(26, 31, 8, 1, STEEL_LIGHT)
    image.set_pixel(12, 11, STEEL_LIGHT)
    return image.upscale(SCALE)


def tree() -> Canvas:
    image = Canvas(41, 48)
    image.disc(20, 38, 14, 5, INK_SOFT)
    image.rect(17, 31, 8, 15, INK)
    image.polygon(
        [(18, 29), (24, 29), (24, 43), (29, 47), (24, 47), (21, 44), (17, 48), (11, 47), (17, 42)],
        WOOD_DARK,
    )
    image.rect(19, 29, 4, 15, WOOD)
    image.rect(19, 31, 1, 10, WOOD_LIGHT)
    image.disc(10, 21, 10, 12, INK)
    image.disc(29, 21, 11, 13, INK)
    image.disc(20, 10, 13, 10, INK)
    image.disc(20, 25, 15, 13, INK)
    image.disc(10, 20, 8, 10, GREEN_DARK)
    image.disc(29, 20, 9, 11, GREEN_DEEP)
    image.disc(20, 10, 11, 9, GREEN_DARK)
    image.disc(20, 25, 13, 11, GREEN)
    image.disc(12, 13, 7, 7, GREEN)
    image.disc(28, 10, 7, 7, GREEN_DEEP)
    image.disc(8, 25, 6, 7, GREEN_DEEP)
    image.disc(32, 27, 6, 7, GREEN_DARK)
    image.disc(16, 6, 5, 4, GREEN_LIGHT)
    image.disc(9, 16, 4, 4, GREEN_LIGHT)
    image.disc(20, 19, 6, 5, GREEN_LIGHT)
    image.disc(28, 25, 4, 4, GREEN)
    image.rect(19, 0, 4, 2, GREEN_DARK)
    image.set_pixel(12, 9, GREEN_LIGHT)
    image.set_pixel(25, 6, MOSS)
    image.set_pixel(16, 21, GREEN_DEEP)
    image.set_pixel(29, 17, GREEN_LIGHT)
    image.rect(15, 47, 5, 1, WOOD_LIGHT)
    image.rect(23, 47, 6, 1, WOOD_DARK)
    return image.upscale(SCALE)


def scale_ground() -> Canvas:
    image = Canvas(600, 80, GROUND)
    image.polygon(
        [
            (0, 49),
            (82, 46),
            (158, 50),
            (232, 47),
            (315, 52),
            (402, 48),
            (490, 51),
            (600, 46),
            (600, 74),
            (500, 71),
            (410, 75),
            (315, 71),
            (226, 76),
            (134, 72),
            (60, 75),
            (0, 71),
        ],
        GROUND_DARK,
    )
    for tile_y in range(3, 77, 8):
        for tile_x in range(4, 596, 11):
            value = (tile_x * 37 + tile_y * 61 + tile_x * tile_y) % 17
            if value in (0, 3):
                image.rect(tile_x, tile_y, 2, 1, GROUND_LIGHT)
                image.set_pixel(tile_x - 1, tile_y + 1, MOSS)
            elif value == 7:
                image.rect(tile_x, tile_y, 3, 1, GROUND_DARK)
            elif value == 11:
                image.set_pixel(tile_x, tile_y, MOSS)
                image.set_pixel(tile_x + 1, tile_y - 1, GROUND_LIGHT)
    stones = ((35, 61), (112, 54), (205, 68), (288, 58), (374, 66), (457, 56), (548, 69))
    for stone_x, stone_y in stones:
        image.rect(stone_x, stone_y, 5, 3, STONE_DARK)
        image.rect(stone_x + 1, stone_y, 3, 1, STONE)
        image.set_pixel(stone_x + 1, stone_y + 1, STONE_LIGHT)
    grass_tufts = (
        (19, 18),
        (74, 30),
        (146, 14),
        (263, 29),
        (351, 17),
        (431, 35),
        (527, 21),
        (579, 33),
    )
    for grass_x, grass_y in grass_tufts:
        image.line((grass_x, grass_y + 2), (grass_x - 1, grass_y), MOSS)
        image.line((grass_x + 1, grass_y + 2), (grass_x + 2, grass_y), GROUND_LIGHT)
    return image.upscale(SCALE)


def comparison_preview() -> Canvas:
    """Compose the scale row for local visual review, with the hero on its marker."""

    preview = Canvas(2560, 520, (15, 24, 28, 255))
    ground_top = 120
    baseline_y = ground_top + 240
    preview.blit(scale_ground(), 80, ground_top)
    preview.rect(80, baseline_y - 2, 2400, 4, GOLD_DARK)
    anchored_assets = (
        (small_enemy(), 80 + 180),
        (hero_idle_down(), 80 + 520),
        (door_entrance(), 80 + 840),
        (house_wall(), 80 + 1250),
        (large_enemy(), 80 + 1730),
        (tree(), 80 + 2180),
    )
    for asset, center_x in anchored_assets:
        preview.blit(asset, center_x - asset.width // 2, baseline_y - asset.height)
    return preview


AssetFactory = Callable[[], Canvas]
ASSETS: dict[str, tuple[AssetFactory, int]] = {
    "hero_idle_down.png": (hero_idle_down, 80),
    "small_enemy.png": (small_enemy, 56),
    "door_entrance.png": (door_entrance, 112),
    "house_wall.png": (house_wall, 144),
    "large_enemy.png": (large_enemy, 128),
    "tree.png": (tree, 192),
    "scale_ground.png": (scale_ground, 320),
}


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--check",
        action="store_true",
        help="verify committed files without modifying them",
    )
    parser.add_argument(
        "--preview-output",
        type=Path,
        help="write a local scale-row preview to the selected path",
    )
    arguments = parser.parse_args()
    mismatches: list[str] = []
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    for filename, (factory, expected_visible_height) in ASSETS.items():
        image = factory()
        bounds = image.alpha_bounds()
        if bounds is None or bounds[1] != 0 or bounds[3] + 1 != expected_visible_height:
            raise RuntimeError(
                f"{filename}: visible alpha height must be {expected_visible_height}, got {bounds}"
            )
        output = image.png_bytes()
        destination = OUTPUT_DIR / filename
        if arguments.check:
            if not destination.exists() or destination.read_bytes() != output:
                mismatches.append(filename)
            continue
        destination.write_bytes(output)
        print(f"generated {destination.relative_to(Path.cwd())}")

    if mismatches:
        print("outdated generated assets: " + ", ".join(mismatches), file=sys.stderr)
        return 1
    if arguments.check:
        print(f"verified {len(ASSETS)} deterministic Visual Lab assets")
    if arguments.preview_output is not None:
        arguments.preview_output.write_bytes(comparison_preview().png_bytes())
        print(f"generated visual review at {arguments.preview_output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
