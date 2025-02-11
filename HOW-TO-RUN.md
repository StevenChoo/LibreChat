# How to run

## How to recreate container after local updates

```shell
docker compose up --force-recreate -d
```

## Setup rights & groups

```shell
sudo groupadd librechat
sudo usermod --append --groups librechat steven
sudo adduser --system --no-create-home --ingroup librechat librechat
sudo adduser --system --no-create-home --ingroup librechat ollama

```
