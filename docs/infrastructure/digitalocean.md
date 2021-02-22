# Digital Ocean

!!! info
    Work In Progress

## Setup

* Create a [Space](https://cloud.digitalocean.com/spaces) for your Terraform State.
* Create the [Space Access Keys](https://cloud.digitalocean.com/account/api/tokens)
* Create the [API Personal Token](https://cloud.digitalocean.com/account/api/tokens)

Configure Portefaix environment file `${HOME}/.config/portefaix/portefaix.sh`:

```shell
# Digital Ocean
export SPACES_ACCESS_KEY_ID="xxxxxxx"
export SPACES_SECRET_ACCESS_KEY="xxxxxxxx"
export DIGITALOCEAN_TOKEN="xxxxxxxxxxxx"
```

And load environment :

```shell
❯ . ./portefaix.sh
```
