#!/bin/bash

az group create -n aks -l northeurope

az network vnet subnet create --address-prefixes 10.2.1.0/24 \
--name aks-subnet \
--resource-group teamResources \
--vnet-name vnet

VNET_SUBNET_ID=$(az network vnet subnet show -g teamResources --vnet-name vnet -n aks-subnet --query id -o tsv)

# TODO
# specify version of AKS cluster
az aks create -n aks-team1 -g aks \
--node-count 3 \
--location northeurope \
--attach-acr registryrxt3043 \
--network-plugin azure \
--network-policy azure\
--generate-ssh-keys \
--enable-managed-identity \
--vnet-subnet-id ${VNET_SUBNET_ID}\
--zones 1 2 3
