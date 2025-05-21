@echo off
setlocal

echo ===== SUPER RESET & REINSTALL SCRIPT (Run as Administrator) =====

REM --- User Confirmation ---
echo WARNING: This script will attempt to uninstall Python and XAMPP, 
echo delete project files, and clean related directories.
set /p AREYOUSURE="Are you absolutely sure you want to continue? (Y/N): "
if /i not "%AREYOUSURE%"=="Y" (
    echo Aborted by user.
    goto :eof
)

REM --- Define Paths (User may need to adjust) ---
set PROJECT_PARENT_DIR=%USERPROFILE%\Desktop\My Website\Test  REM Example: C:\Users\YourUser\Projects
set PROJECT_DIR_NAME=test_servicesbladi
set PROJECT_FULL_PATH=%PROJECT_PARENT_DIR%\%PROJECT_DIR_NAME%
set XAMPP_INSTALL_DIR=C:\xampp

echo --- Stopping XAMPP Services ---
taskkill /f /im httpd.exe /t 2>nul
taskkill /f /im mysqld.exe /t 2>nul
if exist "%XAMPP_INSTALL_DIR%\xampp_stop.exe" (
    echo Attempting to stop XAMPP via xampp_stop.exe...
    start "" /wait "%XAMPP_INSTALL_DIR%\xampp_stop.exe"
)
timeout /t 5

echo --- Uninstalling XAMPP (Manual Step Often Required) ---
echo Please uninstall XAMPP manually via Control Panel > Programs and Features.
echo This script will attempt to remove the directory afterwards.
echo Press any key after you have MANUALLY UNINSTALLED XAMPP...
pause
if exist "%XAMPP_INSTALL_DIR%" (
    echo Removing XAMPP directory: %XAMPP_INSTALL_DIR%
    rd /s /q "%XAMPP_INSTALL_DIR%"
    if exist "%XAMPP_INSTALL_DIR%" (
        echo Failed to remove XAMPP directory. Please delete it manually.
    ) else (
        echo XAMPP directory removed.
    )
)

echo --- Uninstalling Python (Manual Step Often Required) ---
echo Please uninstall ALL versions of Python manually via Control Panel > Programs and Features.
echo This script will try to find common Python paths to delete.
echo Press any key after you have MANUALLY UNINSTALLED ALL PYTHON VERSIONS...
pause
REM Attempt to remove common Python installation folders
if exist "%LOCALAPPDATA%\Programs\Python" rd /s /q "%LOCALAPPDATA%\Programs\Python"
if exist "%PROGRAMFILES%\Python*" rd /s /q "%PROGRAMFILES%\Python*"

echo --- Cleaning Project Directory ---
if exist "%PROJECT_FULL_PATH%" (
    echo Deleting project directory: %PROJECT_FULL_PATH%
    rd /s /q "%PROJECT_FULL_PATH%"
    if exist "%PROJECT_FULL_PATH%" (
        echo Failed to delete project directory. Please delete it manually.
    ) else (
        echo Project directory deleted.
    )
)

echo --- Cleaning Python Cache and Pip Cache ---
if exist "%LOCALAPPDATA%\pip\cache" rd /s /q "%LOCALAPPDATA%\pip\cache"
if exist "%APPDATA%\pip" rd /s /q "%APPDATA%\pip"

echo --- RESTART YOUR COMPUTER NOW ---
echo It is CRITICAL to restart your computer at this point to ensure all changes take effect.
echo After restarting, proceed with the REINSTALLATION steps.
echo Press any key to exit this part of the script.
pause
goto :eof

REM --- The script effectively ends here for the RESET part. ---
REM --- User must restart and then run a SEPARATE script or manual steps for REINSTALLATION. --- 