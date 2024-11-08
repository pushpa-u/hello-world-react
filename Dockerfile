FROM node:14

WORKDIR /app

COPY . .

RUN npm install

RUN npm install -g serve

CMD ["npm","start"]

EXPOSE 3000