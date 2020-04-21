## OpenShift

### Notice
This repository is community maintained; and is provided to assist in your deployment and management of FusionAuth. Use of this software is not covered under the FusionAuth license agreement and is provided "as is" without warranty.  https://fusionauth.io/license

#### How to use these files 

1. Use this [Dockerfile](./Dockerfile) to build openshift image for non-privileged containers
2. Update the [fusionauth-app.yaml](./fusionauth-app.yaml) definition to use the correct image
3. Update [fusionauth-route](./fusionauth-route.yaml) to use the correct hostname for the route
4. Create generic secret for fusionauth-db with `DATABASE_USER`, `DATABASE_PASSWORD`, `DATABASE_ROOT_PASSWORD`, `DATABASE_ROOT_USER` values
5. Deploy definitions `oc apply -n $namespace -R -f openshift` (this repo must be the current directory)
