#!/usr/bin/env bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

usage() {
  echo "Usage:"
  echo ""
  echo "$programname -s <service name> [-b <base path in S3>] [-e <environment>] [-t secret|non_secret|all] [-p <aws profile>]"
  echo ""
  echo "  -s   Service name"
  echo "  -b   Base path"
  echo "  -p   AWS profile (default: \"default\")"
  echo "  -e   Environment"
  echo "  -t   Fetch secrets only (secret), non-secrets only (non_secret) or both (all) (default: all)"
  echo "  -h   Display this help"
  echo "  -v   Display version"
  exit 1
}

aws-env () {
  programname=$0
  version=1.0.0
  aws_profile='default'
  environment=$NODE_ENV
  type=all
  parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

  version() {
    echo "${version}"
  }

  # get the options and set flags
  while getopts "p:s:e:b:t:hv" OPTION; do
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
    t)
      type=$OPTARG
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

  case ${type} in
  secret)
    ${parent_path}/secrets/secrets.sh -p ${aws_profile} -s ${service} -e ${environment}
    ;;
  non_secret)
    ${parent_path}/config/config.sh -p ${aws_profile} -s ${service} -e ${environment} -b ${base_path}
    ;;
  all)
    ${parent_path}/secrets/secrets.sh -p ${aws_profile} -s ${service} -e ${environment}
    ${parent_path}/config/config.sh -p ${aws_profile} -s ${service} -e ${environment} -b ${base_path}
    ;;
  *)
    usage
    exit 1
    ;;
  esac
}

if [[ ${BASH_SOURCE[0]} != $0 ]]; then
  export -f aws-env
else
  aws-env "${@}"
  exit $?
fi
