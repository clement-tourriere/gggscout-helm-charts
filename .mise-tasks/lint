#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

for chart in charts/*/
do
  helm lint "${chart}" --values "${chart}"/test_values.yaml
done
