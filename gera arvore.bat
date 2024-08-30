@echo off
setlocal enabledelayedexpansion

rem Define a pasta que você quer listar
set "folder=."

rem Cria ou limpa o arquivo de saída
echo. > "00 - arvore.txt"

rem Função para listar arquivos e pastas
call :listDir "%folder%" 0

goto :eof

:listDir
setlocal
set "dirPath=%~1"
set "level=%~2"

rem Adiciona espaços para a indentação
set "indent="
for /L %%i in (1,1,%level%) do (
    if %%i lss %level% (
        set "indent=!indent!    "
    ) else (
        set "indent=!indent!│   "
    )
)

rem Lista as pastas
set "lastDir="
for /f "delims=" %%d in ('dir /b /ad "%dirPath%"') do (
    if /i not "%%d"=="node_modules" (
        if defined lastDir (
            echo !indent!├── %%d >> "00 - arvore.txt"
        ) else (
            echo !indent!+── %%d >> "00 - arvore.txt"
        )
        set "lastDir=%%d"
        call :listDir "%dirPath%\%%d" !level!+1
    )
)

rem Lista os arquivos
set "lastFile="
for /f "delims=" %%f in ('dir /b "%dirPath%"') do (
    if /i not "%%f"=="node_modules" (
        if defined lastFile (
            echo !indent!│   ├── %%f >> "00 - arvore.txt"
        ) else (
            echo !indent!│   └── %%f >> "00 - arvore.txt"
        )
        set "lastFile=%%f"
    )
)

endlocal
exit /b
