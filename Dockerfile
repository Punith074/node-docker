# # syntax=docker/Dockerfile:1

# FROM node:12.18.1
# ENV NODE_ENV=production

# WORKDIR /app

# COPY ["package.json", "package-lock.json", "./"]

# RUN npm install --production

# COPY . .

# CMD [ "node", "server.js" ]

# syntax=docker/Dockerfile:1
FROM node:14.15.4 as base

WORKDIR /code

COPY package.json package.json
COPY package-lock.json package-lock.json

FROM base as test
RUN npm ci
COPY . .
#CMD [ "npm", "run", "test"]
RUN npm run test

FROM base as prod
RUN npm ci --production
COPY . .
CMD [ "node", "server.js"]