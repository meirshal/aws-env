#!/usr/bin/env bash

set -o pipefail

programname=$0
version=1.0.0
aws_profile='default'
environment=$NODE_ENV
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

version() {
  echo "${version}"
}

usage() {
  echo "Usage:"
  echo ""
  echo "$programname [-p <aws profile>] -s <service name> -e <environment>"
  echo ""
  echo "  -s   Service name"
  echo "  -p   AWS profile (default: \"default\")"
  echo "  -h   Display this help"
  echo "  -v   Display version"
  exit 1
}

# get the options and set flags
while getopts "p:s:e:hv" OPTION; do
  case $OPTION in
  v)
    version
    exit 0
    ;;
  h)
    usage
    exit 1
    ;;
  p)
    aws_profile=$OPTARG
    ;;
  s)
    service=$OPTARG
    ;;
  e)
    environment=$OPTARG
    ;;
  *)
    echo "Incorrect options provided"
    exit 1
    ;;
  esac
done

if [ -z "${service}" ] || [ -z "${environment}" ]; then
  usage
  exit 1
fi

create_exports () {
 AWS_PROFILE=${aws_profile} aws secretsmanager get-secret-value --secret-id "${service}-${environment}" | \
 jq '.SecretString' | \
 sed 's/\\"/\"/g; s/\"{/{/g; s/\}"/}/g' | \
 ${parent_path}/parse-secrets-json.sh
}

exports=$(create_exports)
echo ${exports}
