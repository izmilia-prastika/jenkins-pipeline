FROM node:7.7.0

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ARG NODE_ENV
ENV NODE_ENV $NODE_ENV
COPY package.json /usr/src/app/
RUN npm install && npm cache clean
COPY hobbies.js server.js spec/* support/* /usr/src/app/

CMD [ "npm", "start" ]
