#!/bin/bash

BASE_URL="https://raw.githubusercontent.com/Broly199372/Zeniris-Realease-/main"
INSTALL_DIR="$HOME/.zeniris"

echo "🌀 Instalando Zeniris 0.2.0..."
echo ""

mkdir -p "$INSTALL_DIR"

echo "Baixando runtime..."
curl -fsSL "$BASE_URL/zeniris" -o "$INSTALL_DIR/zeniris"
chmod +x "$INSTALL_DIR/zeniris"

echo "Baixando build tools..."
for SCRIPT in zen_build.sh zen_new.sh zen_run.sh zen_apk.sh zen_desktop.sh; do
    curl -fsSL "$BASE_URL/$SCRIPT" -o "$INSTALL_DIR/$SCRIPT"
    chmod +x "$INSTALL_DIR/$SCRIPT"
done

echo ""
echo "Configurando PATH..."
SHELL_RC="$HOME/.bashrc"
if ! grep -q "zeniris" "$SHELL_RC" 2>/dev/null; then
    echo "export PATH=\"\$HOME/.zeniris:\$PATH\"" >> "$SHELL_RC"
fi
export PATH="$HOME/.zeniris:$PATH"

echo ""
echo "✅ Zeniris instalado com sucesso!"
echo "   Reinicie o terminal ou execute: source ~/.bashrc"
echo ""
echo "Comandos disponíveis:"
echo "  zen_new <nome>     — criar projeto"
echo "  zen_build <arquivo>— compilar .zn"
echo "  zen_run <pasta>    — rodar projeto"
echo "  zen_apk <pasta>    — exportar Android"
echo "  zen_desktop <pasta>— exportar Desktop"
