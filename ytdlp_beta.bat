@echo off
title yt-dlp GUI - Video Downloader

:: === Set path to yt-dlp executable here ===
set "YTDLP_PATH=yt-dlp.exe"

:: === Main Menu ===
:menu
cls
echo ================================
echo         yt-dlp Downloader
echo ================================
echo 1. Download Single Video (Default)
echo 2. Download Audio Only (MP3)
echo 3. Download Playlist (Ordered)
echo ================================
set /p choice="Select an option (1-3): "

:: Ask for download folder (once only)
set /p folder="Enter download folder (leave blank for current folder): "
if "%folder%"=="" (
    set "folder=."
)

if "%choice%"=="1" goto single
if "%choice%"=="2" goto audio
if "%choice%"=="3" goto playlist
goto menu

:single
cls
set /p URL="Enter the video URL: "
"%YTDLP_PATH%" --download-archive downloaded.txt -o "%folder%\%%(title)s.%%(ext)s" %URL%
goto end

:audio
cls
set /p URL="Enter the video URL: "
"%YTDLP_PATH%" --download-archive downloaded.txt -x --audio-format mp3 -o "%folder%\%%(title)s.%%(ext)s" %URL%
goto end

:playlist
cls
set /p URL="Enter the playlist URL: "
"%YTDLP_PATH%" --yes-playlist --download-archive downloaded.txt -o "%folder%\%%(playlist_index)03d - %%(title)s.%%(ext)s" %URL%
goto end

:end
echo.
echo Download complete!
pause
goto menu
