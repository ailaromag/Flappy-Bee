# Flappy-Bee

A Flappy Bird-inspired game implemented in **Motorola 68000 assembly** (Easy68k) for the **Computer Architecture 2** course at the University of the Balearic Islands.

The player controls a bee that must dodge trees, avoid enemies, and collect honey balls to score points. The game ends when the bee dies or reaches level 10.

---

## Gameplay

The bee moves vertically using the **spacebar**: press to go up, release to fall. Honey balls floating on screen can be collected by **clicking on them** with the mouse.

### Scoring & Lives

| Event | Points | Lives |
|---|---|---|
| Starting values | 0 | 3 |
| Spider collision | -200 | -1 |
| Column collision | Death | Death |
| Column cleared | +25 | — |
| Honey ball | +100 | — |

A spider collision is fatal if fewer than 200 points have been accumulated.

---

## Implementation

### Image Rendering

Implemented in `BITMAP.X68`. Images are stored as arrays of 32-bit color values in the format required by Easy68k:

```
DC.L $000000,$000000,...
```

A Java utility (`BitmapConverter2.java`) was developed in NetBeans to convert bitmap images into this format (8 longs per row). The `MAPPLOT` routine iterates over the array and draws each pixel using TRAP #15 calls. Used for the start screen, in-game cloud, win screen, and game over screen.

### Mouse Input

Implemented in `MSEINIT` and `MSEUPD` routines:
- `MSEINIT` initializes the mouse IRQ, enabling level 1 interrupts for movement and clicks. Coordinates are stored in `MSECOORD` and button state in `MSEVAL`.
- `MSEUPD` polls for mouse movement and updates coordinates accordingly.

---

## Build & Run

1. Open the main `.X68` file in the Easy68k editor
2. Assemble and run
3. Make sure exceptions are enabled for I/O window display

---

## Author

**Aila Romaguera Mezquida** - University of the Balearic Islands
