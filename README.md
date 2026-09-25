# KH2FM French Final Mix Voices Fix (PS2)

> **FR — Correctif expérimental pour le FANDUB français de Kingdom Hearts II Final Mix (PS2 / SLPM-66675).**
>
> Si le vieux `FANDUB[1_0].kh2patch` te donne un **écran noir**, un **crash PCSX2**, une erreur **VIF / ReadFIFO_VIF1**, ou si les **scènes exclusives à Final Mix restent muettes**, ce dépôt contient le correctif qui a résolu ce problème pendant nos tests.
>
> **Testé pour l'instant sur une seule scène Final Mix.** Nouvelle partie, chargement Memory Card et cette scène ont fonctionné avec les voix françaises.

Experimental community patch for **Kingdom Hearts II Final Mix (PS2, SLPM-66675)**.

**Search terms / mots-clés:** KH2FM French patch, KH2 Final Mix French FANDUB, écran noir, black screen, PCSX2 crash, ReadFIFO_VIF1, VIF FIFO READ, SLPM-66675, Final Mix cutscene no voice, scènes Final Mix sans voix.

## Solution rapide / Quick fix

Pour la plupart des utilisateurs :

1. Pars d'une ISO propre de **Kingdom Hearts II Final Mix — SLPM-66675**.
2. Applique les patchs FR classiques que tu utilises déjà.
3. **N'applique pas** l'ancien `FANDUB[1_0].kh2patch`.
4. Applique à la place :
   `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`
5. Lance le jeu normalement et teste avec une vraie Memory Card PCSX2, pas seulement un save state.

ISO propre utilisée pendant les tests — MD5 :
`1BD351E1DF9FC5D783D8318010D17F03`

Patch expérimental — MD5 :
`73F43F66828453456946D9E9CFCE3F72`

## Easiest option for most users

If you just want the fix, use the prebuilt experimental patch already included in this repository:

`FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`

If you prefer to rebuild it yourself from the two original community patches, Windows users can use the included one-click builder:

1. Download this repository.
2. Put these two original files next to the builder:
   - `FANDUB[1_0].kh2patch`
   - `1. Translation.kh2patch`
3. Double-click `Build_French_Fandub.bat`.
4. The script verifies the known French FANDUB version, rebuilds the 165 matched entries, and creates:
   `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`
5. A successful build should have MD5:
   `73F43F66828453456946D9E9CFCE3F72`

The builder uses only Windows PowerShell and does not require Python.

## What this is

This project is a compatibility-oriented rebuild of the old French **FANDUB** patch for the extra **Final Mix-only cutscenes**.

The original French FANDUB worked by adding many new voice files. During testing, that old patch consistently caused crashes / black screens on a clean SLPM-66675 image with the old KH2FM Toolkit.

A working English community patch by **CrazyCatz00** did not show the same problem. This experimental hybrid patch therefore keeps the **working destination/entry structure from CrazyCatz00's translation patch** while substituting the corresponding **French FANDUB audio payloads**.

The resulting file is:

`FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`

It currently contains **165 matched French Final Mix voice entries**. One French FANDUB entry had no direct equivalent in the CrazyCatz00 patch and is intentionally omitted for now.

## Test status — important

**Experimental / v0.1 quality.**

So far, the patch has only been manually confirmed on **one Final Mix-exclusive cutscene**.

Confirmed by the tester:
- New Game starts correctly.
- Memory Card loading works.
- The tested Final Mix cutscene plays with **French voices** instead of being silent.

The rest of the Final Mix-exclusive scenes have **not yet been fully tested**. Please report any missing voice, crash, desync, or wrong line.

This was originally investigated simply to help a friend who was having problems with the old FANDUB patch.

## Required base

Use a clean Japanese PS2 image of:

- **Kingdom Hearts II Final Mix**
- Serial: **SLPM-66675**
- Known clean ISO MD5 used during testing:  
  `1BD351E1DF9FC5D783D8318010D17F03`

No game ISO is provided here.

## Intended French setup

This hybrid patch is intended to complement the classic French KH2FM patches:

- `TEXTFR[1_3].kh2patch`
- `TEXTURES[1_2].kh2patch`
- `VOICES1[2_0].kh2patch`
- `VOICES2[1_0].kh2patch`

The old `FANDUB[1_0].kh2patch` should **not** be applied alongside this hybrid patch.

### Suggested workflow

1. Start from a clean SLPM-66675 ISO.
2. Apply the four classic French patches above.
3. Apply `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`.
4. Test with a normal boot and Memory Card save.
5. Avoid relying on an old PCSX2 save state when validating a newly patched ISO.

The project was tested with the classic **KH2FM Toolkit 2.9.5.0**.

## Why this exists

During debugging, a reproducible pattern appeared with the old French FANDUB:

- 72 newly-added audio entries: game booted correctly.
- 73 newly-added audio entries: crash / PCSX2 VIF assertion.
- The individual 73rd audio file worked when added by itself.

This indicated that the issue was not simply one broken WAV. The working CrazyCatz00 patch demonstrated that the Final Mix voice replacements could be structured differently without the same failure.

The hybrid patch was built by matching destination hashes between:
- the old French FANDUB patch, and
- CrazyCatz00's working English translation patch,

then retaining the working CrazyCatz00 entry metadata/order while inserting the French FANDUB audio data.

## Checksums

For the current experimental patch:

- MD5: `73F43F66828453456946D9E9CFCE3F72`
- SHA-256: `B9C1066EFE598C2881E6C76B1E2AAB7F9644FB6BA1F27AA721F49F783BA2AFD6`

## Credits

This fix would not exist without the work of the original community authors.

### Original French FANDUB / tooling
**GovanifY**
- Original KH2FM French patch project
- KH2FM Toolkit
- Original French FANDUB patch

### Original French FANDUB voice cast
Credits preserved from the original FANDUB patch:

- 4sancou — Ansem, Demyx
- Gael42 — Axel, Riku
- Kasaano — Sora, Xaldin
- Miha — Naminé
- Pidaanma — DiZ, Saïx, Vexen
- ThomasKHII — Luxord, Xemnas, Zexion
- UnbirthXXI — Xigbar
- Watamano — Roxas

### Working Final Mix voice-entry structure
**CrazyCatz00**
- English KH2FM PS2 translation patch
- Final Mix English voices / lip-sync work used as the structural compatibility reference for this rebuild

Please support and credit the original patch authors. This repository does not claim ownership of their original work. See `THIRD_PARTY_NOTICES.md` for licensing/attribution notes.

### Original project links

- GovanifY KH2FM French project: https://govanify.com/KH/KH2FM_FR.html
- KH2FM Toolkit source: https://github.com/GovanifY/KH2FM_Toolkit
- CrazyCatz00 KH2 PS2 patches: https://crazycatz00.x10host.com/kh/kh2-patches.ps2/

## Reporting issues

When reporting a problem, include:

- Which Final Mix cutscene
- Whether New Game works
- Whether Memory Card loading works
- PCSX2 version
- Which other `.kh2patch` files were applied
- Whether the ISO started from the clean MD5 above

## Legal / distribution note

This repository does **not** provide a Kingdom Hearts II Final Mix ISO, BIOS, or other full game image.

You are expected to use your own legally obtained game media and BIOS. This is an unofficial fan/community project and is not affiliated with Square Enix, Disney, Sony, or the original patch authors.
