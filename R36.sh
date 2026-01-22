#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R36" "users"

TOTAL=$((TOTAL + 1))


if grep -q "umask 0077" /etc/profile 2>/dev/null; then
    echo -e "${GREEN}[OK]${NC} UMASK shells configuré à 0077 dans /etc/profile"
    echo ""
    PASSED=$((PASSED + 1))
else
    echo -e "${RED}[ÉCHEC]${NC} UMASK shells non configuré à 0077"
    echo "  Ajouter 'umask 0077' dans /etc/profile"
    echo ""
    FAILED=$((FAILED + 1))
fi

print_summary