## Creating a new connection

1. Click `Launch UI` to launch your private NWC website.
2. Click `Connect App`.
3. Name the connection after the client app that will be using it. For example, if you plan to connect your private noStrudel client, you should name this connection `noStrudel`.
4. Optionally adjust the permissions, monthly budget, and expiration of the connection.
5. Click `Next` to save the connection.
6. Use the generated connection secret to connect your client app. You can delete the connection at any time to revoke access.

## Connecting your client app

1. In your Nostr client app, find the setting for connecting your lightning node and select `Nostr Wallet Connect`. For noStrudel, this is in Settings -> Lightning.
2. Provide the connection secret generated from the instructions above either by scanning the QR code or copy/pasting the secret.
3. Done. You can now zapp and boost using your own lightning node.

## Getting Help

For more information, see the [Alby Nostr Wallet Connect](https://nwc.dev/).

You can also ask for assistance in the [Start9 community chats](https://start9.com/contact).
