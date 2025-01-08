@echo off
setlocal enabledelayedexpansion

REM Set the log file path
set LOG_FILE=%temp%\BoseUpdater.log

REM Initialize variables
set LAST_LINE=0

:LOOP
REM Check if the file exists
if not exist "%LOG_FILE%" (
    echo File "%LOG_FILE%" not found. Waiting for it to be created...
    timeout /t 2 >nul
    goto LOOP
)

REM Read the total number of lines in the file
for /f %%A in ('find /c /v "" ^< "%LOG_FILE%"') do set TOTAL_LINES=%%A

REM If there are new lines, display them
if !TOTAL_LINES! GTR !LAST_LINE! (
    for /f "tokens=*" %%A in ('more +!LAST_LINE! "%LOG_FILE%"') do echo %%A
    set LAST_LINE=!TOTAL_LINES!
)

REM Wait for a short time before checking again
timeout /t 2 >nul
goto LOOP
