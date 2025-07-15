module.exports = {
  apps: [{
    name: 'gestus-backend',
    script: 'server.js',
    cwd: '/var/www/gestus/backend',
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    env: {
      NODE_ENV: 'production',
      PORT: 3001,
      DATABASE_URL: 'postgresql://gestus_user:gestus_password_2024@localhost:5432/gestus',
      JWT_SECRET: 'gestus_jwt_secret_2024_production'
    },
    error_file: '/var/log/gestus-error.log',
    out_file: '/var/log/gestus-out.log',
    log_file: '/var/log/gestus-combined.log',
    time: true
  }]
}; 