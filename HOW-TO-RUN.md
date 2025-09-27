# How to run

## .env file

The .env is added to the git repo by encrypting the file.
Use the scripts "encrypt-for-git.sh" and "decrypt-for-git.sh" from the "utils-scripts" project for encrypting and decrypting

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

## Refresh installation

```shell
docker compose down 
docker compose pull
docker compose up --force-recreate -d
```

## Get Available models

### Antropic

```shell
# Get the API key from the .env file
export ANTHROPIC_API_KEY=$(grep '^ANTHROPIC_API_KEY=' .env | cut -d '=' -f2); \
# Fetch the latest models using the API and parse it to a single line comma seperated list
MODELS=$(curl https://api.anthropic.com/v1/models \
--header "x-api-key: $ANTHROPIC_API_KEY" \
--header "anthropic-version: 2023-06-01" \
| jq -r '.data[].id' | paste -sd ',' -); \
sed -i "s/^ANTHROPIC_MODELS=.*$/ANTHROPIC_MODELS=$MODELS/" .env # Update the .env file with the latest models
```



