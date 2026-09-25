# Testing guide

This project is still experimental. The current build has only been confirmed on one Final Mix-exclusive cutscene.

## Recommended test setup

- Clean Japanese Kingdom Hearts II Final Mix ISO
- Serial: SLPM-66675
- Clean ISO MD5: `1BD351E1DF9FC5D783D8318010D17F03`
- KH2FM Toolkit 2.9.5.0
- Recent PCSX2 build

## Basic regression test

After patching:

1. Boot the game normally.
2. Start a New Game.
3. Load an existing compatible Memory Card save.
4. Confirm there is no black screen or PCSX2 VIF assertion.
5. Reach a Final Mix-exclusive cutscene.
6. Confirm the previously silent scene has French dialogue.
7. Note any lip-sync issue, wrong speaker, missing line, or crash.

## Please report

- Cutscene / point in story
- Result: OK / silent / crash / wrong audio
- PCSX2 version
- Patch combination
- Clean ISO hash
- Save State used? yes/no
- Memory Card load used? yes/no

## Known investigation result

With the legacy French FANDUB patch structure, testing found:

- 72 newly-added French audio entries: OK
- 73 newly-added French audio entries: crash
- The individual 73rd entry by itself: OK

This is why the current patch uses the working entry structure from CrazyCatz00's patch instead of the legacy FANDUB layout.
