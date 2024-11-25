# GitGuardian NHI Helm Charts

## Installation

Add the repository to Helm with:

```shell
helm repo add gg-nhi https://gitguardian.github.io/nhi-explorer-helm-charts
```

Then install the explorer, with a values file (examples below):

```shell
helm upgrade explorer gg-nhi/nhi-explorer --install --values values.yml
```

An example values file that fetches from HashiCorp Vault:

```yaml
inventory:
  # Run every 15 minutes
  schedule: '*/15 * * * *'
  config:
    sources:
      vault-secrets:
        type: hashicorpvault
        vault_address: "https://your-vault-address-here"
        # Token configuration can be read from environment variables like so:
        auth_token: "${HASHICORP_VAULT_TOKEN}"
        fetch_all_versions: true
        path: "secret/"

# This needs to be created separately, and contain a `HASHICORP_VAULT_TOKEN` key with 
# the token to use.
envFrom:
  - secretRef:
      name: hashicorpvault-secrets
```

Other examples can be found in [charts/nhi-explorer/examples](charts/nhi-explorer/examples).


## Development

Install the [helm unittest plugin](https://github.com/helm-unittest/helm-unittest)

```shell
$ helm plugin install https://github.com/helm-unittest/helm-unittest.git
```
