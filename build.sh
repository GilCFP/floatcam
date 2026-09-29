#!/bin/bash

APP_NAME="FloatCam"
APP_BUNDLE="$APP_NAME.app"
MACOS_DIR="$APP_BUNDLE/Contents/MacOS"
RESOURCES_DIR="$APP_BUNDLE/Contents/Resources"

echo "🧹 Limpando build anterior..."
rm -rf "$APP_BUNDLE"

echo "📂 Criando estrutura de diretórios..."
mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

echo "🔨 Compilando o código Swift..."
# Compilar para arquitetura do Mac atual (Apple Silicon ou Intel)
swiftc FloatCamApp.swift CameraManager.swift ContentView.swift -o "$MACOS_DIR/$APP_NAME" -target $(uname -m)-apple-macosx11.0 -module-cache-path ./module-cache

echo "📄 Copiando o Info.plist..."
cp Info.plist "$APP_BUNDLE/Contents/"

echo "✅ Build concluído com sucesso: $APP_BUNDLE criado na pasta atual."
echo "Para abrir o aplicativo, dê um duplo clique em '$APP_BUNDLE' no Finder ou execute: open $APP_BUNDLE"
