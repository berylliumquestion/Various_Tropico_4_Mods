@echo off

setlocal EnableDelayedExpansion

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
    REM If anyone uses Steam, could you fix this?
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

if not exist "!directory!\NuclearTakedown\game" (
    mkdir "!directory!\NuclearTakedown\game"
)

for /L %%i in (0, 1, 1) do (
    if !choices[%%i]!==y (
        if !mods[%%i]!==BetterDescriptions (
            copy /v "mods\BetterDescriptions.lua" "!directory!\game\BetterDescriptions.lua"
        )
            
        if !mods[%%i]!==NoFreeImmigrants (
            copy /v "mods\NoFreeImmigrantsMeansNoFreeImmigrants.lua" "!directory!\NuclearTakedown\game\NoFreeImmigrantsMeansNoFreeImmigrants.lua"
        )
            
    ) else (
        echo skipped
    )
)
