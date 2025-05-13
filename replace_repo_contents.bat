@echo off
setlocal enabledelayedexpansion

REM === Konfigurasi ===
set GIT_REPO_URL=https://github.com/BlueCorn23/assets-googel.git
set REPO_PATH=C:\Repos\assets-googel
set SOURCE_PATH=C:\Users\0x23AY97\Downloads\Compressed\compressed
set COMMIT_MSG=replace assets

REM === Cek apakah git tersedia ===
where git >nul 2>&1
if errorlevel 1 (
    echo ERROR: Git tidak ditemukan di PATH. Pastikan Git sudah diinstall.
    pause
    exit /b
)

REM === Jika folder REPO_PATH belum ada, clone repo
if not exist "%REPO_PATH%\.git" (
    echo Folder repo belum ada. Melakukan git clone...
    git clone "%GIT_REPO_URL%" "%REPO_PATH%"
    if errorlevel 1 (
        echo ERROR: Gagal clone repo.
        pause
        exit /b
    )
) else (
    echo Repo sudah ada di: %REPO_PATH%
)

REM === Validasi folder sumber ===
if not exist "%SOURCE_PATH%" (
    echo ERROR: Folder sumber tidak ditemukan: %SOURCE_PATH%
    pause
    exit /b
)

REM === Navigasi ke folder repo
cd /d "%REPO_PATH%"

REM === Hapus semua isi repo kecuali .git
echo Menghapus isi repo (kecuali .git)...
for /d %%d in ("%REPO_PATH%\*") do (
    if /I not "%%~nd"==".git" (
        echo Menghapus folder: %%d
        rmdir /s /q "%%d"
    )
)
for %%f in ("%REPO_PATH%\*") do (
    if /I not "%%~nxf"==".git" (
        echo Menghapus file: %%f
        del /f /q "%%f"
    )
)

REM === Salin file dari SOURCE_PATH ke REPO_PATH
echo Menyalin file dari %SOURCE_PATH% ke %REPO_PATH%...
xcopy "%SOURCE_PATH%\*" "%REPO_PATH%\" /E /H /C /I /Y >nul

REM === Git add, commit, dan push
echo Menambahkan perubahan ke git...
git add .

echo Commit perubahan...
git commit -m "%COMMIT_MSG%"

echo Push ke remote repo...
git push

echo.
echo === SELESAI ===
echo Repo berhasil diperbarui dan dipush ke GitHub.
pause
endlocal
