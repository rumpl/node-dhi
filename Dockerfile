#syntax=docker/dockerfile:1

# === Build stage: Install dependencies and build application ===#
FROM docker/dhi-node:23-alpine3.21-dev AS builder
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

# === Final stage: Create minimal runtime image ===#
FROM docker/dhi-node:23-alpine3.21
ENV PATH=/app/node_modules/.bin:$PATH

COPY --from=builder --chown=node:node /usr/src/app /app

WORKDIR /app

CMD ["node", "index.js"]