#!/bin/bash

# Script de Backup Automático - Sistema SAAS Fluxo de Caixa
# VPS: 85.31.62.47

echo "💾 Iniciando backup automático..."
echo "📍 VPS: 85.31.62.47"

# Criar diretório de backup se não existir
mkdir -p /var/backups/gestus

# Data atual para nome do arquivo
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/var/backups/gestus/gestus_backup_$DATE.sql"

# Fazer backup do banco PostgreSQL
echo "🗄️ Fazendo backup do banco de dados..."
sudo -u postgres pg_dump gestus > $BACKUP_FILE

# Comprimir backup
echo "📦 Comprimindo backup..."
gzip $BACKUP_FILE

# Manter apenas os últimos 7 backups
echo "🧹 Limpando backups antigos..."
cd /var/backups/gestus
ls -t gestus_backup_*.sql.gz | tail -n +8 | xargs -r rm

echo "✅ Backup concluído!"
echo "📁 Arquivo: $BACKUP_FILE.gz"
echo "📊 Tamanho: $(du -h $BACKUP_FILE.gz | cut -f1)"

# Listar backups disponíveis
echo "📋 Backups disponíveis:"
ls -lh /var/backups/gestus/ 