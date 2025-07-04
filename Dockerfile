#syntax=docker/dockerfile:1

# === Build stage: Install dependencies and build application ===
FROM docker/dhi-node:24.3.0-alpine3.21-dev AS builder
WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

# === Final stage: Create minimal runtime image ===
FROM docker/dhi-node:24.3.0-alpine3.21
ENV PATH=/usr/src/app/node_modules/.bin:$PATH

WORKDIR /usr/src/app
COPY --from=builder /usr/src/app /usr/src/app

CMD ["node", "index.js"]