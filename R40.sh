#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R40" "users"

TOTAL=$((TOTAL + 1))

# Chercher les règles sudo qui ciblent root
if grep -r "=(root)" /etc/sudoers /etc/sudoers.d/ 2>/dev/null | grep -v "^#" | grep -q .; then
    echo -e "${RED}[ÉCHEC]${NC} Règles sudo ciblant root détectées"
    echo ""
    FAILED=$((FAILED + 1))
else
    echo -e "${GREEN}[OK]${NC} Pas de règles sudo ciblant root"
    echo ""
    PASSED=$((PASSED + 1))
fi

print_summary