# AKS-Engine Setup

## General Information

*serviceA == bitcoin*:

A simple flask app written in python that retrieves the price of bitcoin every minute and prints it  
Every 10 minutes it will print the average price for the last 10 minutes

*serviceB == nginx*

A simple "hello world" nginx with no special config. Used to demonstrate: 
- app redirect to a sub-path using ingress controller annotations (/serviceb)
- network policy enforcement

## How To Run

- Download and install az cli
- Run az login with user with permissions to create resource group and spn
- Run the script ./aks/prereq.sh

## Ref

[schema](https://github.com/Azure/aks-engine/blob/81175cc0f399f822e79b499cc2f5465b1f317275/docs/topics/clusterdefinitions.md)

RSA-PriaveKey: /Users/omerbarel/.ssh/aks-engine-rsa
RSA-PublicKey: 

```
cat /Users/omerbarel/.ssh/aks-engine-rsa.pub

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDsVUBmlYlCX3nMMY+gwwS5hrGuMG+bw/K0n+f6F+g0uqTuCsQSuVfI4pqbHf+vIQLm0ZJjQtAPEcGCp2ryPbIePZ/gqhbeHfd/SbQWcVEruoOXBd2jdYzyrDGJYmJqTddcylpo7yt8r5CKxE/xTJFDRE41vXfMkrXDlhsgyyj5IOtn8Q5j4n1VV9MaUDJmVsLhh+iBrTIYRhyrYbLRDAcRBnArJiS59kN8Kjm1L7DVDgaFiCFyn5SFaBY//hlfzpcxUgLKhaZgR/bp01Z4IW3UGu5roAuHi2W71ecn39As7nkn1WHhWnTVDe8mSYVcdMuMeN1J08ciEln2B7jAR5ux omerbarel@omers-macpro-8.local
```

