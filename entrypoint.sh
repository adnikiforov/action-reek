#!/bin/sh

version() {
  if [ -n "$1" ]; then
    echo "-v $1"
  fi
}

cd "$GITHUB_WORKSPACE"
export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

gem install -N reek $(version $INPUT_REEK_VERSION)

reek --single-line . ${INPUT_REEK_FLAGS} \
  | reviewdog -f=reek \
    -name="${INPUT_TOOL_NAME}" \
    -reporter="${INPUT_REPORTER}" \
    -filter-mode="${INPUT_FILTER_MODE}" \
    -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
    -level="${INPUT_LEVEL}" \
    ${INPUT_REVIEWDOG_FLAGS}
