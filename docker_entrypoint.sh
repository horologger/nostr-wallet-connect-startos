#!/bin/bash

# https://nwc.getalby.com/public/images/nwc-logo.svg

# 

#export NOSTR_PRIVKEY='blah' #the private key of this service. Should be a securely randomly generated 32 byte hex string.
#export CLIENT_NOSTR_PUBKEY='blah' #if set, this service will only listen to events authored by this public key. You can set this to your own nostr public key.

#export RELAY='blah' #default='blah' #"wss://relay.getalby.com/v1"
#export RELAY="wss://relay.getalby.com/v1"
export RELAY="wss://atl.purplerelay.com"

#export PUBLIC_RELAY='blah' #optional relay URL to be used in connection strings if RELAY is an internal URL
export LN_BACKEND_TYPE="LND"            #ALBY or LND
#export ALBY_CLIENT_SECRET= Alby OAuth client secret (used with the Alby backend)
#export ALBY_CLIENT_ID= Alby OAuth client ID (used with the Alby backend)
#export OAUTH_REDIRECT_URL= OAuth redirect URL (e.g. http://localhost:8080/alby/callback) (used with the Alby backend)
export LND_ADDRESS="lnd.embassy:10009"       #the LND gRPC address, eg. localhost:10009 (used with the LND backend)
export LND_CERT_FILE="/mnt/lnd/tls.cert"    #the location where LND's tls.cert file can be found (used with the LND backend)
export LND_MACAROON_FILE="/mnt/lnd/admin.macaroon" #the location where LND's admin.macaroon file can be found (used with the LND backend)
export COOKIE_SECRET="666" #a randomly generated secret string.
export DATABASE_URI="/data/nostr-wallet-connect.db" #a postgres connection string or sqlite filename. Default='blah' #nostr-wallet-connect.db (sqlite)
export PORT=8080 #the port on which the app should listen on (default='blah' #8080)


export LND_PATH="/mnt/lnd/admin.macaroon"
export CLN_PATH="/mnt/c-lightning/"
export TOR_ADDRESS=$(yq e '.tor-address' /data/start9/config.yaml)
export LAN_ADDRESS=$(yq e '.lan-address' /data/start9/config.yaml)
export LNBITS_BACKEND_WALLET_CLASS=$(yq e '.implementation' /data/start9/config.yaml)
export RELAY=$(yq e ".nostr-relay" /data/start9/config.yaml)

if [ $LNBITS_BACKEND_WALLET_CLASS == "LndRestWallet" ]; then
    MACAROON_HEADER="Grpc-Metadata-macaroon: $(xxd -ps -u -c 1000 /mnt/lnd/admin.macaroon)"
    if ! [ -f $LND_PATH ]; then
        echo "ERROR: Cannot find LND macaroon."
        exit 1
    else
        echo "Using LND"
    fi
elif [ $LNBITS_BACKEND_WALLET_CLASS == "CLightningWallet" ]; then
    if ! [ -d $CLN_PATH ]; then
        echo "ERROR: Cannot find Core Lightning path."
        exit 1
    else
        echo "Using CLN"
        export LND_ADDRESS="c-lightning.embassy:3001"       #the LND gRPC address, eg. localhost:10009 (used with the LND backend)
        export LND_CERT_FILE="/mnt/c-lightning/tls.cert"    #the location where LND's tls.cert file can be found (used with the LND backend)
        export LND_MACAROON_FILE="/mnt/c-lightning/access.macaroon" #the location where LND's admin.macaroon file can be found (used with the LND backend)
    fi
fi

# if [ "$CONFIG_LN_IMPLEMENTATION" = "LndRestWallet" ]; then
#     until curl --silent --fail --cacert /mnt/lnd/tls.cert --header "$MACAROON_HEADER" https://lnd.embassy:8080/v1/getinfo &>/dev/null
#     do
#         echo "LND Server is unreachable. Are you sure the LND service is running?" 
#         sleep 5
#     done
# fi

# Hard code Core Ligntning for now
        # export LND_ADDRESS="c-lightning.embassy:3001"       #the LND gRPC address, eg. localhost:10009 (used with the LND backend)
        # export LND_CERT_FILE="/mnt/c-lightning/tls.cert"    #the location where LND's tls.cert file can be found (used with the LND backend)
        # export LND_MACAROON_FILE="/mnt/c-lightning/access.macaroon" #the location where LND's admin.macaroon file can be found (used with the LND backend)


echo "Nostr Relay: " $RELAY
echo "LN Backend Type: " $LN_BACKEND_TYPE
echo "LN Address: " $LND_ADDRESS
echo "LND Cert: " $LND_CERT_FILE
echo "LND Macaroon: " $LND_MACAROON_FILE

#echo $COOKIE_SECRET
#echo $DATABASE_URI
#echo $PORT

# exec /bin/bash
exec /bin/main