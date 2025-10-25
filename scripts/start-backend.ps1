# Start the Spring Boot backend server
# PowerShell version for Windows

$ErrorActionPreference = "Stop"

$BACKEND_DIR = "backend"

if (-not (Test-Path $BACKEND_DIR)) {
    Write-Host "Error: Backend directory not found"
    exit 1
}

Set-Location $BACKEND_DIR

# Check if JAR exists
$JAR_FILE = "target/testlang-demo-0.0.1-SNAPSHOT.jar"

if (-not (Test-Path $JAR_FILE)) {
    Write-Host "Backend JAR not found. Building with Maven..."
    
    if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
        Write-Host "Error: Maven not installed. Please install Maven first."
        exit 1
    }
    
    mvn clean package -DskipTests
}

Write-Host "=== Starting Backend Server ==="
Write-Host "Server will be available at: http://localhost:8080"
Write-Host ""

java -jar $JAR_FILE
