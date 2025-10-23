#!/bin/bash
# Setup script - downloads JFlex and CUP if not present

set -e

LIB_DIR="lib"
JFLEX_VERSION="1.9.1"
CUP_VERSION="11b"

mkdir -p "$LIB_DIR"

# Download JFlex if not present
if [ ! -f "$LIB_DIR/jflex-full-$JFLEX_VERSION.jar" ]; then
    echo "Downloading JFlex $JFLEX_VERSION..."
    wget -O "$LIB_DIR/jflex-full-$JFLEX_VERSION.jar" \
        "https://github.com/jflex-de/jflex/releases/download/v$JFLEX_VERSION/jflex-full-$JFLEX_VERSION.jar"
fi

# Download CUP if not present
if [ ! -f "$LIB_DIR/java-cup-$CUP_VERSION.jar" ]; then
    echo "Downloading CUP $CUP_VERSION..."
    wget -O "$LIB_DIR/java-cup-$CUP_VERSION.jar" \
        "http://www2.cs.tum.edu/projects/cup/releases/java-cup-bin-$CUP_VERSION-20160615.tar.gz"
    # Extract just the JAR
    tar -xzf "$LIB_DIR/java-cup-$CUP_VERSION.jar" -C "$LIB_DIR" --strip-components=1 "java-cup-11b/java-cup-11b.jar" || true
    mv "$LIB_DIR/java-cup-11b.jar" "$LIB_DIR/java-cup-$CUP_VERSION.jar" 2>/dev/null || true
fi

# Download CUP runtime if not present
if [ ! -f "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar" ]; then
    echo "Downloading CUP runtime $CUP_VERSION..."
    wget -O "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar" \
        "http://www2.cs.tum.edu/projects/cup/releases/java-cup-bin-$CUP_VERSION-20160615.tar.gz"
    # Extract runtime JAR
    tar -xzf "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar" -C "$LIB_DIR" --strip-components=1 "java-cup-11b/java-cup-11b-runtime.jar" || true
    mv "$LIB_DIR/java-cup-11b-runtime.jar" "$LIB_DIR/java-cup-$CUP_VERSION-runtime.jar" 2>/dev/null || true
fi

echo "✓ Dependencies ready in $LIB_DIR/"
