#!/bin/bash

# Script to update the IP address of a domain in dondominio.com
# The script requires the following environment variables:
# - DDNS_USERNAME: Username of the dondominio.com account
# - DDNS_API_KEY: Token to authenticate the API requests
# - DDNS_DOMAIN: Domain to update
# - PTIME: Time to wait between updates in minutes, hours or days (e.g. 5m, 1h, 1d)

# Check if the required environment variables are set
if [ -z "$DDNS_USERNAME" ] || [ -z "$DDNS_API_KEY" ] || [ -z "$DDNS_DOMAIN" ] ; then
    echo "The environment variables DDNS_USERNAME, DDNS_API_KEY and DDNS_DOMAIN are required"
    exit 1
fi

# Get the current IP address from the following endpoints, trying in order:
# - https://api.ipify.org
# - https://icanhazip.com
# - https://ifconfig.me/ip
# - https://ipecho.net/plain
# - https://ipinfo.io/ip
# - https://checkip.amazonaws.com

IP=$(curl -s https://api.ipify.org || curl -s https://icanhazip.com || curl -s https://ifconfig.me/ip || curl -s https://ipecho.net/plain || curl -s https://ipinfo.io/ip || curl -s https://checkip.amazonaws.com)

if [ -z "$IP" ] ; then
    echo "Failed to get the current IP address"
    exit 1
fi

# Get the current IP address from the domain
CURRENT_IP=$(dig +short "$DDNS_DOMAIN")

if [ -z "$CURRENT_IP" ] ; then    
    echo "Failed to get the current IP address of the domain"
fi

# Check if the IP address needs to be updated
if [ "$IP" = "$CURRENT_IP" ] ; then
    echo "The IP address has not changed"
    exit 0
fi

# Update the IP address of the domain
echo "Updating the IP address of the domain to $IP"
/app/dondominio/dondomcli.sh -u "$DDNS_USERNAME" -p "$DDNS_API_KEY" -h "$DDNS_DOMAIN"
