@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo        HE THONG DAY CODE LEN GITHUB TU DONG
echo        Repository: https://github.com/hoangmme/nhimme
echo ========================================================
echo.

:: Nap thu vien Git va Git Credential Manager vao PATH tam thoi cua phien lam viec nay
if exist "%LOCALAPPDATA%\Programs\MinGit\cmd" (
    set "PATH=%LOCALAPPDATA%\Programs\MinGit\cmd;%LOCALAPPDATA%\Programs\MinGit\mingw64\bin;%PATH%"
)
if exist "C:\Program Files\Git\cmd" (
    set "PATH=C:\Program Files\Git\cmd;C:\Program Files\Git\mingw64\bin;%PATH%"
)

:: Tim kiem git.exe
set "GIT_CMD=git"
where git >nul 2>&1
if errorlevel 1 (
    if exist "%LOCALAPPDATA%\Programs\MinGit\cmd\git.exe" (
        set "GIT_CMD=%LOCALAPPDATA%\Programs\MinGit\cmd\git.exe"
    ) else if exist "C:\Program Files\Git\cmd\git.exe" (
        set "GIT_CMD=C:\Program Files\Git\cmd\git.exe"
    ) else (
        echo [LOI] Khong tim thay Git!
        pause
        exit /b 1
    )
)

cd /d "%~dp0"

:: Cau hinh Git Credential Manager de bat popup dang nhap trinh duyet
if exist "%LOCALAPPDATA%\Programs\MinGit\mingw64\bin\git-credential-manager.exe" (
    "%GIT_CMD%" config --global credential.helper "%LOCALAPPDATA%\Programs\MinGit\mingw64\bin\git-credential-manager.exe"
)

:: Khoi tao git repo neu chua co
if not exist ".git" (
    echo [+] Khoi tao Git repository...
    "%GIT_CMD%" init
    "%GIT_CMD%" branch -M main
)

:: Cau hinh remote
"%GIT_CMD%" remote get-url origin >nul 2>&1
if errorlevel 1 (
    echo [+] Them remote origin...
    "%GIT_CMD%" remote add origin https://github.com/hoangmme/nhimme.git
) else (
    "%GIT_CMD%" remote set-url origin https://github.com/hoangmme/nhimme.git
)

:: Tao timestamp tu PowerShell de dat ten commit
for /f "usebackq delims=" %%t in (`powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"`) do set "CURRENT_TIME=%%t"
if "!CURRENT_TIME!"=="" set "CURRENT_TIME=%date% %time%"

set "COMMIT_MSG=Cap nhat du an - !CURRENT_TIME!"

echo [+] Thoi gian: !CURRENT_TIME!
echo [+] Them file (git add .)...
"%GIT_CMD%" add .

echo [+] Tao commit...
"%GIT_CMD%" commit -m "!COMMIT_MSG!" >nul 2>&1

echo.
echo [+] Dang day code len GitHub (git push -u origin main)...
echo [*] Chu y: Cua so dang nhap GitHub (trinh duyet) se bat len ngay bay gio neu chua dang nhap.
echo.

"%GIT_CMD%" push -u origin main

if errorlevel 1 (
    echo.
    echo ========================================================
    echo  [!] DAY CODE CHUA THANH CONG!
    echo.
    echo  Neu cua so trinh duyet van khong hien, ban co 2 cach:
    echo  1. Dang nhap bang Personal Access Token (PAT) cua GitHub:
    echo     - Tao token tai: https://github.com/settings/tokens
    echo     - Chon quyen 'repo' roi copy token
    echo     - Khi duoc hoi Password, paste Token vao la xong.
    echo  2. Hoac cai dat Git day du: https://git-scm.com/download/win
    echo ========================================================
) else (
    echo.
    echo ========================================================
    echo  [THANH CONG] Da day code len GitHub thanh cong!
    echo  Kiem tra tai: https://github.com/hoangmme/nhimme
    echo ========================================================
)

echo.
pause
