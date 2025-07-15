#!/bin/bash

# Script de Deploy Automático - Sistema SAAS Fluxo de Caixa
# VPS: 85.31.62.47
# GitHub: henriquewc/gestus

echo "🚀 Iniciando deploy automático..."
echo "📍 VPS: 85.31.62.47"
echo "📦 GitHub: henriquewc/gestus"

# Navegar para o diretório do projeto
cd /var/www/gestus

# Parar aplicação
echo "⏸️ Parando aplicação..."
pm2 stop gestus-backend

# Atualizar código do GitHub
echo "📥 Atualizando código do GitHub..."
git pull origin main

# Instalar dependências do backend
echo "📦 Instalando dependências do backend..."
cd backend
npm install

# Executar migrações do banco (se houver)
echo "🗄️ Executando migrações..."
npm run migrate

# Reiniciar backend
echo "🔄 Reiniciando backend..."
pm2 restart gestus-backend

# Instalar dependências do frontend
echo "📦 Instalando dependências do frontend..."
cd ../frontend
npm install

# Build do frontend
echo "🔨 Fazendo build do frontend..."
npm run build

# Verificar status
echo "✅ Deploy concluído!"
echo "🔧 Status da aplicação:"
pm2 status

echo "📊 Acesse: http://85.31.62.47"
echo "📝 Logs: pm2 logs gestus-backend" 