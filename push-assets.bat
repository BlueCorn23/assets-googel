@echo off
cd /d D:\assets-googel

echo.
echo Menyiapkan push ke GitHub...
git init
git remote remove origin
git remote add origin https://github.com/BlueCorn23/assets-googel.git
git checkout -B main

git add .
git commit -m "Update compressed assets"
git push -f origin main

echo.
echo ✅ Semua file berhasil dipush ke GitHub!
pause
