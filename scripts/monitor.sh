#!/bin/bash

# Script de Monitoramento - Sistema SAAS Fluxo de Caixa
# VPS: 85.31.62.47

echo "📊 Monitoramento do Sistema Gestus"
echo "📍 VPS: 85.31.62.47"
echo "⏰ $(date)"
echo ""

# Status do sistema
echo "🖥️ STATUS DO SISTEMA:"
echo "CPU: $(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)%"
echo "RAM: $(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}')"
echo "Disco: $(df -h / | awk 'NR==2{print $5}')"
echo ""

# Status dos serviços
echo "🔧 STATUS DOS SERVIÇOS:"
echo "Nginx: $(systemctl is-active nginx)"
echo "PostgreSQL: $(systemctl is-active postgresql)"
echo "PM2: $(pm2 ping | grep -o 'pong' || echo 'offline')"
echo ""

# Status da aplicação
echo "📱 STATUS DA APLICAÇÃO:"
pm2 status
echo ""

# Logs recentes
echo "📝 ÚLTIMOS LOGS (últimas 10 linhas):"
pm2 logs gestus-backend --lines 10 --nostream
echo ""

# Conexões ativas
echo "🌐 CONEXÕES ATIVAS:"
netstat -tuln | grep :80
netstat -tuln | grep :443
netstat -tuln | grep :3001
echo ""

# Espaço em disco
echo "💾 ESPAÇO EM DISCO:"
df -h
echo ""

# Processos mais pesados
echo "⚡ PROCESSOS MAIS PESADOS:"
ps aux --sort=-%mem | head -5 