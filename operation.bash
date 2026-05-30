#!/usr/bin/env bash


print_usage ()
{
    printf "Usage:\n\n"
    echo "For encryption/decryption:"
    printf "\t$0 {encrypt,decrypt} vault-password-file-path\n\n"
    echo "For deployment:"
    printf "\t$0 deploy\n"
}

crypt ()
{
    local OPERATION=$1
    # printf "%sing variables" "$(OPERATION^)"
    printf "%sing variables\n" "${OPERATION^}"
    
    local VAULT_PASS=$2
    local EXAMPLE_FILES="*.example.yml"
    local EMACS_FILES="*.yml~"
    local TARGET_FILES="*.yml"
    local VAR_DIR="$(dirname "$0")/group_vars"

    find $VAR_DIR -type f -name "$TARGET_FILES" \
         ! -name "$EXAMPLE_FILES" \
         ! -name "$EMACS_FILES" \
         -exec ansible-vault $OPERATION --vault-password-file $VAULT_PASS {} \;
}

deploy () {
    echo "Deploying configs ..."
    ansible-playbook -i inventory.ini playbook.yml --ask-become-pass
}

ARG_COUNT=$#

if [[ $ARG_COUNT -eq 1 && $1 == "deploy" ]]
then
    deploy
    exit 0
fi

if [[ "$ARG_COUNT" -eq 2 && ( "$1" == "encrypt" || "$1" == "decrypt" ) ]]
then
    if ! [  -f $2 ]
    then
        echo "Vault Pass file not found or is corrupted"
        exit 1
    fi

    crypt $1 $2
    exit 0
fi

print_usage
exit 1
