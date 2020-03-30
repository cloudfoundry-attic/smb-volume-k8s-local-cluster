#! /bin/bash -ex

pushd ~/workspace/cf-for-k8s
  ./hack/generate-values.sh -d vcap.me > /tmp/cf-values.yml

  # create a config that has load balancer ingress replaced by a nodeport
  ytt -f ./config -f /tmp/cf-values.yml -f config-optional/remove-resource-requirements.yml -f config-optional/use-nodeport-for-ingress.yml > /tmp/dump.yml

  # note: this config will fail if ports 80 and 443 are not available on localhost
  kind create cluster --config=./deploy/kind/cluster.yml

  # deploy with kapp
  kapp deploy -a cf -f /tmp/dump.yml -y
popd

# wait a few seconds for capi to get its bearings
sleep 5

# login
cf api api.vcap.me --skip-ssl-validation
cf auth admin `yq -r .cf_admin_password /tmp/cf-values.yml`
cf enable-feature-flag diego_docker

# make an org and space
cf co o && cf target -o o && cf create-space s && cf target -s s
