#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R42" "users"

TOTAL=$((TOTAL + 1))

# Chercher les négations (!) dans les spécifications sudoers
if grep -r "!" /etc/sudoers /etc/sudoers.d/ 2>/dev/null | grep -v "^#" | grep -q .; then
    echo -e "${RED}[ÉCHEC]${NC} Spécifications avec négations détectées"
    echo "  Les négations (!) ambiguïsent les permissions et doivent être évitées"
    echo ""
    FAILED=$((FAILED + 1))
else
    echo -e "${GREEN}[OK]${NC} Pas de négations dans les spécifications sudoers"
    echo ""
    PASSED=$((PASSED + 1))
fi

print_summary