#!/bin/bash

PROJETO=$1
if [ -z "$PROJETO" ]; then
    echo "Uso: ./zen_apk.sh <pasta_do_projeto>"
    exit 1
fi

if [ ! -d "$PROJETO" ]; then
    echo "[ZenAPK] pasta nao encontrada: $PROJETO"
    exit 1
fi

ZENIRIS=./build/zeniris
CC=aarch64-linux-android-clang
STRIP=aarch64-linux-android-strip
APKSIGNER=apksigner
ANDROID_JAR=/data/data/com.termux/files/usr/share/aapt/android-34.jar

NOME=$(basename "$PROJETO")
BUILD_DIR="$PROJETO/build_apk"
LIB_DIR="$BUILD_DIR/lib/arm64-v8a"
ASSETS_DIR="$BUILD_DIR/assets"
ZNI_DIR="$ASSETS_DIR/zni"

echo "[ZenAPK] iniciando build: $NOME"
echo ""

rm -rf "$BUILD_DIR"
mkdir -p "$LIB_DIR" "$ZNI_DIR"

echo "[ZenAPK] compilando .zn -> .zni..."
find "$PROJETO" -maxdepth 1 -name "*.zn" | while read ZN; do
    BASE="${ZN%.zn}"
    TMP="$BASE._tmp_.zr"
    ZNI_OUT="$ZNI_DIR/$(basename $BASE).zni"
    cp "$ZN" "$TMP"
    $ZENIRIS build "$TMP" > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "[ZenAPK] ERRO validando: $ZN"
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
echo "[ZenAPK] compilando runtime nativo arm64..."
$CC \
    -O2 -std=c11 -Iinclude \
    -shared -fPIC \
    src/token.c src/lexer.c src/parser.c src/runtime.c \
    src/zeniris_erro.c src/imports.c src/zen_core.c \
    src/zen_modulo.c src/zen_observar.c src/z_build.c \
    src/z_pack.c src/zen_loop.c src/zen_engine.c \
    -o "$LIB_DIR/libzeniris.so" \
    -lm

if [ ! -f "$LIB_DIR/libzeniris.so" ]; then
    echo "[ZenAPK] ERRO compilando runtime nativo"
    exit 1
fi

$STRIP "$LIB_DIR/libzeniris.so"
echo "  OK: libzeniris.so ($(ls -lh $LIB_DIR/libzeniris.so | awk '{print $5}'))"

echo ""
echo "[ZenAPK] gerando AndroidManifest.xml..."
cat > "$BUILD_DIR/AndroidManifest.xml" << MANIFEST
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.zeniris.$NOME"
    android:versionCode="1"
    android:versionName="1.0">
    <uses-sdk android:minSdkVersion="21" android:targetSdkVersion="34"/>
    <application
        android:label="$NOME"
        android:hasCode="false">
        <activity
            android:name="android.app.NativeActivity"
            android:exported="true">
            <meta-data android:name="android.app.lib_name" android:value="zeniris"/>
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
    </application>
</manifest>
MANIFEST

echo "[ZenAPK] empacotando com aapt2..."
APK_UNSIGNED="$BUILD_DIR/$NOME-unsigned.apk"
APK_FINAL="$PROJETO/$NOME.apk"

aapt2 link \
    -o "$APK_UNSIGNED" \
    -I "$ANDROID_JAR" \
    --manifest "$BUILD_DIR/AndroidManifest.xml" \
    -A "$ASSETS_DIR" \
    --min-sdk-version 21 \
    --target-sdk-version 34 \
    --version-code 1 \
    --version-name "1.0"

if [ ! -f "$APK_UNSIGNED" ]; then
    echo "[ZenAPK] ERRO no aapt2"
    exit 1
fi

aapt add "$APK_UNSIGNED" "$LIB_DIR/libzeniris.so"

echo "[ZenAPK] assinando APK..."
KEYSTORE="$HOME/.zeniris_keystore"
if [ ! -f "$KEYSTORE" ]; then
    echo "[ZenAPK] gerando keystore..."
    keytool -genkeypair \
        -keystore "$KEYSTORE" \
        -alias zeniris \
        -keyalg RSA -keysize 2048 \
        -validity 10000 \
        -storepass zeniris123 \
        -keypass zeniris123 \
        -dname "CN=Zeniris, O=Zeniris, C=BR" 2>/dev/null
fi

$APKSIGNER sign \
    --min-sdk-version 21 \
    --ks "$KEYSTORE" \
    --ks-pass pass:zeniris123 \
    --key-pass pass:zeniris123 \
    --out "$APK_FINAL" \
    "$APK_UNSIGNED"

if [ -f "$APK_FINAL" ] && [ -s "$APK_FINAL" ]; then
    echo ""
    echo "[ZenAPK] ================================"
    echo "[ZenAPK] APK gerado: $APK_FINAL"
    echo "[ZenAPK] tamanho:    $(ls -lh $APK_FINAL | awk '{print $5}')"
    echo "[ZenAPK] ================================"
else
    echo "[ZenAPK] ERRO na assinatura"
    exit 1
fi

rm -rf "$BUILD_DIR"
