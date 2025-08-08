ARG BUILD_FROM
FROM $BUILD_FROM

# Install dependencies
RUN apk add --no-cache \
    docker \
    docker-compose \
    bash \
    curl

# Copy run script
COPY run.sh /\nCOPY docker-compose.yml /\nCOPY .env.template /

RUN chmod a+x /run.sh

CMD [ "/run.sh" ]