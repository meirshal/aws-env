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
  echo "$programname [-p <aws profile>] -b <base path> -s <service> -e <environment>"
  echo ""
  echo "  -b   Base path"
  echo "  -s   Service name"
  echo "  -e   Environment"
  echo "  -p   AWS profile (default: \"default\")"
  echo "  -h   Display this help"
  echo "  -v   Display version"
  exit 1
}

# get the options and set flags
while getopts "p:s:e:b:hv" OPTION; do
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
  b)
    base_path=$OPTARG
    ;;
  *)
    echo "Incorrect options provided"
    exit 1
    ;;
  esac
done

if [ -z "${service}" ] || [ -z "${environment}" ] || [ -z "${base_path}" ]; then
  usage
  exit 1
fi

create_exports () {
 AWS_PROFILE=${aws_profile} aws s3 cp s3://${base_path}/${service}/${environment}.yaml ./config.yaml --quiet
 ${parent_path}/parse-config-yaml.sh
}

exports=$(create_exports)
rm ./config.yaml
echo ${exports}
