# CDP Grafana Kubernetes deployment
Simple deploy of grafana to ACP with mutual TLS to allow our large format wall boards to connect and display metrics

Based on https://github.com/UKHomeOffice/acp-client-cert-demo

Buld the CA and certs
```bash
# generate a CA
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -days 10000 -out ca.crt -subj "/CN=example-ca"
# generate a client key pair
./generate.sh _CLIENT_NAME_
```

Deploy:
```bash
export CA_CRT=$(base64 ca.crt)
export AWS_CREDENTIALS=$(base64 credentials)
export GRAFANA_ADMIN_PASSWD=$(echo -n myadminpasword | base64)
kd \ 
-f secret.yml \
-f service.yml \
-f pvc.yml \
-f deployment.yml \
-f ingress.yml
```