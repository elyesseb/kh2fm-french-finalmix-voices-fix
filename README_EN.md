# KH2FM French Final Mix Voices Fix (PS2)

[Version française / French version](README.md)

Experimental compatibility fix for **Kingdom Hearts II Final Mix on PS2 (SLPM-66675)**, intended for users of the French patch who encounter a black screen, PCSX2 crash, or Final Mix-exclusive cutscenes with no voice acting.

> **Status: experimental**
>
> The fix has currently been tested successfully on **one Final Mix-exclusive cutscene only**.
> New Game: OK.  
> Memory Card loading: OK.  
> Tested cutscene: French voices OK.
>
> The rest of the game has not yet been verified scene by scene.

---

## Are you experiencing this issue?

This repository may help if you use the old French FANDUB and encounter one or more of these symptoms:

- black screen when starting a New Game;
- black screen when loading a save;
- PCSX2 crash;
- errors such as `ReadFIFO_VIF1` / `VIF FIFO READ`;
- Final Mix-exclusive cutscenes with French subtitles but **no voices**;
- the old `FANDUB[1_0].kh2patch` causes an ISO to crash even though it works without that patch.

The issue was reproduced on **Kingdom Hearts II Final Mix — SLPM-66675**.

---

## Quick fix

If you just want to play without reading the full explanation:

1. Start from a clean **Kingdom Hearts II Final Mix — SLPM-66675** ISO.
2. Apply the classic French patches you normally use:
   - `TEXTFR[1_3].kh2patch`
   - `TEXTURES[1_2].kh2patch`
   - `VOICES1[2_0].kh2patch`
   - `VOICES2[1_0].kh2patch`
3. **Do not apply** the old `FANDUB[1_0].kh2patch`.
4. Apply this instead:
   - `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`
5. Boot the game normally in PCSX2.
6. Prefer testing with a real PCSX2 Memory Card, not only an old save state.

### Clean ISO used for testing

- Game: Kingdom Hearts II Final Mix
- Region: Japan
- Serial: `SLPM-66675`
- MD5: `1BD351E1DF9FC5D783D8318010D17F03`

### Current fix

- File: `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`
- MD5: `73F43F66828453456946D9E9CFCE3F72`

---

## Why this fix exists

The old French FANDUB adds a large number of new audio files to the ISO.

During troubleshooting, the following behavior was reproduced:

- 72 newly-added audio files: game boots;
- 73 newly-added audio files: crash / black screen;
- the 73rd audio file still works correctly when added by itself.

So the problem was not simply a corrupted WAV file.

At the same time, **CrazyCatz00's** English patch containing Final Mix scene voices worked correctly on the same base.

This repository's fix therefore uses:

- the **working entry structure** from CrazyCatz00's patch;
- the **French voices** from the original FANDUB.

165 French audio entries could be matched directly.  
One French FANDUB entry had no direct equivalent in the CrazyCatz00 patch and was intentionally left out of this experimental version.

---

## Compatibility

Tested with:

- Japanese Kingdom Hearts II Final Mix — `SLPM-66675`
- Clean ISO MD5 `1BD351E1DF9FC5D783D8318010D17F03`
- KH2FM Toolkit `2.9.5.0`
- PCSX2

The fix is intended to complement the classic French patches listed above.

### Do not do this

Do not apply both:

- `FANDUB[1_0].kh2patch`
- and `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`

Use **the hybrid fix instead of the old FANDUB**.

---

## Rebuilding the patch yourself

The repository also contains a Windows builder.

It can recreate the fix from the two original community patches without requiring Python.

### Required files

Place these files in the same folder:

- `FANDUB[1_0].kh2patch`
- `1. Translation.kh2patch`
- `Build_French_Fandub.bat`
- `build_french_fandub.ps1`

Then double-click:

`Build_French_Fandub.bat`

The script should create:

`FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`

Expected MD5:

`73F43F66828453456946D9E9CFCE3F72`

The builder automatically verifies that the source files match the expected version.

---

## Reporting an issue

If a scene crashes or remains silent, open a GitHub issue and include, if possible:

- the world / cutscene involved;
- whether New Game works;
- whether Memory Card loading works;
- your PCSX2 version;
- the other `.kh2patch` files you applied;
- the MD5 of your starting ISO;
- whether you used a save state or a normal Memory Card.

See `TESTING.md` for a more detailed checklist.

---

## Credits

This fix builds on the work of the KH2FM community.

### GovanifY

- original KH2FM French patch;
- KH2FM Toolkit;
- original French FANDUB.

French project:  
https://govanify.com/KH/KH2FM_FR.html

Toolkit:  
https://github.com/GovanifY/KH2FM_Toolkit

### CrazyCatz00

CrazyCatz00's English KH2FM patch was used as the structural reference for the Final Mix voice entries.

https://crazycatz00.x10host.com/kh/kh2-patches.ps2/

### French FANDUB voice cast

Credits preserved from the original project:

- 4sancou — Ansem, Demyx
- Gael42 — Axel, Riku
- Kasaano — Sora, Xaldin
- Miha — Naminé
- Pidaanma — DiZ, Saïx, Vexen
- ThomasKHII — Luxord, Xemnas, Zexion
- UnbirthXXI — Xigbar
- Watamano — Roxas

See also `THIRD_PARTY_NOTICES.md`.

---

## About this repository

This fix was originally created simply to help a friend who was having the same problem with the French FANDUB.

The repository is published so that other users do not have to spend hours diagnosing the same crash.

It does not provide a Kingdom Hearts II Final Mix ISO, PS2 BIOS, or full game image.

Unofficial fan/community project. Not affiliated with Square Enix, Disney, Sony, GovanifY, or CrazyCatz00.

---

Search terms: KH2FM French patch, KH2 Final Mix French FANDUB, PCSX2 black screen, ReadFIFO_VIF1, VIF FIFO READ, SLPM-66675, Final Mix cutscene no voice.
