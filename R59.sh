#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R59" "security"

TOTAL=$((TOTAL + 1))

bad=$(grep -RhoE '^[[:space:]]*deb[[:space:]]+[^#]+' /etc/apt/sources.list /etc/apt/sources.list.d/* 2>/dev/null \
    | grep -Ev 'debian\.org|deb\.debian\.org|security\.debian\.org|ubuntu\.com|archive\.ubuntu\.com|security\.ubuntu\.com|ports\.ubuntu\.com|^deb[[:space:]]+cdrom:' || true)

if [ -n "$bad" ]; then
    echo -e "${RED}[ÉCHEC]${NC} Dépôts potentiellement non officiels détectés"
    echo "$bad" | sed 's/^/  - /'
    echo ""
    FAILED=$((FAILED + 1))
else
    echo -e "${GREEN}[OK]${NC} Dépôts de paquets de confiance uniquement détectés"
    echo ""
    PASSED=$((PASSED + 1))
fi

print_summary