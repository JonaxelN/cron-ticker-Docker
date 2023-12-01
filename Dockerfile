# Dependencias de desarrollo
FROM node:19.2-alpine3.16 as deps
# cd /app
WORKDIR /app
#Copia a /app
COPY package.json ./
#Instalar dependencias
RUN npm install

# Test y build
FROM node:19.2-alpine3.16 as builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .
#Realizar testing
RUN npm run test

# Dependencias de producción
FROM node:19.2-alpine3.16 as prod-deps
WORKDIR /app
COPY package.json ./
RUN npm install --prod

# Ejecutar la app
FROM node:19.2-alpine3.16 as runner
WORKDIR /app
COPY --from=prod-deps /app/node_modules ./node_modules
COPY app.js ./
COPY tasks/ ./tasks

#Correr el app
CMD [ "node", "app.js" ]