# Multi-client interop scripts

Startup scripts for multiclient interop testnet. Currently only the scripts for nimbus and lighthouse have been kept up-to-date.

# Kubernetes any topology cluster

## Spin cluster with helm

### If you need a kubernetes local cluster use kind - *Optional*

https://kind.sigs.k8s.io/docs/user/quick-start/

```
GO111MODULE="on" go get sigs.k8s.io/kind@v0.8.1
kind create cluster
```

### Setup helm

```
kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller
```

### Load images (only if you use *kind*) - *Optional*

**Images are available on dockerhub actually, they are built daily, so this is completely optional**

```
cd scripts

docker build --target multinet-nimbus -t eth2clients/multinet-nimbus .
kind load docker-image multinet-nimbus --name kind

docker build --target multinet-lighthouse -t eth2clients/multinet-lighthouse .
kind load docker-image multinet-lighthouse --name kind

docker build --target multinet-prysm -t eth2clients/multinet-prysm .
kind load docker-image multinet-prysm --name kind
```

### Finally start the cluster

*Customize `multinet-cluster/values.yaml`*

```
helm install ./multinet-cluster  
```

## TODO

- [ ] Integrate eth2stats
- [ ] Allow external nodes in order to experiment
- [ ] Deploy to github actions image building

# Running just 3 nodes with docker-compose

```
cd scripts
docker-compose up
```

## Inspecting the source

Use the respective docker volumes, just simply attach from another container e.g.:
```
docker run -it --rm -v nimbus-source:/tmp/nimbus ubuntu bash
```
Using this trick you could even attach via visual studio code and SSH integration.


# License

CC0 (Creative Common Zero)

# Known issues

For some reason (due to the `build.rs` in `deposit_contract` project) lighthouse will need to build again (we built already in the Dockerfile...) the first time `docker-compose up` will run.
