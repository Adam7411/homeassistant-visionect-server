#!/usr/bin/with-contenv bashio

# Get configuration
ARCHITECTURE=$(bashio::config 'architecture')
VISIONECT_VERSION=$(bashio::config 'visionect_version')
POSTGRES_USER=$(bashio::config 'postgres_user')
POSTGRES_PASSWORD=$(bashio::config 'postgres_password')
POSTGRES_DB=$(bashio::config 'postgres_db')
SERVER_ADDRESS=$(bashio::config 'server_address')

bashio::log.info "Starting Visionect Server addon..."

# Detect architecture if auto
if [ "$ARCHITECTURE" = "auto" ]; then
    ARCH=$(uname -m)
    case $ARCH in
        aarch64|arm64)
            IMAGE_SUFFIX="-arm"
            bashio::log.info "Detected ARM64 architecture"
            ;;
        armv7l|armhf)
            IMAGE_SUFFIX="-arm"
            bashio::log.info "Detected ARM32 architecture"
            ;;
        x86_64|amd64)
            IMAGE_SUFFIX=""
            bashio::log.info "Detected x86_64 architecture"
            ;;
        *)
            bashio::log.warning "Unknown architecture: $ARCH, defaulting to x86_64"
            IMAGE_SUFFIX=""
            ;;
    esac
elif [ "$ARCHITECTURE" = "arm" ]; then
    IMAGE_SUFFIX="-arm"
else
    IMAGE_SUFFIX=""
fi

# Create environment file
cat > /data/.env << EOF
VISIONECT_IMAGE=visionect/visionect-server-v3:${VISIONECT_VERSION}${IMAGE_SUFFIX}
POSTGRES_USER=${POSTGRES_USER}
POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
POSTGRES_DB=${POSTGRES_DB}
SERVER_ADDRESS=${SERVER_ADDRESS}
EOF

# Ensure data directory exists
mkdir -p /data/pgdata

# Update docker-compose with environment variables
envsubst < /docker-compose.yml > /data/docker-compose.yml

bashio::log.info "Configuration:" 
bashio::log.info "  Architecture: ${ARCHITECTURE} (${IMAGE_SUFFIX:-x86_64})"
bashio::log.info "  Visionect Version: ${VISIONECT_VERSION}"
bashio::log.info "  Database: ${POSTGRES_DB}"

# Start services
cd /data
docker-compose up --remove-orphans

bashio::log.info "Visionect Server started successfully!"