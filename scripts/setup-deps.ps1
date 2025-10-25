# Setup script - downloads JFlex and CUP if not present
# PowerShell version for Windows

$ErrorActionPreference = "Stop"

$LIB_DIR = "lib"
$JFLEX_VERSION = "1.9.1"
$CUP_VERSION = "11b"
$JUNIT_VERSION = "1.10.0"

# Create directories
New-Item -ItemType Directory -Force -Path "$LIB_DIR/junit" | Out-Null

# Download JFlex if not present
if (-not (Test-Path "$LIB_DIR/jflex-full-$JFLEX_VERSION.jar")) {
    Write-Host "Downloading JFlex $JFLEX_VERSION..."
    $url = "https://repo1.maven.org/maven2/de/jflex/jflex/$JFLEX_VERSION/jflex-$JFLEX_VERSION.jar"
    Invoke-WebRequest -Uri $url -OutFile "$LIB_DIR/jflex-full-$JFLEX_VERSION.jar"
} else {
    Write-Host "[OK] JFlex already downloaded"
}

# Download CUP if not present
if (-not ((Test-Path "$LIB_DIR/java-cup-$CUP_VERSION.jar") -and (Test-Path "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar"))) {
    Write-Host "Downloading CUP $CUP_VERSION..."
    $url = "http://www2.cs.tum.edu/projects/cup/releases/java-cup-bin-$CUP_VERSION-20160615.tar.gz"
    $tmpFile = "$env:TEMP/cup-$CUP_VERSION.tar.gz"
    
    Invoke-WebRequest -Uri $url -OutFile $tmpFile
    
    # Extract using tar (available in Windows 10+)
    tar -xzf $tmpFile -C $LIB_DIR
    
    # Rename files if needed
    if ((Test-Path "$LIB_DIR/java-cup-11b.jar") -and -not (Test-Path "$LIB_DIR/java-cup-$CUP_VERSION.jar")) {
        Move-Item "$LIB_DIR/java-cup-11b.jar" "$LIB_DIR/java-cup-$CUP_VERSION.jar"
    }
    if ((Test-Path "$LIB_DIR/java-cup-11b-runtime.jar") -and -not (Test-Path "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar")) {
        Move-Item "$LIB_DIR/java-cup-11b-runtime.jar" "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar"
    }
    
    Remove-Item $tmpFile -ErrorAction SilentlyContinue
} else {
    Write-Host "[OK] CUP already downloaded"
}

# Download JUnit if not present
if (-not (Test-Path "$LIB_DIR/junit/junit-platform-console-standalone-$JUNIT_VERSION.jar")) {
    Write-Host "Downloading JUnit $JUNIT_VERSION..."
    $url = "https://repo1.maven.org/maven2/org/junit/platform/junit-platform-console-standalone/$JUNIT_VERSION/junit-platform-console-standalone-$JUNIT_VERSION.jar"
    Invoke-WebRequest -Uri $url -OutFile "$LIB_DIR/junit/junit-platform-console-standalone-$JUNIT_VERSION.jar"
} else {
    Write-Host "[OK] JUnit already downloaded"
}

Write-Host ""
Write-Host "[OK] All dependencies ready in $LIB_DIR/"
Write-Host ""
Write-Host "Downloaded files:"
Get-ChildItem "$LIB_DIR/*.jar", "$LIB_DIR/junit/*.jar" | ForEach-Object {
    $size = [math]::Round($_.Length / 1MB, 2)
    Write-Host "  - $($_.Name) ($size MB)"
}
