FROM ghcr.io/getalby/nostr-wallet-connect:0.4.2
LABEL maintainer="andrewlunde <andrew.lunde@sap.com>"

# Start9 Packaging
RUN apk add --no-cache yq; \
    rm -f /var/cache/apk/*

COPY --chmod=755 docker_entrypoint.sh /usr/local/bin/
