FROM golang:1.20-alpine as builder
LABEL maintainer="andrewlunde <andrew.lunde@sap.com>"
FROM horologger/nostr-wallet-connect:v0.4.1

# Move to working directory /build
WORKDIR /build

# Copy the code into the container
COPY . .

RUN apk update
RUN apk add --no-cache bash
RUN apk add yq xxd curl jq

# Start a new, final image to reduce size.
#FROM alpine as final

EXPOSE 8080

# Start9 Packaging
RUN rm -f /docker_entrypoint.sh
ADD ./docker_entrypoint.sh /bin/docker_entrypoint.sh
RUN chmod a+x /bin/docker_entrypoint.sh

# Run docker_entrypoint.sh
ENTRYPOINT ["/bin/docker_entrypoint.sh"]