FROM node:lts-alpine as build-stage
WORKDIR /code
COPY package*.json ./
RUN npm install
COPY ./ .
RUN npm run build
CMD npm start
