ARG BUILD_FROM
FROM $BUILD_FROM

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install dependencies
RUN apk add --no-cache \
    docker \
    docker-compose \
    bash \
    curl \
    gettext

# Copy files
COPY run.sh /
COPY docker-compose.yml /

# Make script executable
RUN chmod a+x /run.sh

# Labels
LABEL \
  io.hass.name="Visionect Server" \
  io.hass.description="Visionect Software Suite for e-ink displays" \
  io.hass.arch="armhf|aarch64|amd64|armv7|i386" \
  io.hass.type="addon" \
  io.hass.version="1.0.0"

CMD [ "/run.sh" ]
