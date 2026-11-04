@echo off
setlocal EnableExtensions
set "REPO_URL=https://github.com/krupali68/vida_engineering.git"
set "PROJECT_NAME=vida_engineering"
set "SCRIPT_DIR=%~dp0"

if exist "%SCRIPT_DIR%package.json" (
    set "PROJECT_DIR=%SCRIPT_DIR%"
) else if exist "%SCRIPT_DIR%%PROJECT_NAME%\package.json" (
    set "PROJECT_DIR=%SCRIPT_DIR%%PROJECT_NAME%"
) else (
    where git >nul 2>&1
    if errorlevel 1 (
        echo ERROR: Git not installed. Install Git from https://git-scm.com/
        goto :fail
    )
    if exist "%SCRIPT_DIR%%PROJECT_NAME%" (
        echo ERROR: Existing folder %SCRIPT_DIR%%PROJECT_NAME% does not contain package.json.
        goto :fail
    )
    echo Cloning %REPO_URL% ...
    git clone "%REPO_URL%" "%SCRIPT_DIR%%PROJECT_NAME%"
    if errorlevel 1 goto :fail
    set "PROJECT_DIR=%SCRIPT_DIR%%PROJECT_NAME%"
)

where node >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not installed. Install Node.js 22 LTS or newer from https://nodejs.org/
    goto :fail
)
where npm >nul 2>&1
if errorlevel 1 (
    echo ERROR: npm not installed. Reinstall Node.js with npm.
    goto :fail
)

node -e "const v=process.versions.node.split('.').map(Number);process.exit(v[0]>22?0:v[0]==22?v[1]>=12?0:1:v[0]==20?v[1]>=19?0:1:1)"
if errorlevel 1 (
    echo ERROR: Node.js is too old. Install Node.js 22.12+ or 20.19+.
    goto :fail
)

echo Node version:
node --version
cd /d "%PROJECT_DIR%"
if errorlevel 1 goto :fail

if exist "package-lock.json" (
    echo Installing dependencies with npm ci ...
    call npm ci
) else (
    echo Installing dependencies with npm install ...
    call npm install
)
if errorlevel 1 goto :fail

echo Starting Vite. Open http://localhost:5173/ or URL shown below.
if /I "%~1"=="--network" (
    call npm run dev -- --host 0.0.0.0
) else (
    call npm run dev
)
if errorlevel 1 goto :fail
exit /b 0

:fail
echo Installation or startup failed.
pause
exit /b 1
