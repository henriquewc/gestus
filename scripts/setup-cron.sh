#!/bin/bash

# Script de Configuração de Cron Jobs - Sistema SAAS Fluxo de Caixa

echo "⏰ Configurando Cron Jobs automáticos..."

# Criar diretório de logs se não existir
sudo mkdir -p /var/log
sudo touch /var/log/gestus-auto-update.log
sudo touch /var/log/gestus-backup.log

# Configurar backup diário às 2h da manhã
echo "💾 Configurando backup diário..."
(crontab -l 2>/dev/null; echo "0 2 * * * /var/www/gestus/scripts/backup.sh >> /var/log/gestus-backup.log 2>&1") | crontab -

# Configurar atualização automática às 4h da manhã
echo "🔄 Configurando atualização automática..."
(crontab -l 2>/dev/null; echo "0 4 * * * /var/www/gestus/scripts/auto-update.sh") | crontab -

# Configurar limpeza de logs semanais (domingo às 6h)
echo "🧹 Configurando limpeza de logs..."
(crontab -l 2>/dev/null; echo "0 6 * * 0 find /var/log/gestus-*.log -mtime +7 -delete") | crontab -

# Configurar monitoramento de saúde a cada 5 minutos
echo "📊 Configurando monitoramento..."
(crontab -l 2>/dev/null; echo "*/5 * * * * /var/www/gestus/scripts/monitor.sh >> /var/log/gestus-monitor.log 2>&1") | crontab -

# Verificar cron jobs configurados
echo "✅ Cron Jobs configurados:"
crontab -l

echo ""
echo "📋 Cron Jobs ativos:"
echo "• Backup diário: 02:00"
echo "• Atualização automática: 04:00"
echo "• Limpeza de logs: Domingo 06:00"
echo "• Monitoramento: A cada 5 minutos" 