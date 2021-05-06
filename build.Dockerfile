FROM node:15.12.0-alpine3.10

COPY . /application

WORKDIR /application

RUN false

RUN npm ci
