
# Shopify App-Proxy Example

Steps to get up and running:

1. Create a shopify app if you haven't already.
2. Add the file "secrets.json" to the directory above this one, filling it with your app's shared secret:
    ```json
    {
        "shopify_shared_secret": "your shared secret here"
    }
    ```
4. `npm install`
3. Run the server with `node index.js`. Note: your server needs to be publicly accessible so shopify can send proxy requests to it. I recommend a [cloud9 IDE](https://c9.io) workspace.
4. Add the proxy url `"#{your_server_url}/proxy"` to your shopify app on the app settings page.
5. Install the app on your shopify store.

Now you should be able to visit the proxy url on your store, and get a response like this:

>This is the proxy page for #{your_store_name}.

## Signature Verification

If you visit `#{your_server_url}/proxy` directy, you will get a signature validation error:

>Signature validation for shopify proxy request failed

## License
MIT (see LICENSE file)