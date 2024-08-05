@echo off
setlocal

:: Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python not found. Downloading and installing Python...
    :: Download Python installer
    powershell -Command "Invoke-WebRequest -Uri 'https://www.python.org/ftp/python/3.11.5/python-3.11.5-amd64.exe' -OutFile 'python_installer.exe'"

    :: Run the installer silently
    start /wait python_installer.exe /quiet InstallAllUsers=1 PrependPath=1

    :: Clean up installer
    del python_installer.exe
)

:: Check if pip is installed
pip --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Pip not found. Installing pip...
    python -m ensurepip
)

:: Upgrade pip
python -m pip install --upgrade pip

:: Install Flask
python -m pip install flask

:: Check if app.py exists
if not exist app.py (
    echo app.py not found. Please make sure app.py is in the current directory.
    exit /b 1
)

:: Start the Flask application in a new command prompt window
start cmd /k "python app.py"

:: Wait a moment for the server to start
timeout /t 5

:: Open the web browser with the Flask app URL
start http://localhost:5000

endlocal
