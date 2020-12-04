#!/usr/bin/env bash


set -Ee -o functrace


## Find true directory script resides in, true name, and true path
__SOURCE__="${BASH_SOURCE[0]}"
while [[ -h "${__SOURCE__}" ]]; do
    __SOURCE__="$(find "${__SOURCE__}" -type l -ls | sed -n 's@^.* -> \(.*\)@\1@p')"
done
__DIR__="$(cd -P "$(dirname "${__SOURCE__}")" && pwd)"
__PARENT_DIR__="${__DIR__%/*}"
__NAME__="${__SOURCE__##*/}"
__AUTHOR__='S0AndS0'
__DESCRIPTION__='Tests torrific-curl wrapper script'


## Provides argument_parser '_passed_args' '_acceptable_args'
# shellcheck source=modules/argument-parser/argument-parser.sh
source "${__PARENT_DIR__}/modules/argument-parser/argument-parser.sh"

##
# shellcheck source=.travis-ci/features/max-length.sh
source "${__DIR__}/features/max-length.sh"

##
# shellcheck source=.travis-ci/features/min-length.sh
source "${__DIR__}/features/min-length.sh"


__license__(){
    local _year
    _year="$(date +'%Y')"
    cat <<EOF
${__DESCRIPTION__}
Copyright (C) ${_year:-2020} ${__AUTHOR__:-S0AndS0}

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, version 3 of the License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
EOF
}


__usage__() {
    cat <<EOF
${__DESCRIPTION__}


Usage: ${__NAME__} [OPTION]...


Options:
-h       --help             <boolean> ${_help:-0}
    {Optional} Prints this message and exists

-l       --license          <boolean> ${_license:-0}
    {Optional} Prints license and exits

-f      --failure-threshold  <number> ${_failure_threshold:-0}
    {Optional} Number of failures that causes ${__NAME__} to exit with error


Examples:
    cd "${__PARENT_DIR__}"
    ./.travis-ci/${__NAME__}
EOF
}


##
#
test_function() {
    local _function_name="${1:?No function_name name provided}"
    local -a _function_arguments=( "${@}" )
    unset "_function_arguments[0]"
    "${_function_name}" "${_function_arguments[@]}" || {
        local _status="${?}"
        printf 'Failed -> %s\n' "${_function_name}"
        (( _falure_count++ )) || { true; }
        [[ "${_falure_count}" -ge "${_failure_threshold}" ]] && {
            printf >&2 'Failure threshold exceeded!\n'
            exit "${_status}"
        }
    }
    return "${_status:-0}"
}


## Defaults
_failure_threshold=0
_falure_count=0


## Parse arguemnts
# shellcheck disable=SC2034
{
    _passed_args=( "${@}" )
    _acceptable_args=(
        '--help|-h:bool'
        '--version|-V:bool'
        '--license|-l:bool'
        '--failure-threshold|-f:number'
    )
}
argument_parser '_passed_args' '_acceptable_args'
_parser_status="${?}"


(( _help )) || (( _parser_status )) && {
    __usage__
    exit "${_parser_status:-0}"
}

# shellcheck disable=SC2154
(( _version )) && {
    _version_number="$(git tag --list v* | tail -n1)"
    _version_number="${_version_number:-v0.0.1}"
    _version_number="${_version_number//[^0-9.]/}"
    cat <<EOF
${__NAME__} - ${_version_number}

$( __license__ )

Written by ${__AUTHOR__}
EOF
    exit ${_exit_status:-0}
}

(( _license )) && {
    __license__
    exit 0
}


test_function 'tests__features__min_length' '42'

test_function 'tests__features__max_length' '32' '42'

