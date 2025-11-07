# Build
FROM node:18 AS build
WORKDIR /app

# Instalar dependencias
COPY package*.json ./
RUN npm install
RUN npm install -g @angular/cli

# Copiar el resto del código
COPY . .

# Compilar Angular en modo producción
RUN ng build --configuration production

# Etapa 2: servidor web con Nginx
FROM nginx:alpine

# Copiar los archivos compilados (la carpeta 'browser')
COPY --from=build /app/dist/angular-conduit/browser /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
