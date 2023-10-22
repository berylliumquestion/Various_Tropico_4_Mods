@echo off

setlocal EnableDelayedExpansion

if not exist hpk.zip (
    PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%cd%\Download.ps1'"
)

if not exist hpk/ (
    PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%cd%\Extract.ps1'"
    rename hpk-v0.3.11-x86_64-pc-windows-msvc hpk
)

echo Default or non-default location?
echo 1)Default GOG install
echo 2)Default Steam install
echo 3)Non-default install

set /p DirectoryChoice=Enter: 

if %DirectoryChoice%==1 (
    echo GOG install
    set directory=C:\GOG Games\Tropico 4
) else if %DirectoryChoice%==2 (
    echo Steam install
    set directory="%ProgramFiles(x86)%\Steam\steamapps\common"
) else (
    echo Please specify location...
    set /p directory=Enter:
)

echo %directory%

set mods[0]=BetterDescriptions
set mods[1]=NoFreeImmigrants

for  /L %%i in (0, 1, 1) do (
    set /p choice="Install !mods[%%i]!? (y/n): "
    set choices[%%i]=!choice!
)

if not exist "!directory!\game" (
    mkdir "!directory!\game"
)

for /L %%i in (0, 1, 1) do (
    if !choices[%%i]!==y (
        if !mods[%%i]!==BetterDescriptions (
            copy /v "mods\BetterDescriptions.lua" "!directory!\game\BetterDescriptions.lua"
        )
            
        if !mods[%%i]!==NoFreeImmigrants (
            call :InstallNoFreeImmigrants "!directory!"
        )
            
    ) else (
        echo skipped
    )
)

endlocal
goto :EOF

:InstallNoFreeImmigrants

set dlc_hpks[0]=Construction
set dlc_hpks[1]=EastPoint
set dlc_hpks[2]=Expansion
set dlc_hpks[3]=Megalopolis
set dlc_hpks[4]=Military
set dlc_hpks[5]=NuclearTakedown
set dlc_hpks[6]=PirateHaven
set dlc_hpks[7]=Plantation
set dlc_hpks[8]=Propaganda
set dlc_hpks[9]=Update1
set dlc_hpks[10]=Vigilante
set dlc_hpks[11]=Voodoo

if not exist "%~1\dlc.bak\" (
    echo Backing up hpks!
    echo %~1
    robocopy "%~1\dlc" "%~1\dlc.bak"
    copy "%~1\Packs\boot\persist\Game.hpk" "%~1\Packs\boot\persist\Game.hpk.bak"
)

for /L %%i in (0, 1, 11) do (
    echo Extracting !dlc_hpks[%%i]!.hpk...
    hpk\hpk.exe extract "%~1\dlc\!dlc_hpks[%%i]!.hpk" "%~1\dlc\!dlc_hpks[%%i]!"
)

hpk\hpk.exe extract "%~1\Packs\boot\persist\Game.hpk" "%~1\Packs\boot\persist\Game"

for /L %%i in (0, 1, 11) do (
    echo Deleting minister events from !dlc_hpks[%%i]!.hpk...
    if not !dlc_hpks[%%i]!==Expansion (
        del "%~1\dlc\!dlc_hpks[%%i]!\!dlc_hpks[%%i]!\game\SequenceList\Minister_events.lua
    ) else (
        del "%~1\dlc\!dlc_hpks[%%i]!\ex\game\SequenceList\Minister_events.lua
    )
)

del "%~1\Packs\boot\persist\Game\game\SequenceList\Minister_events.lua"

for /L %%i in (0, 1, 11) do (
    echo Repacking !dlc_hpks[%%i]!.hpk...
    hpk\hpk.exe create "%~1\dlc\!dlc_hpks[%%i]!" "%~1\dlc\!dlc_hpks[%%i]!.hpk" --dont-compress-files
)

hpk\hpk.exe create "%~1\Packs\boot\persist\Game" "%~1\Packs\boot\persist\Game.hpk" --dont-compress-files

if exist "%~1\dlc\NuclearTakedown.hpk" (
    copy mods\NoFreeImmigrantsMeansNoFreeImmigrants.lua "%~1\NuclearTakedown\game\NoFreeImmigrantsMeansNoFreeImmigrants.lua"
)

exit /B 0

:EOF
