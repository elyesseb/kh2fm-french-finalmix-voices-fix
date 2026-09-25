# KH2FM French Final Mix Voices Fix (PS2)

[English version / Version anglaise](README_EN.md)

Correctif expérimental pour **Kingdom Hearts II Final Mix sur PS2 (SLPM-66675)**, destiné aux utilisateurs du patch français qui rencontrent un écran noir, un crash PCSX2 ou des scènes exclusives à Final Mix sans voix.

> **Statut : expérimental**
>
> Le correctif a été testé avec succès sur **une seule scène exclusive à Final Mix**.
> Nouvelle partie : OK.  
> Chargement Memory Card : OK.  
> Scène testée : voix françaises OK.
>
> Le reste du jeu n'a pas encore été vérifié scène par scène.

---

## Tu as ce problème ?

Ce dépôt peut t'aider si tu utilises l'ancien FANDUB français et que tu rencontres un ou plusieurs de ces symptômes :

- écran noir au lancement d'une nouvelle partie ;
- écran noir au chargement d'une sauvegarde ;
- crash PCSX2 ;
- erreur du type `ReadFIFO_VIF1` / `VIF FIFO READ` ;
- scènes exclusives à Final Mix avec sous-titres français mais **sans voix** ;
- l'ancien `FANDUB[1_0].kh2patch` fait planter une ISO qui fonctionne sans lui.

Le problème a été reproduit sur **Kingdom Hearts II Final Mix — SLPM-66675**.

---

## Solution rapide

Si tu veux juste jouer sans lire toute l'explication :

1. Pars d'une ISO propre de **Kingdom Hearts II Final Mix — SLPM-66675**.
2. Applique les patchs français classiques que tu utilises habituellement :
   - `TEXTFR[1_3].kh2patch`
   - `TEXTURES[1_2].kh2patch`
   - `VOICES1[2_0].kh2patch`
   - `VOICES2[1_0].kh2patch`
3. **N'applique pas** l'ancien `FANDUB[1_0].kh2patch`.
4. Applique à la place :
   - `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`
5. Lance le jeu normalement dans PCSX2.
6. Teste de préférence avec une vraie Memory Card PCSX2, pas uniquement avec un ancien save state.

### ISO propre utilisée pour les tests

- Jeu : Kingdom Hearts II Final Mix
- Région : Japon
- Serial : `SLPM-66675`
- MD5 : `1BD351E1DF9FC5D783D8318010D17F03`

### Correctif actuel

- Fichier : `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`
- MD5 : `73F43F66828453456946D9E9CFCE3F72`

---

## Pourquoi ce correctif existe

L'ancien FANDUB français ajoute un grand nombre de nouveaux fichiers audio à l'ISO.

Pendant le diagnostic, le comportement suivant a été reproduit :

- 72 nouveaux fichiers audio : le jeu démarre ;
- 73 nouveaux fichiers audio : crash / écran noir ;
- le 73e fichier audio fonctionne pourtant très bien lorsqu'il est ajouté tout seul.

Le problème ne venait donc pas simplement d'un WAV corrompu.

En parallèle, le patch anglais de **CrazyCatz00** contenant les voix des scènes Final Mix fonctionnait correctement sur la même base.

Le correctif de ce dépôt utilise donc :

- la **structure d'entrées fonctionnelle** du patch CrazyCatz00 ;
- les **voix françaises** du FANDUB original.

165 entrées audio françaises ont pu être associées directement.  
Une entrée du FANDUB français n'avait pas d'équivalent direct dans le patch CrazyCatz00 et a volontairement été laissée de côté pour cette version expérimentale.

---

## Compatibilité

Testé avec :

- Kingdom Hearts II Final Mix japonais — `SLPM-66675`
- ISO propre MD5 `1BD351E1DF9FC5D783D8318010D17F03`
- KH2FM Toolkit `2.9.5.0`
- PCSX2

Le correctif est prévu pour compléter les patchs français classiques listés plus haut.

### À ne pas faire

N'applique pas à la fois :

- `FANDUB[1_0].kh2patch`
- et `FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`

Utilise **le correctif hybride à la place de l'ancien FANDUB**.

---

## Si tu préfères reconstruire le patch toi-même

Le dépôt contient aussi un builder Windows.

Il permet de reconstruire le correctif à partir des deux patchs originaux sans avoir besoin de Python.

### Fichiers nécessaires

Place dans le même dossier :

- `FANDUB[1_0].kh2patch`
- `1. Translation.kh2patch`
- `Build_French_Fandub.bat`
- `build_french_fandub.ps1`

Puis double-clique sur :

`Build_French_Fandub.bat`

Le script doit produire :

`FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch`

MD5 attendu :

`73F43F66828453456946D9E9CFCE3F72`

Le builder vérifie automatiquement que les fichiers utilisés correspondent à la version attendue.

---

## Comment signaler un problème

Si une scène plante ou reste muette, ouvre une issue GitHub et indique si possible :

- le monde / la scène concernée ;
- si Nouvelle partie fonctionne ;
- si le chargement Memory Card fonctionne ;
- ta version de PCSX2 ;
- les autres fichiers `.kh2patch` appliqués ;
- le MD5 de ton ISO de départ ;
- si tu as utilisé un save state ou une Memory Card normale.

Le fichier `TESTING.md` contient une checklist plus détaillée.

---

## Crédits

Ce correctif repose sur le travail de la communauté KH2FM.

### GovanifY

- patch français KH2FM original ;
- KH2FM Toolkit ;
- FANDUB français original.

Projet français :  
https://govanify.com/KH/KH2FM_FR.html

Toolkit :  
https://github.com/GovanifY/KH2FM_Toolkit

### CrazyCatz00

Le patch anglais KH2FM de CrazyCatz00 a servi de référence structurelle pour les entrées de voix Final Mix.

https://crazycatz00.x10host.com/kh/kh2-patches.ps2/

### Doubleurs du FANDUB français

Crédits conservés depuis le projet original :

- 4sancou — Ansem, Demyx
- Gael42 — Axel, Riku
- Kasaano — Sora, Xaldin
- Miha — Naminé
- Pidaanma — DiZ, Saïx, Vexen
- ThomasKHII — Luxord, Xemnas, Zexion
- UnbirthXXI — Xigbar
- Watamano — Roxas

Voir également `THIRD_PARTY_NOTICES.md`.

---

## À propos de ce dépôt

Ce correctif a été créé à l'origine simplement pour aider un ami qui rencontrait le même problème avec le FANDUB français.

Le dépôt est publié pour éviter que d'autres personnes perdent des heures à diagnostiquer le même crash.

Il ne contient pas d'ISO de Kingdom Hearts II Final Mix, de BIOS PS2 ou d'image complète du jeu.

Projet non officiel, sans affiliation avec Square Enix, Disney, Sony, GovanifY ou CrazyCatz00.

