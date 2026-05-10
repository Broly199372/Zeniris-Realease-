#!/bin/bash

ARQUIVO=$1
if [ -z "$ARQUIVO" ]; then
    echo "Uso: ./zen_build.sh <arquivo.zn>"
    exit 1
fi

if [ ! -f "$ARQUIVO" ]; then
    echo "[ZenBuild] arquivo nao encontrado: $ARQUIVO"
    exit 1
fi

ZENIRIS=./build/zeniris
DIR=$(dirname "$ARQUIVO")
BASE=$(basename "${ARQUIVO%.zn}")
ZNI="$DIR/$BASE.zni"
TMP="$DIR/$BASE._tmp_.zr"
TMP_ZNI="$DIR/$BASE._tmp_.zni"

if [ -f "$DIR/propriet.zn" ]; then
    echo "[ZenBuild] lendo propriet.zn..."
else
    echo "[ZenBuild] AVISO: propriet.zn nao encontrado"
fi

echo "[ZenBuild] validando $ARQUIVO..."
cp "$ARQUIVO" "$TMP"
$ZENIRIS build "$TMP"
if [ $? -ne 0 ]; then
    rm -f "$TMP"
    echo "[ZenBuild] falhou na validacao"
    exit 1
fi

echo "[ZenBuild] empacotando para $ZNI..."
$ZENIRIS pack "$TMP"
rm -f "$TMP"

if [ -f "$TMP_ZNI" ]; then
    mv "$TMP_ZNI" "$ZNI"
    echo "[ZenBuild] sucesso: $ZNI"
    $ZENIRIS info "$ZNI"
else
    echo "[ZenBuild] falhou no pack"
    exit 1
fi
