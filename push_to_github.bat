@echo off
setlocal enabledelayedexpansion

echo ========================================================
echo        HE THONG DAY CODE LEN GITHUB TU DONG
echo        Repository: https://github.com/hoangmme/nhimme
echo ========================================================
echo.

:: Tim kiem git.exe
set "GIT_CMD=git"
where git >nul 2>&1
if errorlevel 1 (
    if exist "C:\Program Files\Git\cmd\git.exe" (
        set "GIT_CMD=C:\Program Files\Git\cmd\git.exe"
    ) else if exist "%LOCALAPPDATA%\Programs\Git\cmd\git.exe" (
        set "GIT_CMD=%LOCALAPPDATA%\Programs\Git\cmd\git.exe"
    ) else if exist "C:\Program Files (x86)\Git\cmd\git.exe" (
        set "GIT_CMD=C:\Program Files (x86)\Git\cmd\git.exe"
    ) else (
        echo [LOI] May tinh cua ban chua cai dat Git!
        echo Vui long tai va cai dat Git tai: https://git-scm.com/download/win
        echo Sau khi cai xong, hay chay lai file bat nay.
        echo.
        pause
        exit /b 1
    )
)

cd /d "%~dp0"

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

:: Tao timestamp tu PowerShell de dam bao chay chuan tren moi may Windows
for /f "usebackq delims=" %%t in (`powershell -NoProfile -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"`) do set "CURRENT_TIME=%%t"
if "!CURRENT_TIME!"=="" set "CURRENT_TIME=%date% %time%"

set "COMMIT_MSG=Cap nhat du an - !CURRENT_TIME!"

echo [+] Thoi gian day code: !CURRENT_TIME!
echo [+] Dang them file (git add .)...
"%GIT_CMD%" add .

echo [+] Dang tao commit...
"%GIT_CMD%" commit -m "!COMMIT_MSG!"

echo [+] Dang day code len GitHub (git push -u origin main)...
"%GIT_CMD%" push -u origin main

if errorlevel 1 (
    echo.
    echo ========================================================
    echo  [!] CO LOI XAY RA HOAC CHUA DANG NHAP GITHUB!
    echo.
    echo  Neu GitHub yeu cau xac thuc:
    echo  - Su dung GitHub Personal Access Token (PAT) lam mat khau
    echo  - Hoac dang nhap bang trinh duyet khi duoc hoi.
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
