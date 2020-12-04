#!/usr/bin/env bash


##
#
# @parameter {number} $1 - Min character length for password
tests__features__min_length() {
    printf '# Started -> %s\n' "${FUNCNAME[0]}"

    local _min_length="${1:?No minimum password length provided}"
    local _random_password

    _random_password="$(generate-random-password "${_min_length}")"
    if [[ "${#_random_password}" != "${_min_length}" ]]; then
        printf >&2 'Password length does not equal minimum length -> %i\n' "${_min_length}"
        return 1
    fi

    printf '# Finished -> %s\n' "${FUNCNAME[0]}"
}

