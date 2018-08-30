FROM node:alpine
RUN mkdir /app
WORKDIR /app

ADD .browserslistrc .
ADD babel.config.js .
ADD cypress.json .
ADD jest.config.js .
ADD package.json .
ADD postcss.config.js .
ADD tsconfig.json .
ADD tslint.json .
ADD yarn.lock .

RUN yarn install
ENTRYPOINT yarn serve