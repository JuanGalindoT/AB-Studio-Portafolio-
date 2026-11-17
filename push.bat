@echo off
setlocal
cd /d "%~dp0"
title AB Studio - Subir portafolio a JuanGalindoT
set "REPO=https://github.com/JuanGalindoT/AB-Studio-Portafolio-.git"
where git >nul 2>&1
if errorlevel 1 (
  echo ERROR: Git no esta disponible desde esta computadora.
  echo Instala Git para Windows desde https://git-scm.com/downloads/win
  pause
  exit /b 1
)
if not exist ".git" git init
if errorlevel 1 goto error
git branch -M main
if errorlevel 1 goto error
git remote get-url origin >nul 2>&1
if errorlevel 1 (
  git remote add origin "%REPO%"
) else (
  git remote set-url origin "%REPO%"
)
if errorlevel 1 goto error

git add -A
if errorlevel 1 goto error
git diff --cached --quiet
if errorlevel 1 (
  git commit -m "Subir portafolio AB Studio"
  if errorlevel 1 (
    echo ERROR: No fue posible crear el commit.
    echo Configura tu nombre y email de Git con git config --global.
    goto error
  )
)
echo.
echo Subiendo archivos a %REPO%
echo GitHub puede pedirte iniciar sesion con la cuenta JuanGalindoT.
git push -u origin main
if errorlevel 1 goto error
echo.
echo EXITO: Subida finalizada.
pause
exit /b 0
:error
echo.
echo ERROR: No se pudo completar la subida. Revisa el mensaje anterior.
pause
exit /b 1
