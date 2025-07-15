#!/bin/bash

# Script de Instalação Rápida - Sistema SAAS Fluxo de Caixa
# Execute este script diretamente na VPS: 85.31.62.47

echo "🚀 Instalação Rápida - Sistema Gestus"
echo "📍 VPS: 85.31.62.47"

# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependências
sudo apt install -y curl wget git nginx postgresql postgresql-contrib

# Instalar Node.js
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Instalar PM2
sudo npm install -g pm2

# Criar estrutura
sudo mkdir -p /var/www/gestus
sudo chown $USER:$USER /var/www/gestus

# Clonar projeto
cd /var/www/gestus
git clone https://github.com/henriquewc/gestus.git .

# Configurar banco
sudo -u postgres psql -c "CREATE DATABASE gestus;"
sudo -u postgres psql -c "CREATE USER gestus_user WITH PASSWORD 'gestus_password_2024';"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE gestus TO gestus_user;"

# Instalar dependências
cd backend && npm install
cd ../frontend && npm install

# Configurar Nginx
sudo tee /etc/nginx/sites-available/gestus << EOF
server {
    listen 80;
    server_name 85.31.62.47;
    
    location / {
        root /var/www/gestus/frontend/build;
        try_files \$uri \$uri/ /index.html;
    }
    
    location /api {
        proxy_pass http://localhost:3001;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF

sudo ln -sf /etc/nginx/sites-available/gestus /etc/nginx/sites-enabled/
sudo rm -f /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

# Build frontend
cd /var/www/gestus/frontend
npm run build

# Iniciar backend
cd /var/www/gestus/backend
pm2 start ecosystem.config.js
pm2 startup
pm2 save

echo "✅ Instalação concluída!"
echo "🌐 Acesse: http://85.31.62.47" 