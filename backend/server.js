const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware de segurança
app.use(helmet());
app.use(cors());
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutos
  max: 100 // limite de 100 requests por IP
});
app.use('/api/', limiter);

// Importar rotas
const authRoutes = require('./routes/auth');
const userRoutes = require('./routes/users');
const companyRoutes = require('./routes/companies');
const expenseTypeRoutes = require('./routes/expenseTypes');
const costCenterRoutes = require('./routes/costCenters');
const billRoutes = require('./routes/bills');
const revenueRoutes = require('./routes/revenues');
const dashboardRoutes = require('./routes/dashboard');
const reportRoutes = require('./routes/reports');

// Middleware de autenticação
const authMiddleware = require('./middleware/auth');

// Rotas públicas
app.use('/api/auth', authRoutes);

// Rotas protegidas
app.use('/api/users', authMiddleware, userRoutes);
app.use('/api/companies', authMiddleware, companyRoutes);
app.use('/api/expense-types', authMiddleware, expenseTypeRoutes);
app.use('/api/cost-centers', authMiddleware, costCenterRoutes);
app.use('/api/bills', authMiddleware, billRoutes);
app.use('/api/revenues', authMiddleware, revenueRoutes);
app.use('/api/dashboard', authMiddleware, dashboardRoutes);
app.use('/api/reports', authMiddleware, reportRoutes);

// Rota de health check
app.get('/api/health', (req, res) => {
  res.json({ 
    status: 'OK', 
    timestamp: new Date().toISOString(),
    version: '1.0.0'
  });
});

// Middleware de tratamento de erros
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Erro interno do servidor',
    message: process.env.NODE_ENV === 'development' ? err.message : 'Algo deu errado'
  });
});

// Rota 404
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Rota não encontrada' });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`🚀 Servidor rodando na porta ${PORT}`);
  console.log(`📊 Ambiente: ${process.env.NODE_ENV || 'development'}`);
  console.log(`🌐 URL: http://localhost:${PORT}`);
});

module.exports = app; 