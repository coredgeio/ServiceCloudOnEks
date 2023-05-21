FROM alpine:latest
RUN apk add --no-cache curl jq
RUN wget -q https://releases.hashicorp.com/vault/1.12.0/vault_1.12.0_linux_amd64.zip && \
    unzip vault_1.12.0_linux_amd64.zip && \
    mv vault /usr/local/bin && \
    rm -f vault_1.12.0_linux_amd64.zip
CMD ["/bin/sh"]