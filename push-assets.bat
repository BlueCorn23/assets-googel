@echo off
cd /d D:\assets-googel

echo.
echo Menyiapkan push ke GitHub...

REM Init repo hanya jika belum ada .git
IF NOT EXIST .git (
    git init
)

REM Tambah remote hanya jika belum ada
git remote get-url origin >nul 2>&1
IF ERRORLEVEL 1 (
    git remote add origin https://github.com/BlueCorn23/assets-googel.git
)

git checkout -B main

git add .
git commit -m "Update compressed assets"
git push -f origin main

echo.
echo ✅ Semua file berhasil dipush ke GitHub!
pause
