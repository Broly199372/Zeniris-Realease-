#!/bin/bash

NOME=$1
if [ -z "$NOME" ]; then
    echo "Uso: ./zen_new.sh <nome_do_projeto>"
    exit 1
fi

if [ -d "$NOME" ]; then
    echo "[ZenNew] pasta '$NOME' ja existe"
    exit 1
fi

mkdir -p "$NOME/assets"
mkdir -p "$NOME/mods"

cat > "$NOME/propriet.zn" << PROP
nomemod = $NOME
versao = 1.0.0
descricao = Projeto criado com Zeniris
autor = 
PROP

cat > "$NOME/main.zn" << MAIN
Inicio

Vida = 100;
Velocidade = 5,5;
Ativo = true;

Classe $NOME

Function Iniciar

$NOME.Rodando = On

Fim

Function Atualizar

$NOME.Rodando = On

Fim

Fim
MAIN

echo "[ZenNew] projeto criado: $NOME"
echo "[ZenNew] estrutura:"
echo "  $NOME/"
echo "  $NOME/main.zn"
echo "  $NOME/propriet.zn"
echo "  $NOME/assets/"
echo "  $NOME/mods/"
echo ""
echo "Para compilar:  ./zen_build.sh $NOME/main.zn"
echo "Para rodar:     ./zen_run.sh $NOME"
echo "Para APK:       ./zen_apk.sh $NOME"
echo "Para Desktop:   ./zen_desktop.sh $NOME"
