# 🚀 Sistema SAAS Fluxo de Caixa - Scripts de Deploy

## 📋 Informações do Projeto
- **VPS**: 85.31.62.47
- **GitHub**: henriquewc/gestus
- **Sistema**: Sistema SAAS de Fluxo de Caixa

## 📁 Scripts Disponíveis

### 1. `setup-vps.sh` - Configuração Inicial
Script completo para configurar a VPS do zero:
```bash
# Conectar na VPS via SSH
ssh root@85.31.62.47

# Baixar e executar o script
wget https://raw.githubusercontent.com/henriquewc/gestus/main/scripts/setup-vps.sh
chmod +x setup-vps.sh
./setup-vps.sh
```

### 2. `deploy.sh` - Deploy Automático
Script para atualizar o sistema:
```bash
# Na VPS
cd /var/www/gestus
./scripts/deploy.sh
```

### 3. `backup.sh` - Backup do Banco
Script para fazer backup automático:
```bash
# Na VPS
cd /var/www/gestus
./scripts/backup.sh
```

### 4. `monitor.sh` - Monitoramento
Script para verificar status do sistema:
```bash
# Na VPS
cd /var/www/gestus
./scripts/monitor.sh
```

## 🛠️ Comandos Úteis

### Verificar Status
```bash
# Status da aplicação
pm2 status

# Logs em tempo real
pm2 logs gestus-backend

# Status dos serviços
systemctl status nginx
systemctl status postgresql
```

### Reiniciar Serviços
```bash
# Reiniciar aplicação
pm2 restart gestus-backend

# Reiniciar Nginx
sudo systemctl restart nginx

# Reiniciar PostgreSQL
sudo systemctl restart postgresql
```

### Backup e Restore
```bash
# Fazer backup manual
sudo -u postgres pg_dump gestus > backup.sql

# Restaurar backup
sudo -u postgres psql gestus < backup.sql
```

## 🌐 Acesso ao Sistema
- **URL Principal**: http://85.31.62.47
- **Dashboard**: http://85.31.62.47/dashboard
- **API**: http://85.31.62.47/api

## 📊 Estrutura do Projeto
```
/var/www/gestus/
├── backend/          # API Node.js
├── frontend/         # React App
├── scripts/          # Scripts de deploy
└── database/         # Migrações e seeds
```

## 🔧 Configurações Importantes

### Variáveis de Ambiente (backend/.env)
```env
NODE_ENV=production
PORT=3001
DATABASE_URL=postgresql://gestus_user:gestus_password_2024@localhost:5432/gestus
JWT_SECRET=sua_chave_secreta_aqui
```

### Banco de Dados
- **Database**: gestus
- **User**: gestus_user
- **Password**: gestus_password_2024
- **Host**: localhost
- **Port**: 5432

## 📝 Logs e Monitoramento

### Logs da Aplicação
```bash
# Logs em tempo real
pm2 logs gestus-backend

# Logs do Nginx
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log

# Logs do PostgreSQL
sudo tail -f /var/log/postgresql/postgresql-*.log
```

### Monitoramento de Recursos
```bash
# CPU e RAM
htop

# Disco
df -h

# Processos
ps aux | grep node
```

## 🔒 Segurança

### Firewall
```bash
# Verificar status
sudo ufw status

# Adicionar porta
sudo ufw allow 3000
```

### SSL (quando tiver domínio)
```bash
# Instalar certificado
sudo certbot --nginx -d seu-dominio.com

# Renovar automaticamente
sudo crontab -e
# Adicionar: 0 12 * * * /usr/bin/certbot renew --quiet
```

## 🚨 Troubleshooting

### Aplicação não inicia
```bash
# Verificar logs
pm2 logs gestus-backend

# Verificar variáveis de ambiente
cat /var/www/gestus/backend/.env

# Verificar banco de dados
sudo -u postgres psql -d gestus -c "SELECT version();"
```

### Nginx não funciona
```bash
# Verificar configuração
sudo nginx -t

# Verificar logs
sudo tail -f /var/log/nginx/error.log

# Reiniciar
sudo systemctl restart nginx
```

### Banco de dados não conecta
```bash
# Verificar status
sudo systemctl status postgresql

# Verificar conexão
sudo -u postgres psql -c "\l"

# Verificar usuário
sudo -u postgres psql -c "\du"
```

## 📞 Suporte
Para problemas ou dúvidas, verifique:
1. Logs da aplicação
2. Status dos serviços
3. Configurações de rede
4. Espaço em disco
5. Permissões de arquivos 