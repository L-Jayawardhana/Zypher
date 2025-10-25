# ZYPHER

## TestLang++ for Windows (PowerShell)

This guide shows how to build and run TestLang++ on Windows using PowerShell.

## Prerequisites

- Java JDK 11 or higher
- PowerShell (comes with Windows)

## Quick Start

### 1. Download Dependencies

```powershell
.\scripts\setup-deps.ps1
```

This downloads JFlex, CUP, and JUnit into the `lib/` directory.

### 2. Compile the TestLang++ Compiler

```powershell
.\scripts\compile.ps1
```

This generates the scanner and parser, then compiles all Java sources to `build/`.

### 3. Run the Compiler

```powershell
.\scripts\run-compiler.ps1 "input\example.test" "output\GeneratedTests.java"
```

This compiles a `.test` file into Java JUnit test code.

### 5. Start Backend API

```powershell
.\scripts\start-backend.ps1
```
The backend runs on `http://localhost:8080`.

### 4. Run Tests

```powershell
.\scripts\run-tests.ps1
```

## Available PowerShell Scripts

| Script | Description |
|--------|-------------|
| `setup-deps.ps1` | Download JFlex, CUP, and JUnit dependencies |
| `compile.ps1` | Compile the TestLang++ compiler |
| `run-compiler.ps1` | Run the compiler on a `.test` file |
| `run-tests.ps1` | Run JUnit tests |
| `start-backend.ps1` | Start the Spring Boot backend API |

## Directory Structure

```
Zypher/
├── scripts/           # PowerShell (.ps1)
├── scanner/           # JFlex lexer specification
├── parser/            # CUP parser specification
├── ast/               # Abstract Syntax Tree nodes
├── codegen/           # Code generation
├── compiler/          # Main compiler
├── input/             # Example .test files
├── output/            # Generated Java test files
├── lib/               # Downloaded dependencies (JFlex, CUP, JUnit)
├── build/             # Compiled .class files
└── backend/           # Spring Boot REST API
```

## Troubleshooting

### Script Execution Policy Error

If you see an error about script execution being disabled, run:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Java Not Found

Make sure Java is installed and in your PATH:

```powershell
java -version
```

If not installed, download from [adoptium.net](https://adoptium.net/).

## For Linux/macOS Users

Use the `.sh` scripts instead:

```bash
./scripts/setup-deps.sh
./scripts/compile.sh
./scripts/run-compiler.sh input/example.test output/GeneratedTests.java
```

## Project Info

- **Language**: Java
- **Build Tools**: JFlex (scanner), CUP (parser)
- **Backend**: Spring Boot 3.x
- **Testing**: JUnit 5
