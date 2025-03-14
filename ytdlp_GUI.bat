@ECHO OFF
set defaultDir=%cd%
:BEGIN
CLS
ECHO YTDLP GUI
ECHO.
ECHO 1. Download video
ECHO 2. Download audio
ECHO.
choice /c 12 /m "Select a choice: "
IF ERRORLEVEL ==2 GOTO TWO
IF ERRORLEVEL ==1 GOTO ONE

:ONE
CLS
echo Video downloader
echo ==============
echo.
set /p input= Paste video URL (automatically detects playlist links): 
set /p folderName= Enter folder name (leave blank for default directory): 

REM Combine folder name with default directory if provided
IF NOT "%folderName%"=="" (
    set outputDir=%defaultDir%\%folderName%
) ELSE (
    set outputDir=%defaultDir%
)

yt-dlp.exe -P "%outputDir%" -S ext:mp4:m4a %input%
pause
goto BEGIN

:TWO
CLS
echo Audio downloader
echo ================
echo.
set /p input= Paste video URL: 
ECHO.
ECHO Available audio formats:
ECHO.
ECHO 1. MP3
ECHO 2. WAV
ECHO 3. VORBIS
ECHO.
choice /c 123 /m "Select audio format: "
IF ERRORLEVEL ==3 SET audioFormat=vorbis
IF ERRORLEVEL ==2 SET audioFormat=wav
IF ERRORLEVEL ==1 SET audioFormat=mp3

set /p folderName= Enter folder name (leave blank for default directory): 

REM Combine folder name with default directory if provided
IF NOT "%folderName%"=="" (
    set outputDir=%defaultDir%\%folderName%
) ELSE (
    set outputDir=%defaultDir%
)

yt-dlp.exe -P "%outputDir%" -x --audio-format %audioFormat% --audio-quality 0 %input%
pause
goto BEGIN