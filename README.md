# Flappy Bird (MATLAB GUI Edition)

A custom Flappy Bird clone built in MATLAB using GUIDE (GUI Layout Editor). Pick a character, dodge wave-animated pipes, and try to score as high as possible — complete with custom sound effects for each character.

## Features

- **Multiple playable characters** — choose from 6 characters, each with a unique sprite, intro jingle, flap sound, and death sound.
- **Three difficulty levels** — Easy, Medium, and Hard, each changing how much lift you get per flap.
- **Physics-based flight** — gravity continuously pulls the bird down; flapping gives it an upward boost.
- **Procedurally animated pipes** — instead of static rectangles, pipe gaps are generated using a 1D wave equation (solved via the Lax/FTCS finite-difference method), giving the pipes a smooth, organic "ripple" motion as new gaps spawn.
- **Progressive difficulty** — the game speeds up automatically as your score climbs.
- **Live scoreboard** — score increments as you pass through pipes.
- **Restart on death** — a death sound plays and an "again" button lets you immediately retry.

## Requirements

- MATLAB (developed against GUIDE, so MATLAB R2018a or earlier is the safest match — GUIDE is deprecated in newer releases but `.fig`/`.m` GUIDE apps still run in recent versions).
- Image Processing Toolbox (for `imread`) — usually built into base MATLAB.
- Audio support for `audioread` and `audioplayer` (standard in MATLAB, but requires a working sound device).

## Required Files

This `.m` file is the controller for a GUIDE app, so it expects a matching `flappybirdgui.fig` file (the layout) in the same folder, plus these asset files:

**Images**
| File | Used for |
|---|---|
| `PIPE.png` | Pipe sprite (flipped for top/bottom variants) |
| `BIRD3.png` | Character 1 |
| `Ross.png` | Character 2 |
| `Sam.png` | Character 3 |
| `Lindquist.png` | Character 4 |
| `Stein.png` | Character 5 |
| `Abel.png` | Character 6 |

**Sounds** (start jingle / flap sound / death sound, per character)
| Character | Start | Flap | Death |
|---|---|---|---|
| 1 | `windows-xp-startup.mp3` | `sfx_wing.mp3` | `error.mp3` |
| 2 | `virtually.mp3` | `Coffee.mp3` | `rossbye.mp3` |
| 3 | `clash-royale-hog-rider.mp3` | `vineboom.mp3` | `emotional-damage-meme.mp3` |
| 4 | `dance-moves.mp3` | `fortnite-gun-shot-sound.mp3` | `knocked-loud.mp3` |
| 5 | `billnyeopener.mp3` | `bill.mp3` | `metal-pipe-clang.mp3` |
| 6 | `okay.mp3` | `pufferfish.mp3` | `abeldeath.mp3` |

All image and audio files should sit in the same directory as `flappybirdgui.m` and `flappybirdgui.fig`.

## How to Run

1. Place `flappybirdgui.m`, `flappybirdgui.fig`, and all asset files (images + sounds) in the same folder.
2. Open MATLAB and `cd` into that folder (or add it to your path).
3. Run:
   ```matlab
   flappybirdgui
   ```
4. In the GUI:
   - Select a character from the dropdown (`charselecter`).
   - Select a difficulty (`easy` / `medium` / hard, via radio buttons).
   - Click **Start**.
   - Click/press the **Flap** button to keep the bird airborne.
   - On death, click **Again** to restart instantly with the same character/difficulty.

## How It Works (Code Overview)

- **`flappybirdgui_OpeningFcn` / `flappybirdgui_OutputFcn`** — standard GUIDE boilerplate that initializes the figure.
- **`start_Callback`** — the main game engine:
  - Loads the selected character's image and three sound clips.
  - Sets up a 1D spatial grid (`x`) and initializes four wave arrays (`a`, `b`, `d`, `e`) representing two pairs of pipes (top/bottom).
  - Each frame, advances the bird's position (`y`) using simple gravity (`v = v + -29.4*tau`) and evolves the pipe waves using the **Lax method** for the 1D wave equation, which produces smooth, wave-like pipe shapes instead of hard-edged rectangles.
  - Checks collisions against the wave height at a fixed grid index (representing the bird's x-position).
  - Every 40 frames, spawns a new randomized pipe gap (`amp` value chosen randomly) on whichever pipe pair is currently off-screen, alternating between the two pairs (`j` flag) to create continuous, evenly spaced obstacles.
  - Tracks elapsed frames (`t`) to increment the score and gradually reduce `pause(speed)` every 5 points scored, making the game progressively faster.
  - On collision, plays the death sound and reveals the **Again** / character-select controls.
- **`flap_Callback`** — plays the flap sound and adjusts vertical velocity (`v`) based on the selected difficulty:
  - **Easy**: gentle, cumulative lift if already moving upward, otherwise a fixed small boost.
  - **Medium**: fixed moderate boost.
  - **Hard**: fixed large boost.
- **`again_Callback`** — resets the score and re-invokes `start_Callback` to play again.
- **`charselecter_Callback` / `charselecter_CreateFcn`** — handle the character dropdown menu (selection logic and default Windows styling).

## Known Limitations

- Character and sound files are not bundled in this README's source — make sure they're present and named exactly as listed above, or `imread`/`audioread` will throw file-not-found errors.
- Built with GUIDE, which Apple deprecated in MATLAB R2025a+; if you're on a very recent MATLAB release, you may need to use App Designer or run an older MATLAB version to open the `.fig` layout.
- Game logic and rendering both run in the same `while(1)` loop with `drawnow`/`pause`, so performance depends on your machine's rendering speed.

## Credits

Built as a personal MATLAB project — pipe animation physics powered by a finite-difference wave equation solver rather than static graphics, as a fun way to combine a numerical methods exercise with a classic arcade game.
The bird and pipe images were drawn by my good friend, Nick Zander.
