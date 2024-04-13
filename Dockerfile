# Use a specific version of the node image as base
FROM node:20.2.0-alpine@sha256:f25b0e9d3d116e267d4ff69a3a99c0f4cf6ae94eadd87f1bf7bd68ea3ff0bef7 as base

# Intermediate stage for building the application
FROM base as builder

# Install necessary build dependencies
RUN apk add --update --no-cache \
    python3 \
    make \
    g++ 

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install production dependencies
RUN npm install --only=production

# Final stage without grpc-health-probe-bin
FROM base as without-grpc-health-probe-bin

# Set the working directory
WORKDIR /usr/src/app

# Copy node_modules from the builder stage
COPY --from=builder /usr/src/app/node_modules ./node_modules

# Copy the rest of the application code
COPY . .

# Expose port 50051 (assuming this is the port your application listens on)
EXPOSE 50051

# Set the entry point for the container
ENTRYPOINT [ "node", "index.js" ]

# Final stage with grpc-health-probe-bin
FROM without-grpc-health-probe-bin as with-grpc-health-probe-bin

# Set the working directory
WORKDIR /usr/src/app

# Set the version of grpc_health_probe to download
ENV GRPC_HEALTH_PROBE_VERSION=v0.4.18

# Download and set executable permissions for grpc_health_probe
RUN wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe
