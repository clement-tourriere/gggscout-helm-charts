#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

process_json_schema() {
  local directory="$1"
  local base_values_schema_path="${directory}"/values-base-schema.schema.json
  local values_schema_path="${directory}"/values.schema.json
  local temp_dir
  temp_dir="$(mktemp -d)"
  local bundled_path="${temp_dir}"/resolved.json
  echo "Bundling schema from ${base_values_schema_path} to ${bundled_path}"
  npx --yes @sourcemeta/jsonschema bundle --resolve schemas/ "${base_values_schema_path}" --without-id > "${bundled_path}"
  echo "Normalizing schema from ${bundled_path} to ${values_schema_path}"
  npx --yes @sourcemeta/jsonschema canonicalize "${bundled_path}" > "${values_schema_path}"
}

for chart in charts/*/
do
  process_json_schema "$chart"
done
