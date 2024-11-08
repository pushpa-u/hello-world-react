FROM node:14

WORKDIR /app

COPY . .

RUN npm install

RUN npm install -g serve

CMD ["serve","-s","build"]

EXPOSE 3000