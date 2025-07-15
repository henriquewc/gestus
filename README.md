# 🚀 Gestus - Sistema SAAS de Fluxo de Caixa

Sistema completo para gestão de fluxo de caixa, controle de boletos a pagar, receitas e relatórios financeiros.

## 📋 Funcionalidades

### ✅ Dashboard
- Resumo financeiro em tempo real
- Gráficos interativos de receitas e despesas
- Calendário financeiro com vencimentos
- Lista de boletos pendentes

### ✅ Gestão de Boletos
- Cadastro de boletos a pagar
- Controle de status (Pendente/Pago)
- Suporte a boletos recorrentes
- Categorização por tipo de despesa

### ✅ Gestão de Receitas
- Cadastro de receitas
- Suporte a receitas recorrentes
- Controle de datas de entrada

### ✅ Configurações
- Tipos de despesa personalizáveis
- Centros de custo hierárquicos
- Gestão de usuários por empresa
- Níveis de acesso diferenciados

### ✅ Relatórios
- Relatório de fluxo de caixa
- Exportação para Excel e PDF
- Filtros por período e categoria

## 🛠️ Tecnologias

### Backend
- **Node.js** com Express
- **PostgreSQL** como banco de dados
- **Sequelize** como ORM
- **JWT** para autenticação
- **bcryptjs** para criptografia

### Frontend
- **React 18** com hooks
- **Tailwind CSS** para estilização
- **Recharts** para gráficos
- **React Router** para navegação
- **React Query** para cache de dados

### Infraestrutura
- **Nginx** como proxy reverso
- **PM2** para gerenciamento de processos
- **PostgreSQL** para banco de dados
- **Cron** para tarefas automáticas

## 🚀 Instalação

### Pré-requisitos
- Node.js 18+
- PostgreSQL 12+
- Nginx
- PM2

### Instalação Rápida na VPS
```bash
# Clone o repositório
git clone https://github.com/henriquewc/gestus.git
cd gestus

# Execute o script de instalação
chmod +x scripts/setup-vps.sh
./scripts/setup-vps.sh
```

### Instalação Manual

#### 1. Backend
```bash
cd backend
npm install
cp env.example .env
# Configure as variáveis de ambiente
npm run migrate
npm start
```

#### 2. Frontend
```bash
cd frontend
npm install
npm run build
```

#### 3. Configuração do Nginx
```bash
# Copie a configuração do Nginx
sudo cp scripts/nginx.conf /etc/nginx/sites-available/gestus
sudo ln -s /etc/nginx/sites-available/gestus /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

## 📊 Estrutura do Projeto

```
gestus/
├── backend/                 # API Node.js
│   ├── controllers/        # Controladores
│   ├── models/            # Modelos Sequelize
│   ├── routes/            # Rotas da API
│   ├── middleware/        # Middlewares
│   ├── database/          # Migrações e seeds
│   └── server.js          # Servidor principal
├── frontend/              # Aplicação React
│   ├── src/
│   │   ├── components/    # Componentes reutilizáveis
│   │   ├── pages/         # Páginas da aplicação
│   │   ├── contexts/      # Contextos React
│   │   ├── hooks/         # Hooks customizados
│   │   ├── services/      # Serviços de API
│   │   └── utils/         # Utilitários
│   └── public/            # Arquivos públicos
├── scripts/               # Scripts de automação
│   ├── setup-vps.sh       # Instalação completa
│   ├── deploy.sh          # Deploy automático
│   ├── backup.sh          # Backup do banco
│   ├── monitor.sh         # Monitoramento
│   └── setup-cron.sh      # Configuração de cron
└── docs/                  # Documentação
```

## 🔧 Configuração

### Variáveis de Ambiente (Backend)
```env
NODE_ENV=production
PORT=3001
DATABASE_URL=postgresql://user:password@localhost:5432/gestus
JWT_SECRET=your_jwt_secret
JWT_EXPIRES_IN=7d
```

### Banco de Dados
O sistema utiliza PostgreSQL com as seguintes tabelas principais:
- `users` - Usuários do sistema
- `companies` - Empresas
- `expense_types` - Tipos de despesa
- `cost_centers` - Centros de custo
- `bills` - Boletos a pagar
- `revenues` - Receitas
- `bill_status_history` - Histórico de status

## 📝 Scripts Disponíveis

### Desenvolvimento
```bash
# Backend
npm run dev          # Modo desenvolvimento
npm run migrate      # Executar migrações
npm run seed         # Popular banco com dados de teste

# Frontend
npm start            # Servidor de desenvolvimento
npm run build        # Build de produção
```

### Produção
```bash
# Scripts de automação
./scripts/deploy.sh      # Deploy automático
./scripts/backup.sh      # Backup do banco
./scripts/monitor.sh     # Monitoramento
./scripts/setup-cron.sh  # Configurar cron jobs
```

## 🔒 Segurança

- Autenticação JWT
- Rate limiting
- Validação de entrada
- Criptografia de senhas
- Headers de segurança (Helmet)
- CORS configurado

## 📈 Monitoramento

O sistema inclui:
- Logs estruturados
- Monitoramento de performance
- Backup automático
- Health checks
- Alertas de erro

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📞 Suporte

Para suporte, entre em contato através do GitHub ou email.

---

**Desenvolvido com ❤️ por Henrique WC**