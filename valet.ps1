<#
.SYNOPSIS
Allows to run valet from powershell.

.DESCRIPTION
Call windows Git bash and run valet command.

.EXAMPLE
./valet.ps1
./valet.ps1 -shouldExit 1
#>
function Main {
  # Find the path to bash.exe

  # get it from the environment variable
  [string] $bashPath = $env:VALET_BIN_BASH

  # check if the path exists, otherwise try a hard coded value
  if (-Not (Test-Path $bashPath)) {
    $bashPath = "C:\Program Files\Git\bin\bash.exe"
  }

  # check if the path exists, otherwise try to find bash.exe in the path
  if (-Not (Test-Path $bashPath)) {
    $bashPath = Get-Command bash.exe | Select-Object -ExpandProperty Source
  }

  # Check if the path exists, otherwise throw an error
  if (-Not (Test-Path $bashPath)) {
    throw "The VALET_BIN_BASH environment variable is not defined correctly, it should point to the bash.exe executable that can be found in a Git bash installation. This environment variable is needed to run this program."
  }

  # Find the path to Valet home

  # get it from the environment variable
  [string] $valetHome = $env:VALET_HOME

  # check if the path exists, otherwise try the current directory + valet
  if (-Not (Test-Path $valetHome)) {
    $valetHome = "$PSScriptRoot"
  }

  # check if the path exists, otherwise throw an error
  if (-Not (Test-Path $valetHome)) {
    throw "The valet script is not present in the same directory of this script. Please override the path to your valet installation directory by defining the VALET_HOME environment variable."
  }

  # convert the valet home path to a bash path
  $valetHome = $valetHome.Replace("\", "/")
  $valetHome = $valetHome.Replace(":", "")
  $valetHome = "/$valetHome"

  # trim trailing / if present
  $valetHome = $valetHome.TrimEnd("/")

  # convert arguments to a string where each argument is separated by a space
  [string] $quotedArgs = $args | ForEach-Object { $_ + " " }

  # echo the command that will be run
  Write-Host "$bashPath -c $valetHome/valet $quotedArgs"

  # run bash with the valet script, throw an error if the exit code is not 0
  & $bashPath -c "$valetHome/valet $quotedArgs"
}

Main $args