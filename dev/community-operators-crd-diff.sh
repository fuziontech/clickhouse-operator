#!/bin/bash

# Source configuration
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/go_build_config.sh"

# Where community-operators sources are located
CO_PATH=~/dev/community-operators/operators/clickhouse/

# Ask to prepare copy of required files
echo "Please ensure new clickhouse folder in operatorhub repo is available :"
echo "${CO_PATH}"
read -n 1 -r -s -p $'Press enter to continue...\n'

if [[ ! -d "${CO_PATH}" ]]; then
    echo "No ${CO_PATH} available! Abort."
    exit 1
fi

PREVIOUS_VERSION="${PREVIOUS_VERSION:-0.18.0}" ${SRC_ROOT}/deploy/builder/operatorhub.sh

cp -r "${SRC_ROOT}/deploy/operatorhub/${VERSION}" "${CO_PATH}"
cp -r "${SRC_ROOT}/deploy/operatorhub/clickhouse.package.yaml" "${CO_PATH}"

echo "DONE"
