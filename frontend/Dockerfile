FROM node:latest
RUN yarn global add @quasar/cli cors
WORKDIR /app
COPY . ./
RUN touch .env && yarn && yarn run lint --fix && quasar build
RUN yarn && yarn run lint --fix && quasar build
EXPOSE 4000
CMD [ "quasar", "serve", "dist/spa", "--history" ]