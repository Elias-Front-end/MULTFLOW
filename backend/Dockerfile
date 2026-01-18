FROM node:18-bookworm-slim AS global-deps-stage

WORKDIR /app

RUN apt-get update \
  && apt-get install -y wget gnupg nano ffmpeg chromium fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/* && npm install pm2@latest -g

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV NODE_ENV=dev
ENV CHROME_BIN=/usr/bin/chromium

FROM global-deps-stage AS develop-stage
COPY package*.json ./
RUN npm install

FROM develop-stage AS build-stage
COPY . .
RUN npm run build

FROM build-stage AS development-stage
ENV NODE_ENV=development
ENTRYPOINT ["npm", "run", "dev:server"]

FROM build-stage AS production-stage
ENV NODE_ENV=production
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT ["./docker-entrypoint.sh"]
