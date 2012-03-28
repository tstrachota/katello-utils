#!/bin/sh

KAT_USER=${KAT_USER:-'admin'}
KAT_PASSWORD=${KAT_PASSWORD:-'admin'}
KAT_API_URL=${KAT_API_URL:-"https://localhost:3000/katello/api"}

CP_USER=${CP_USER:-'admin'}
CP_PASSWORD=${CP_PASSWORD:-'admin'}
CP_API_URL=${CP_API_URL:-'https://localhost:8443/candlepin'}
CP_OAUTH_KEY=${CP_OAUTH_KEY:-'katello'}
CP_OAUTH_SECRET=${CP_OAUTH_SECRET:-'your_oauth_secret'}

PULP_USER=${PULP_USER:-'admin'}
PULP_PASSWORD=${PULP_PASSWORD:-'admin'}
PULP_API_URL=${PULP_API_URL:-'https://localhost/pulp/api'}
