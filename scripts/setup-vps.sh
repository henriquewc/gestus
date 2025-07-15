#!/bin/bash

# Script de Configuração Completa - Sistema SAAS Fluxo de Caixa
# VPS: 85.31.62.47
# GitHub: henriquewc/gestus

echo "🚀 Iniciando configuração do Sistema SAAS Fluxo de Caixa..."
echo "📍 VPS: 85.31.62.47"
echo "📦 GitHub: henriquewc/gestus"

# Atualizar sistema
echo "📦 Atualizando sistema..."
sudo apt update && sudo apt upgrade -y

# Instalar dependências básicas
echo "🔧 Instalando dependências..."
sudo apt install -y curl wget git unzip software-properties-common apt-transport-https ca-certificates gnupg lsb-release

# Instalar Node.js 18.x
echo "📦 Instalando Node.js 18.x..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Instalar PostgreSQL
echo "🗄️ Instalando PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib

# Instalar Nginx
echo "🌐 Instalando Nginx..."
sudo apt install -y nginx

# Instalar PM2 para gerenciamento de processos
echo "⚡ Instalando PM2..."
sudo npm install -g pm2

# Instalar Certbot para SSL
echo "🔒 Instalando Certbot..."
sudo apt install -y certbot python3-certbot-nginx

# Configurar firewall
echo "🔥 Configurando firewall..."
sudo ufw allow ssh
sudo ufw allow 80
sudo ufw allow 443
sudo ufw --force enable

# Criar diretório do projeto
echo "📁 Criando estrutura do projeto..."
sudo mkdir -p /var/www/gestus
sudo chown $USER:$USER /var/www/gestus

# Clonar repositório
echo "📥 Clonando repositório..."
cd /var/www/gestus
git clone https://github.com/henriquewc/gestus.git .

# Configurar PostgreSQL
echo "🗄️ Configurando PostgreSQL..."
sudo -u postgres psql -c "CREATE DATABASE gestus;"
sudo -u postgres psql -c "CREATE USER gestus_user WITH PASSWORD 'gestus_password_2024';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE gestus TO gestus_user;"
sudo -u postgres psql -c "ALTER USER gestus_user CREATEDB;"

# Instalar dependências do backend
echo "📦 Instalando dependências do backend..."
cd /var/www/gestus/backend
npm install

# Instalar dependências do frontend
echo "📦 Instalando dependências do frontend..."
cd /var/www/gestus/frontend
npm install

# Configurar variáveis de ambiente
echo "⚙️ Configurando variáveis de ambiente..."
cd /var/www/gestus/backend
cp .env.example .env

# Configurar Nginx
echo "🌐 Configurando Nginx..."
sudo tee /etc/nginx/sites-available/gestus << EOF
server {
    listen 80;
    server_name 85.31.62.47;

    # Frontend
    location / {
        root /var/www/gestus/frontend/build;
        try_files \$uri \$uri/ /index.html;
    }

    # Backend API
    location /api {
        proxy_pass http://localhost:3001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Ativar site
sudo ln -sf /etc/nginx/sites-available/gestus /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t && sudo systemctl restart nginx

# Configurar PM2
echo "⚡ Configurando PM2..."
cd /var/www/gestus/backend
pm2 start ecosystem.config.js
pm2 startup
pm2 save

# Build do frontend
echo "🔨 Fazendo build do frontend..."
cd /var/www/gestus/frontend
npm run build

echo "✅ Configuração concluída!"
echo "🌐 Acesse: http://85.31.62.47"
echo "📊 Dashboard: http://85.31.62.47/dashboard"
echo "🔧 Para verificar status: pm2 status"
echo "📝 Logs: pm2 logs" 