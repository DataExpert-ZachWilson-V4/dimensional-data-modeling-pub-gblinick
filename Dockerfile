FROM python:3.9-slim

ARG SCHEMA_NAME
ARG TRINO_SERVER
ARG TRINO_CATALOG
ARG TRINO_USERNAME
ARG TRINO_PASSWORD

ENV SCHEMA_NAME=${SCHEMA_NAME}
ENV TRINO_SERVER=${TRINO_SERVER}
ENV TRINO_CATALOG=${TRINO_CATALOG}
ENV TRINO_USERNAME=${TRINO_USERNAME}
ENV TRINO_PASSWORD=${TRINO_PASSWORD}

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

# Set the working directory in the container
WORKDIR /app

# Install java and trino using apt-get
RUN apt-get update && apt-get install -y default-jdk wget && \
    cd /usr/local/bin && \
    wget https://repo1.maven.org/maven2/io/trino/trino-cli/445/trino-cli-445-executable.jar && \
    mv trino-cli-*-executable.jar trino && \
    chmod +x trino

# Verify trino installation
RUN trino --version

# Install Python dependencies
COPY _app/requirements.txt .
RUN pip install -r requirements.txt 

# Copy necessary files
COPY ./submission/ ./submission/
COPY _app/ ./

# Create Trino schema
RUN trino --server=${TRINO_SERVER} \
    --catalog=${TRINO_CATALOG} \
    --user=${TRINO_USERNAME} --password \
    --execute "CREATE SCHEMA IF NOT EXISTS ${SCHEMA_NAME};"

CMD ["python", "src/trino_tests.py"]
