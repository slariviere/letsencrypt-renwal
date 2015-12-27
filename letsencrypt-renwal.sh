#!/bin/bash

# Defaults values
RENEW_DELAY_DAYS=7
LETSENCRYPT_RENEWAL_SCRIPT_NAME=letsencrypt-renewal.sh
RELOAD_CMD="sudo systemctl reload nginx"

LETSENCRYPT_CERT_DIR=/etc/letsencrypt/live/
RENEW_DELAY_SECONDS=$((RENEW_DELAY_DAYS * 86400))

renew(){
    certificate=$1
    # The certificate needs to be renewed. We need to run the script in the directory LETSENCRYPT_CERT_DOMAIN_DIR
    LETSENCRYPT_CERT_DOMAIN_DIR=$(dirname "${certificate}")
    echo "Certificate ${certificate} is being renewed"
    if [[ -f "${LETSENCRYPT_CERT_DOMAIN_DIR}/${LETSENCRYPT_RENEWAL_SCRIPT_NAME}" ]]; then
        "${LETSENCRYPT_CERT_DOMAIN_DIR}/${LETSENCRYPT_RENEWAL_SCRIPT_NAME}"
        "${RELOAD_CMD}"
    else
        echo "ERROR: Script for ${certificate} renewal is missing."
    fi
}

main (){
    # Check if the certificate is due to be renewed
    for certificate in $LETSENCRYPT_CERT_DIR/*/cert.pem
    do
        if ! openssl x509 -checkend "${RENEW_DELAY_SECONDS}" -noout -in "${certificate}"
        then
            renew "${certificate}"
        fi
    done
}

main