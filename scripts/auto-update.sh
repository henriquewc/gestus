#!/bin/bash

# Script de Atualização Automática - Sistema SAAS Fluxo de Caixa
# Este script será executado automaticamente via cron

LOG_FILE="/var/log/gestus-auto-update.log"

echo "$(date): Iniciando atualização automática" >> $LOG_FILE

# Navegar para o projeto
cd /var/www/gestus

# Fazer backup antes da atualização
echo "$(date): Fazendo backup..." >> $LOG_FILE
sudo -u postgres pg_dump gestus > /var/backups/gestus/backup_before_update_$(date +%Y%m%d_%H%M%S).sql

# Atualizar código
echo "$(date): Atualizando código..." >> $LOG_FILE
git pull origin main >> $LOG_FILE 2>&1

# Instalar dependências backend
echo "$(date): Instalando dependências backend..." >> $LOG_FILE
cd backend
npm install >> $LOG_FILE 2>&1

# Reiniciar backend
echo "$(date): Reiniciando backend..." >> $LOG_FILE
pm2 restart gestus-backend >> $LOG_FILE 2>&1

# Instalar dependências frontend
echo "$(date): Instalando dependências frontend..." >> $LOG_FILE
cd ../frontend
npm install >> $LOG_FILE 2>&1

# Build frontend
echo "$(date): Fazendo build frontend..." >> $LOG_FILE
npm run build >> $LOG_FILE 2>&1

echo "$(date): Atualização concluída" >> $LOG_FILE
echo "----------------------------------------" >> $LOG_FILE 