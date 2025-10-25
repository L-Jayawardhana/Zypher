# Run the TestLang++ compiler on a .test file
# PowerShell version for Windows

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$InputFile,
    
    [Parameter(Position=1)]
    [string]$OutputFile = "output/GeneratedTests.java"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $InputFile)) {
    Write-Host "Error: Input file '$InputFile' not found"
    exit 1
}

# Ensure output directory exists
$outputDir = Split-Path $OutputFile -Parent
if ($outputDir) {
    New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
}

# Paths
$BUILD_DIR = "build"
$CUP_RUNTIME = "lib/java-cup-11b-runtime.jar"

if (-not (Test-Path $BUILD_DIR)) {
    Write-Host "Build directory not found. Run .\scripts\compile.ps1 first"
    exit 1
}

Write-Host "=== Running TestLang++ Compiler ==="
Write-Host "Input:  $InputFile"
Write-Host "Output: $OutputFile"
Write-Host ""

java -cp "$BUILD_DIR;$CUP_RUNTIME" compiler.TestLangCompiler $InputFile $OutputFile

Write-Host ""
Write-Host "[OK] Compilation successful!"
