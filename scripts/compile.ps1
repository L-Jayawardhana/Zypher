# Compile the TestLang++ compiler: Scanner + Parser + Code Generator
# PowerShell version for Windows

$ErrorActionPreference = "Stop"

Write-Host "=== Compiling TestLang++ Compiler ==="

# Paths
$LIB_DIR = "lib"
$BUILD_DIR = "build"
$JFLEX_JAR = "$LIB_DIR/jflex-full-1.9.1.jar"
$CUP_JAR = "$LIB_DIR/java-cup-11b.jar"
$CUP_RUNTIME = "$LIB_DIR/java-cup-11b-runtime.jar"

# Check if dependencies exist
if (-not (Test-Path $JFLEX_JAR) -or -not (Test-Path $CUP_JAR)) {
    Write-Host "Dependencies not found. Run .\scripts\setup-deps.ps1 first"
    exit 1
}

# Create build directory
New-Item -ItemType Directory -Force -Path $BUILD_DIR | Out-Null

Write-Host "[1/5] Generating Scanner with JFlex..."
java -cp "$JFLEX_JAR;$CUP_RUNTIME" jflex.Main -d scanner scanner/lexer.flex

Write-Host "[2/5] Generating Parser with CUP..."
java -cp "$CUP_JAR;$CUP_RUNTIME" java_cup.Main -destdir parser -parser Parser -symbols sym parser/parser.cup

Write-Host "[3/5] Compiling AST classes..."
javac -d $BUILD_DIR -cp $CUP_RUNTIME ast/*.java

Write-Host "[4/5] Compiling Scanner and Parser..."
javac -d $BUILD_DIR -cp "$CUP_RUNTIME;$BUILD_DIR" scanner/*.java parser/*.java

Write-Host "[5/5] Compiling Code Generator and Compiler..."
javac -d $BUILD_DIR -cp "$CUP_RUNTIME;$BUILD_DIR" codegen/*.java compiler/*.java

Write-Host "[OK] Compilation successful! Output in $BUILD_DIR/"
