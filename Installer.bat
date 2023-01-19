@echo off

setlocal EnableDelayedExpansion

set mods[0]=BetterDescriptions

for  /L %%i in (0, 1, 0) do (
	set /p choice="Install !mods[%%i]!? (y/n): "
	set choices[%%i]=!choice!
)

if exist "C:\GOG Games\Tropico 4\" (
	if not exist game\ (
		mkdir "C:\GOG Games\Tropico 4\game"
	)
	
	for /L %%i in (0, 1, 0) do (
		if !choices[%%i]!==y (
			if !mods[%%i]!==BetterDescriptions (
				copy /v "game\BetterDescriptions.lua" "C:\GOG Games\Tropico 4\game\BetterDescriptions.lua"
			)
			
		) else (
			echo skipped
		)
	)
	
) else (
	echo Unimplemented
)

endlocal