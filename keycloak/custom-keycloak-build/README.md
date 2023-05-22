### This folder contains the files required for keycloak plugins and login themes.

## To build and push the custom-sidecar keycloak:
```
docker build -f ThemeDockerfile  --platform linux/amd64 -t chub.cloud.gov.in/service-cloud-dev/keycloak:17.0.1-custom .

docker push chub.cloud.gov.in/service-cloud-dev/keycloak:17.0.1-custom
```
