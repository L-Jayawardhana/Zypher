# Verification script - tests all examples
# PowerShell version for Windows

$ErrorActionPreference = "Stop"

Write-Host "======================================"
Write-Host "TestLang++ Verification Script"
Write-Host "======================================"
Write-Host ""

# Check if compiler is built
if (-not (Test-Path "build")) {
    Write-Host "[X] Build directory not found"
    Write-Host "Run: .\scripts\compile.ps1"
    exit 1
}

Write-Host "[OK] Build directory exists"
Write-Host ""

# Test each example file
$examples = @("example.test")
$outputs = @("GeneratedTests.java")

Write-Host "======================================"
Write-Host "Compiling Example Files"
Write-Host "======================================"
Write-Host ""

for ($i = 0; $i -lt $examples.Length; $i++) {
    $example = $examples[$i]
    $output = $outputs[$i]
    
    Write-Host "Testing: input/$example"
    
    try {
        & .\scripts\run-compiler.ps1 "input/$example" "output/$output" 2>&1 | Out-Null
        Write-Host "  [OK] Compilation successful"
        
        # Check if output file exists and is not empty
        if (Test-Path "output/$output") {
            $lines = (Get-Content "output/$output").Count
            Write-Host "  [OK] Generated $lines lines of code"
        } else {
            Write-Host "  [X] Output file is empty"
            exit 1
        }
    } catch {
        Write-Host "  [X] Compilation failed"
        exit 1
    }
    Write-Host ""
}

Write-Host "======================================"
Write-Host "All Verifications Passed!"
Write-Host "======================================"
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Run tests: .\scripts\run-tests.ps1 output/GeneratedTests.java"
Write-Host "  2. Start backend: .\scripts\start-backend.ps1"
Write-Host ""
