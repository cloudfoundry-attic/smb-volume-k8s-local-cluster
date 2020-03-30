# CF for kind

Running `deploy.sh` in this directory spins up a kind cluster with ports 80 and
443 mapped, and deploys cf-for-k8s with the system domain "vcap.me" which
resolves to 127.0.0.1

Finally the script logs you into the new cf instance, enables `diego_docker` and
creates a new org and space for you.

## Prerequsites

- You must have docker running locally, and it must be configured to allow access
  to 8+ CPUs and 8+ GB RAM.
  (The default [settings on Docker for Mac](https://docs.docker.com/docker-for-mac/#resources)
  need to be increased).
- You must have [kind](https://github.com/kubernetes-sigs/kind) installed.
- You must have the cf cli installed.
- You must have [cf-for-k8s](https://github.com/cloudfoundry/cf-for-k8s) cloned to `~/workspace/cf-for-k8s`
- You must have ports 80 and 443 available, or fiddle with
  `~/workspace/cf-for-k8s/deploy/kind/cluster.yml` to choose different ports.
- You need [yq](https://pypi.org/project/yq/) installed or you will need to comment out the part of the script
  that logs into cf, and dig out the cf admin password manually.
