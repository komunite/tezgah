# Dockerfile
FROM node:20-slim

WORKDIR /app

COPY . .

RUN npm install -g .

LABEL org.opencontainers.image.source="https://github.com/komunite/tezgah"
LABEL org.opencontainers.image.description="Tezgah CLI ve production-ready SaaS skill kiti"
LABEL org.opencontainers.image.licenses="MIT"

ENTRYPOINT ["tezgah"]
