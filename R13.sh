#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R13"

check_sysctl "net.ipv6.conf.default.disable_ipv6" "1" "Désactiver IPv6 pour la configuration par défaut"
check_sysctl "net.ipv6.conf.all.disable_ipv6" "1" "Désactiver IPv6 pour toutes les interfaces"

print_summary