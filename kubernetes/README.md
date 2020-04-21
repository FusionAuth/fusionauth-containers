## Kubernetes

### Notice
This repository is community maintained; and is provided to assist in your deployment and management of FusionAuth. Use of this software is not covered under the FusionAuth license agreement and is provided "as is" without warranty.  https://fusionauth.io/license


### Single instance deployment

#### For Istio

```bash
kubectl apply --recursive -f kubernetes
```

#### Internal only

```bash
kubectl apply --recursive -f kubernetes/volume-claims
kubectl apply --recursive -f kubernetes/deployments
kubectl apply --recursive -f kubernetes/services
```
