FROM node:22-alpine

ENV NODE_ENV=production
ENV PORT=8080

WORKDIR /app

# Native dependencies used by transport packages.
RUN apk add --no-cache python3 make g++ 

# Use the exact package manager version declared by the project.
RUN corepack enable && corepack prepare pnpm@10.18.3 --activate

COPY package.json pnpm-lock.yaml ./
RUN pnpm install --prod --frozen-lockfile

COPY src ./src
COPY public ./public

EXPOSE 8080

CMD ["pnpm", "start"]
