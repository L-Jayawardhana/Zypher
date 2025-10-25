# Compile and run the generated JUnit tests
# PowerShell version for Windows

param(
    [Parameter(Mandatory=$true, Position=0)]
    [string]$GeneratedFile
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $GeneratedFile)) {
    Write-Host "Error: Generated test file '$GeneratedFile' not found"
    exit 1
}

# Download JUnit 5 JARs if not present
$JUNIT_DIR = "lib/junit"
New-Item -ItemType Directory -Force -Path $JUNIT_DIR | Out-Null

if (-not (Test-Path "$JUNIT_DIR/junit-platform-console-standalone-1.10.0.jar")) {
    Write-Host "Downloading JUnit 5..."
    $url = "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/1.10.0/junit-platform-console-standalone-1.10.0.jar"
    Invoke-WebRequest -Uri $url -OutFile "$JUNIT_DIR/junit-platform-console-standalone-1.10.0.jar"
} else {
    Write-Host "[OK] JUnit already downloaded"
}

$JUNIT_JAR = "$JUNIT_DIR/junit-platform-console-standalone-1.10.0.jar"
$TEST_BUILD = "build/tests"
New-Item -ItemType Directory -Force -Path $TEST_BUILD | Out-Null

Write-Host "=== Compiling Generated Tests ==="
javac -d $TEST_BUILD -cp $JUNIT_JAR $GeneratedFile

Write-Host ""
Write-Host "=== Running JUnit Tests ==="
java -jar $JUNIT_JAR --class-path $TEST_BUILD --scan-class-path

Write-Host ""
Write-Host "[OK] Tests completed!"
