
https://michaellin.me/backup-vault-with-raft-storage-on-kubernetes/


export VAULT_ADDR=http://vault.139.59.50.247.nip.io 
vault login


echo '
path "sys/storage/raft/snapshot" {
   capabilities = ["read"]
}' | vault policy write snapshot -


vault auth enable approle
vault write auth/approle/role/snapshot-agent token_ttl=2h token_policies=snapshot
vault read auth/approle/role/snapshot-agent/role-id -format=json | jq -r .data.role_id
vault write -f auth/approle/role/snapshot-agent/secret-id -format=json | jq -r .data.secret_id

role -id - > 38544664-69a6-9f68-5b9a-26f4c1c5fc8a
secret id -> f34ae636-f6b9-d0bd-51be-9f40203017ff

create secret for vault - base64 encoded
kubectl create -f vault-snapshot-secret.yaml -n service-cloud-uat





