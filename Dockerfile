FROM node:12-alpine as build
RUN apk add --update git
COPY . /app
WORKDIR /app
RUN npm install

FROM node:12-alpine
LABEL maintainer="Oleg@Fiksel.info"
WORKDIR app
RUN ln -s /config/config.json /app/config.json
RUN adduser -DHS app && \
    addgroup app && \
    addgroup app app
#RUN chown -R app /app
COPY --chown=app:app --from=build /app /app
USER app
EXPOSE 8090
VOLUME /config
VOLUME /data
ENTRYPOINT ["node", "/app/index.js"]
