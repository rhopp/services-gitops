#!/bin/bash

source ./envfile


echo "Creating Pull Secret"
oc create secret generic global-pull-secret --type=kubernetes.io/dockerconfigjson --from-literal=.dockerconfigjson="$PULL_SECRET" -n hive

echo "Patching hive CR"
oc patch hiveconfig hive --type=merge --patch '{"spec": {"globalPullSecretRef": {"name": "global-pull-secret"}}}'

echo "Creating AWS creds secret"
oc create secret generic hive-aws-creds -n hive --from-literal=aws_access_key_id="$AWS_ACCESS_KEY_ID" --from-literal=aws_secret_access_key="$AWS_SECRET_ACCESS_KEY"


echo "Creating InstallConfig"

