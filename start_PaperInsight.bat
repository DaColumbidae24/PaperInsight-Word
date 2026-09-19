@echo off
title PaperInsight_Launcher

echo ========================================================
echo   Checking if PaperInsight is already running...
echo ========================================================
tasklist /V /FI "IMAGENAME eq cmd.exe" 2>NUL | findstr /I "PaperInsight-Word Agent" >NUL
if %ERRORLEVEL% EQU 0 (
    echo [WARNING] PaperInsight-Word is already running. Do not launch duplicates!
    timeout /t 5 >nul
    exit
)

echo ========================================================
echo   Checking CC Switch status...
echo ========================================================
tasklist /FI "IMAGENAME eq cc-switch.exe" 2>NUL | find /I "cc-switch.exe" >NUL
if %ERRORLEVEL% EQU 0 (
    echo [INFO] CC Switch is already running. Skipping launch.
) else (
    tasklist /FI "IMAGENAME eq CC Switch.exe" 2>NUL | find /I "CC Switch.exe" >NUL
    if %ERRORLEVEL% EQU 0 (
        echo [INFO] CC Switch is already running. Skipping launch.
    ) else (
        echo Starting CC Switch...
        if exist "%LOCALAPPDATA%\Programs\CC Switch\cc-switch.exe" (
            start "" "%LOCALAPPDATA%\Programs\CC Switch\cc-switch.exe"
        ) else if exist "%LOCALAPPDATA%\Programs\CC Switch\CC Switch.exe" (
            start "" "%LOCALAPPDATA%\Programs\CC Switch\CC Switch.exe"
        ) else (
            echo [WARNING] CC Switch executable not found in the default location.
            echo Please start CC Switch manually before running this script.
            pause
            exit
        )
        echo Waiting for CC Switch to establish local routing...
        timeout /t 5 /nobreak >nul
    )
)

echo ========================================================
echo   Checking Visual Proxy (agent-vision)...
echo ========================================================
where python >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Starting Visual Proxy (agent-vision)...
    :: Start it silently in the background; if it is already running, it will not duplicate
    start "" /B python -m agent_vision start
    timeout /t 3 /nobreak >nul
) else (
    echo [WARNING] Python not found in PATH. Visual proxy might not work.
)

echo ========================================================
echo   Executing safety backup...
echo ========================================================
set BACKUP_DIR=%~dp0Backups\%date:~0,4%%date:~5,2%%date:~8,2%_%time:~0,2%%time:~3,2%
set BACKUP_DIR=%BACKUP_DIR: =0%
mkdir "%BACKUP_DIR%" 2>nul

robocopy "%~dp0" "%BACKUP_DIR%" /E /XO /R:1 /W:1 /NFL /NDL /NJH /NJS /XD "Backups" "Outputs" "temp" >nul
if %ERRORLEVEL% LEQ 16 (
    echo Backup completed.
) else (
    echo [WARNING] Backup anomaly occurred ^(Error Code: %ERRORLEVEL%^), but main process will continue.
)

echo ========================================================
echo   Validating environment...
echo ========================================================
set "PATH=%PATH%;%APPDATA%\npm"
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Node.js is not installed or not in PATH.
    pause
    exit
)
where codex >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Codex CLI is not installed. Run: npm install -g @openai/codex
    pause
    exit
)

echo ========================================================
echo   Copying standard prompt to clipboard...
echo ========================================================
echo Please scan all PDF files in the Inputs folder. Treat each PDF as an independent paper. For each paper: 1. Determine if it is Research or Review, and report which template folder you will use. 2. Check if a Word file with the same name already exists in Outputs. If it exists and I haven't said "force regenerate", SKIP it and mark it as [Completed, Skipped]. 3. Create matching subfolders in Outputs and temp named exactly after the PDF file. 4. After my confirmation, generate the Chinese interpretation. The final deliverable MUST be a .docx file placed in Outputs/[PaperName]/. The validation .pdf MUST be placed in temp/[PaperName]/. Never put PDFs in Outputs. 5. Report the results for each paper separately.| clip

echo Prompt copied! Press Ctrl+V and Enter in Codex to start.
echo ========================================================
echo   Starting PaperInsight-Word Agent...
echo ========================================================
cd /d "%~dp0"
title PaperInsight-Word Agent

call codex
pause