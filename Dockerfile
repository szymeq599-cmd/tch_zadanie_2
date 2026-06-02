# syntax=docker/dockerfile:1.7

# ---------------------- ETAP 1:  
FROM node:20-bookworm-slim AS builder

# Informacja o autorze zgodna ze standardem OCI
LABEL org.opencontainers.image.authors="Szymon Dobrasiewicz"

WORKDIR /app

# Kopiujemy tylko pliki potrzebne do instalacji zależności
COPY package*.json ./

# Instalacja tylko zależności produkcyjnych z wykorzystaniem cache
RUN --mount=type=cache,target=/root/.npm \
    npm install --only=production

# Kopiujemy resztę plików źródłowych
COPY . .

# wykorzystanie BuildKit Secret
RUN --mount=type=secret,id=buildinfo \
    cat /run/secrets/buildinfo > /tmp/buildinfo.txt

# ---------------------- ETAP 2:  
FROM node:20-bookworm-slim

WORKDIR /app

# Kopiujemy zainstalowane moduły i kod z etapu budowania
COPY --from=builder /app /app

ENV PORT=3030

EXPOSE 3030

# Healthcheck 
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
 CMD node -e "require('http').get('http://localhost:3030', (r)=>{process.exit(r.statusCode===200?0:1)})"

CMD ["node","app.js"]
