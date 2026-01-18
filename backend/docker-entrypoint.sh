#!/bin/sh

# Execute database migrations
npx sequelize db:migrate

# Start the application using pm2-runtime
pm2-runtime start ecosystem.config.js
