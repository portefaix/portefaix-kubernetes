# Cert-Manager

This stack is to automate certificate management using [cert-manager](https://cert-manager.io)

* [cert-manager CRDs](cert-manager-crds.md)
* [cert-manager](cert-manager.md)

<aside class="note warning">

<h1>Note</h1>

On the `cert-manager` overlay do not change namespace.

</aside>

Then you could install a [clusterissuer](./letsencrypt.md) to use Let's Encrypt
