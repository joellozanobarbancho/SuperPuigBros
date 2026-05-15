import random
from PIL import Image

dst = r"C:\Users\jloza\Documents\SuperPuigBros\assets"

# ── ground.png  64×32 ────────────────────────────────────────────────────────
rng = random.Random(42)
img = Image.new("RGBA", (64, 32))
px = img.load()

for y in range(32):
    for x in range(64):
        if y in (0, 1):
            c = (0x5e, 0xc4, 0x3a, 255)        # bright grass tips
        elif 2 <= y <= 9:
            c = (0x3d, 0x9e, 0x28, 255)        # solid grass green
        elif y == 10:
            c = (0x2a, 0x7a, 0x1a, 255)        # dark transition
        elif y in (11, 12):
            c = (0x6b, 0x5a, 0x2a, 255)        # brown-green mix
        else:
            # rows 13-31: brown dirt with scattered darker pixels (1 in 8)
            if rng.randint(0, 7) == 0:
                c = (0x5a, 0x3d, 0x1e, 255)    # darker pixel
            else:
                c = (0x7a, 0x52, 0x30, 255)    # brown dirt
        px[x, y] = c

ground_path = dst + r"\ground.png"
img.save(ground_path)

# ── platform.png  64×16 ──────────────────────────────────────────────────────
rng2 = random.Random(7)
img2 = Image.new("RGBA", (64, 16))
px2 = img2.load()

for y in range(16):
    for x in range(64):
        if y == 0:
            c = (0xc8, 0xc8, 0xd4, 255)        # highlight
        elif y in (1, 2):
            c = (0xa0, 0xa0, 0xb4, 255)        # light stone
        elif 3 <= y <= 13:
            # mid stone with occasional darker pixels (1 in 10)
            if rng2.randint(0, 9) == 0:
                c = (0x60, 0x60, 0x70, 255)    # darker pixel
            else:
                c = (0x78, 0x78, 0x90, 255)    # mid stone
        else:
            c = (0x50, 0x50, 0x60, 255)        # shadow (rows 14-15)
        px2[x, y] = c

platform_path = dst + r"\platform.png"
img2.save(platform_path)

import os
g_size = os.path.getsize(ground_path)
p_size = os.path.getsize(platform_path)
print(f"ground.png   -> {ground_path}  ({g_size} bytes)")
print(f"platform.png -> {platform_path}  ({p_size} bytes)")
print("Done.")
