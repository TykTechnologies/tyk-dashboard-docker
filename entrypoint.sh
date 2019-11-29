#!/bin/bash

TYKDBCONF=/opt/tyk-dashboard/tyk_analytics.conf

# for backwards compatibility, set legacy variables to new ones
if [[ -n "${TYK_DB_HOSTCONFIG_GATEWAYHOSTNAME}" ]]; then
  export TYK_DB_HOSTCONFIG_OVERRIDEHOSTNAME="${TYK_DB_HOSTCONFIG_GATEWAYHOSTNAME}"
fi

if [[ -n "${TYK_DB_HOSTCONFIG_GENERATEHTTPS}" ]]; then
  export TYK_DB_HOSTCONFIG_GENERATESECUREPATHS="${TYK_DB_HOSTCONFIG_GENERATEHTTPS}"
fi

if [[ -n "${TYK_DB_HOSTCONFIG_USESTRICT}" ]]; then
  export TYK_DB_HOSTCONFIG_USESTRICTHOSTMATCH="${TYK_DB_HOSTCONFIG_USESTRICT}"
fi

if [[ -n "${TYK_DB_HOSTCONFIG_TYKAPI_HOST}" ]]; then
  export TYK_DB_HOSTCONFIG_TYKAPICONFIG_HOST="${TYK_DB_HOSTCONFIG_TYKAPI_HOST}"
fi

if [[ -n "${TYK_DB_HOSTCONFIG_TYKAPI_PORT}" ]]; then
  export TYK_DB_HOSTCONFIG_TYKAPICONFIG_PORT="${TYK_DB_HOSTCONFIG_TYKAPI_PORT}"
fi

if [[ -n "${TYK_DB_HOSTCONFIG_TYKAPI_SECRET}" ]]; then
  export TYK_DB_HOSTCONFIG_TYKAPICONFIG_SECRET="${TYK_DB_HOSTCONFIG_TYKAPI_SECRET}"
fi

if [[ -n "${TYK_DB_NODESECRET}" ]]; then
  export TYK_DB_SHAREDNODESECRET="${TYK_DB_NODESECRET}"
fi

# todo:
# TIB <-> IdentityBroker
# HttpServerOptions-SSLCiphers
# HttpServerOptions-PreferServerCiphers
# Hosts <-> RedisHosts


cd /opt/tyk-dashboard/
./tyk-analytics --conf=${TYKDBCONF}
