#!/bin/sh

# Create the namespace
kubectl create namespace logging

# Create the base resources
kubectl create -f fluent-bit-service-account.yml
kubectl create -f fluent-bit-role.yml
kubectl create -f fluent-bit-role-binding.yml

# Create the config map
kubectl create -f fluent-bit-configmap.yml

# Create the daemon set
kubectl create -f fluent-bit-daemon-set.yml

