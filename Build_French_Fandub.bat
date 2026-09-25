@echo off
setlocal
cd /d "%~dp0"

echo ================================================
echo KH2FM French Final Mix Voices - Builder
echo ================================================
echo.
echo Put these two original patch files in this folder:
echo   FANDUB[1_0].kh2patch
echo   1. Translation.kh2patch
echo.
echo The builder will create:
echo   FINAL_MIX_FRENCH_VOICES_HYBRID.kh2patch
echo.
pause

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0build_french_fandub.ps1"

echo.
pause
