#!/bin/bash

PROJETO=$1
if [ -z "$PROJETO" ]; then
    echo "Uso: ./zen_desktop.sh <pasta_do_projeto>"
    exit 1
fi

if [ ! -d "$PROJETO" ]; then
    echo "[ZenDesktop] pasta nao encontrada: $PROJETO"
    exit 1
fi

ZENIRIS=./build/zeniris
CC=clang
STRIP=strip

NOME=$(basename "$PROJETO")
BUILD_DIR="$PROJETO/build_desktop"
ZNI_DIR="$BUILD_DIR/data/zni"
ASSETS_DIR="$BUILD_DIR/data/assets"
BIN_DIR="$BUILD_DIR/bin"

echo "[ZenDesktop] iniciando build: $NOME"
echo ""

rm -rf "$BUILD_DIR"
mkdir -p "$ZNI_DIR" "$ASSETS_DIR" "$BIN_DIR"

echo "[ZenDesktop] compilando .zn -> .zni..."
find "$PROJETO" -maxdepth 1 -name "*.zn" | while read ZN; do
    BASE="${ZN%.zn}"
    TMP="$BASE._tmp_.zr"
    ZNI_OUT="$ZNI_DIR/$(basename $BASE).zni"
    cp "$ZN" "$TMP"
    $ZENIRIS build "$TMP" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "[ZenDesktop] ERRO validando: $ZN"
        rm -f "$TMP"; exit 1
    fi
    $ZENIRIS pack "$TMP" > /dev/null 2>&1
    rm -f "$TMP"
    mv "$BASE._tmp_.zni" "$ZNI_OUT" 2>/dev/null
    echo "  OK: $(basename $ZN) -> $(basename $ZNI_OUT)"
done

if [ -d "$PROJETO/assets" ]; then
    cp -r "$PROJETO/assets/"* "$ASSETS_DIR/" 2>/dev/null
fi

echo ""
echo "[ZenDesktop] compilando runtime nativo..."
$CC \
    -O2 -std=c11 -Iinclude \
    src/token.c src/lexer.c src/parser.c src/runtime.c \
    src/zeniris_erro.c src/imports.c src/zen_core.c \
    src/zen_modulo.c src/zen_observar.c src/z_build.c \
    src/z_pack.c src/zen_loop.c src/zen_engine.c \
    src/main.c \
    -o "$BIN_DIR/$NOME" \
    -lm

if [ ! -f "$BIN_DIR/$NOME" ]; then
    echo "[ZenDesktop] ERRO compilando runtime"
    exit 1
fi

$STRIP "$BIN_DIR/$NOME" 2>/dev/null
echo "  OK: $NOME ($(ls -lh $BIN_DIR/$NOME | awk '{print $5}'))"

echo ""
echo "[ZenDesktop] gerando launcher..."
cat > "$BUILD_DIR/$NOME.sh" << LAUNCHER
#!/bin/bash
DIR="\$(dirname "\$(readlink -f "\$0")")"
"\$DIR/bin/$NOME" rodar "\$DIR/data/zni/main.zni"
LAUNCHER
chmod +x "$BUILD_DIR/$NOME.sh"

echo "[ZenDesktop] empacotando..."
TAR_OUT="$PROJETO/$NOME-desktop.tar.gz"
tar -czf "$TAR_OUT" -C "$BUILD_DIR" .

if [ -f "$TAR_OUT" ] && [ -s "$TAR_OUT" ]; then
    echo ""
    echo "[ZenDesktop] ================================"
    echo "[ZenDesktop] pacote: $TAR_OUT"
    echo "[ZenDesktop] tamanho: $(ls -lh $TAR_OUT | awk '{print $5}')"
    echo "[ZenDesktop] ================================"
else
    echo "[ZenDesktop] ERRO empacotando"
    exit 1
fi

rm -rf "$BUILD_DIR"

zen_desktop_windows() {
    PROJETO=$1
    CC_WIN=x86_64-w64-mingw32-gcc

    if ! which $CC_WIN > /dev/null 2>&1; then
        echo "[ZenDesktop] mingw32 nao instalado — rodando: pkg install mingw-w64"
        pkg install mingw-w64 -y
    fi

    NOME=$(basename "$PROJETO")
    BUILD_DIR="$PROJETO/build_windows"
    ZNI_DIR="$BUILD_DIR/data/zni"
    ASSETS_DIR="$BUILD_DIR/data/assets"
    BIN_DIR="$BUILD_DIR/bin"

    rm -rf "$BUILD_DIR"
    mkdir -p "$ZNI_DIR" "$ASSETS_DIR" "$BIN_DIR"

    find "$PROJETO" -maxdepth 1 -name "*.zn" | while read ZN; do
        BASE="${ZN%.zn}"
        TMP="$BASE._tmp_.zr"
        ZNI_OUT="$ZNI_DIR/$(basename $BASE).zni"
        cp "$ZN" "$TMP"
        ./build/zeniris build "$TMP" > /dev/null 2>&1
        ./build/zeniris pack "$TMP" > /dev/null 2>&1
        rm -f "$TMP"
        mv "$BASE._tmp_.zni" "$ZNI_OUT" 2>/dev/null
        echo "  OK: $(basename $ZN) -> $(basename $ZNI_OUT)"
    done

    $CC_WIN \
        -O2 -std=c11 -Iinclude \
        src/token.c src/lexer.c src/parser.c src/runtime.c \
        src/zeniris_erro.c src/imports.c src/zen_core.c \
        src/zen_modulo.c src/zen_observar.c src/z_build.c \
        src/z_pack.c src/zen_loop.c src/zen_engine.c \
        src/main.c \
        -o "$BIN_DIR/$NOME.exe" \
        -lm

    if [ -f "$BIN_DIR/$NOME.exe" ]; then
        TAR_OUT="$PROJETO/$NOME-windows.zip"
        cd "$BUILD_DIR" && zip -r "../$(basename $TAR_OUT)" . && cd - > /dev/null
        echo ""
        echo "[ZenDesktop] ================================"
        echo "[ZenDesktop] Windows: $TAR_OUT"
        echo "[ZenDesktop] tamanho: $(ls -lh $TAR_OUT | awk '{print $5}')"
        echo "[ZenDesktop] ================================"
        rm -rf "$BUILD_DIR"
    else
        echo "[ZenDesktop] ERRO compilando para Windows"
    fi
}

if [ "$2" = "--windows" ]; then
    zen_desktop_windows "$1"
fi
