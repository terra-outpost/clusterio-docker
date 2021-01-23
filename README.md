# Terra Outpost Clusterio Stuff

## Quick Start

Edit [env.sh](./env.sh)

Run
```sh
./bootstrap.sh
```

## Get auth token for user
```sh
docker-compose exec master npx clusteriomaster bootstrap generate-user-token USERNAME
```

## Create Instance Example

See [example.sh](./example.sh)

### Notes:

If you change ports for the cluster, you may need to restart master. You can do this with `docker-compose restart` and all should be well.
