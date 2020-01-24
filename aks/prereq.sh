#!/bin/bash -e

# Maintainer: Omer Barel (jungo@jungopro.com)

######################################################################################################################################################################
#
# Please make sure az login is installed and run az login with a user with permission to create Resoruce Group and spn before executing this script
#
#
# Examples:
# ./prereq.sh -r jungo-aks -l westeurope -s 3******-3***-4***-***9-*********0b -f kubernetes.json
#
######################################################################################################################################################################

function show_help() {
    cat <<EOF
Please make sure az login is installed and run az login with a user with permission to create Resoruce Group and spn before executing this script
Examples:
./prereq.sh -r jungo-aks -l westeurope -s 3******-3***-4***-***9-*********0b -f kubernetes.json

EOF
}

while getopts r:l:s:f: opt
do
    case $opt in
        r) RG=$OPTARG ;;
        l) LOCATION=$OPTARG ;;
        s) SUB_ID=$OPTARG ;;
        f) FILENAME=$OPTARG ;;
        \?) printf "Unknown option: -$OPTARG" >&2
            show_help >&2
            exit 1
        ;;
        *)
            show_help >&2
            exit 1
        ;;
    esac
done

az deployment create \
  --location $LOCATION \
  --template-file 01-rg.json \
  --parameters rgName=$RG rgLocation=$LOCATION

az group deployment create \
  --resource-group $RG \
  --template-file 02-vnet.json

spn=$(az ad sp create-for-rbac --name "http://$RG-spn" --role="Contributor" --scopes="/subscriptions/$SUB_ID/resourceGroups/$RG")

ID=$(echo $spn | awk '{print $3}' | sed 's/\"//g' | sed 's/\,//g')
SECRET=$(echo $spn | awk '{print $9}' | sed 's/\"//g' | sed 's/\,//g')

aks-engine generate $FILENAME --set masterProfile.dnsPrefix=$RG,servicePrincipalProfile.clientId=$ID,servicePrincipalProfile.secret=$SECRET

az group deployment validate --resource-group $RG --template-file _output/$RG/azuredeploy.json --parameters _output/$RG/azuredeploy.parameters.json

az group deployment create --resource-group $RG --template-file _output/$RG/azuredeploy.json --parameters _output/$RG/azuredeploy.parameters.json


## TODO: Future work, when enabling AAG
# 
# az identity create -g $RG -n "$RG-AAG-identity"
# 
# az identity show -g $RG -n "$RG-AAG-identity"
# 
# az network application-gateway list --query '[].id'
# 
# az role assignment create \
#     --role Contributor \
#     --assignee <clientId> \
#     --scope <App-Gateway-ID>
# 
# az role assignment create \
#     --role Reader \
#     --assignee <clientId> \
#     --scope "/subscriptions/$SUB_ID/resourceGroups/$RG"