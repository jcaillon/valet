@REM -----------------------------------------------------------------------------
@REM Valet Startup Script for windows
@REM   Allows to run valet from the windows command prompt.
@REM
@REM Environment Variable Prerequisites
@REM   VALET_BIN_BASH    Must point to bash executable (defaults to C:\Program Files\Git\bin\bash.exe).
@REM -----------------------------------------------------------------------------
@REM Begin all REM lines with '@' for safety
@echo off

@setlocal

set ERROR_CODE=0

@REM Try to find the path to bash.exe or fail
if not "%VALET_BIN_BASH%"=="" goto GotBinBash
set "VALET_BIN_BASH=C:\Program Files\Git\bin\bash.exe"
if exist "%VALET_BIN_BASH%" goto GotBinBash
for %%i in (bash.exe) do set "VALET_BIN_BASH=%%~$PATH:i"
if exist "%VALET_BIN_BASH%" goto chkMHome
echo The VALET_BIN_BASH environment variable is not defined correctly, >&2
echo it should point to the bash.exe executable that can be found in a Git bash installation. >&2
echo This environment variable is needed to run this program. >&2
echo Exiting now... >&2
goto error

:GotBinBash

@REM Try to find the path to valet
if not "%VALET_HOME%"=="" goto GotValetHome
set "VALET_HOME=%~dp0"
if exist "%VALET_HOME%\valet" goto GotValetHome

echo The valet script is not present in the same directory of this script. >&2
echo Please override the path to your valet installation directory. >&2
echo by defining the VALET_HOME environment variable. >&2
goto error

:GotValetHome
@REM Convert windows path to unix path
set VALET_HOME=%VALET_HOME:\=/%
set VALET_HOME=%VALET_HOME::=%

@REM trim the trailing slash
if "%VALET_HOME:~-1%"=="\" set VALET_HOME=%VALET_HOME:~0,-1%

bash.exe -c "/%VALET_HOME%/valet %*"

if ERRORLEVEL 1 goto error
goto end

:error
set ERROR_CODE=1

:end
@endlocal & set ERROR_CODE=%ERROR_CODE%

