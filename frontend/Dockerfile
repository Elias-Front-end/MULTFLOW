# Build Stage
FROM node:16-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
# Garantir compatibilidade com Node 16 instalando sass (Dart Sass)
RUN npm install sass
COPY . .

# Argumentos de build que podem ser passados pelo Easypanel
ARG VUE_URL_API
ARG VUE_FACEBOOK_APP_ID

# Define as variáveis de ambiente durante o build para o Quasar
ENV VUE_URL_API=$VUE_URL_API
ENV VUE_FACEBOOK_APP_ID=$VUE_FACEBOOK_APP_ID

# Build da aplicação (gera arquivos em dist/spa)
RUN npx quasar build

# Production Stage
FROM nginx:stable-alpine AS production-stage
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
