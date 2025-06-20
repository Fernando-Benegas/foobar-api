# Technical assignment: Ship foobar-api

## Assignment description
The team wants to ship a Go program (https://github.com/containous/foobar-api), and expose its API through HTTPS.The team told you that the certificates should be in a PVC. The assignment is for you to deploy this program and expose it using Traefik.


## Components
- Kubernetes (K3s)
- Traefik (Ingress Controller)
- Certificate storage in PVC
- Prometheus + Grafana (Lightweight Monitoring)

## Architecture

- **Platform:** K3s (Kubernetes lightweight distribution)
- **Ingress:** Traefik using IngressRouteTCP
- **TLS:** Handled by the API (not the ingress)
- **Storage:** PVC mounted with certificates
- **Observability:** Probes (`/health`), basic logs

## Deployment steps

1. Clone the repository:
- git clone https://github.com/your-repo/foobar-api-deployment.git

2. Containerize the application
- docker build -t fernandobenegasa/foobar-api:latest . && docker push fernandobenegasa/foobar-api:latest

3. Create the TLS certificates:
- openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout certs/key.pem -out certs/cert.pem -subj "/CN=foobar-api/O=foobar-api"

4. Deploy the PVC for certs:
-  kubectl apply -f pvc.yaml

5. Deploy the API:
- kubectl apply -f deployment.yaml && kubectl apply -f service.yaml

6. Configure de Ingress:
- kubectl apply -f ingress.yaml

7. Deploy Prometheus and Grafana:
- kubectl apply -f prometheus.yaml && kubectl apply -f grafana.yaml

8. Set up Traefik metrics and Grafana UI:
- kubectl apply -f traefik-metrics.yaml && kubectl apply -f grafana-ingress.yaml

## Accessing the api and monitoring stack

### API Endpoint
- `https://34.162.161.217.sslip.io/api`

### Grafana Dashboard
- NodePort: `http://34.162.161.217:30300`
- Or via Ingress: `http://grafana.34.162.161.217.sslip.io`

Login credentials:
- **User:** admin
- **Password:** TBD

### Prometheus UI
- NodePort: `http://34.162.161.217:30090`
