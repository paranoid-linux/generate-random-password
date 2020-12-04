#!/usr/bin/env bash


##
#
# @parameter {number} $1 - Min character length for password
# @parameter {number} $2 - Max character length for password
tests__features__max_length() {
    printf '# Started -> %s\n' "${FUNCNAME[0]}"

    local _min_length="${1:?No minimum password length provided}"
    local _max_length="${2:?No maxumum password length provided}"
    local _random_password

    _random_password="$(generate-random-password "${_min_length}" "${_max_length}")"
    if [[ "${#_random_password}" -lt "${_min_length}" ]]; then
        printf >&2 'Password length is less than minimum length -> %i\n' "${_min_length}"
    elif [[ "${#_random_password}" -gt "${_max_length}" ]]; then
        printf >&2 'Password length is greater than maxumum length -> %i\n' "${_max_length}"
    fi

    printf '# Finished -> %s\n' "${FUNCNAME[0]}"
}

