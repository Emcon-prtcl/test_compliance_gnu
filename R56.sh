#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R56" "security"

TOTAL=$((TOTAL + 1))
# Prend un peu de temps
suid_files=$(find / -type f -perm /6000 2>/dev/null)

if [ -z "$suid_files" ]; then
    echo -e "${GREEN}[OK]${NC} Aucun fichier setuid/setgid détecté"
    echo ""
    PASSED=$((PASSED + 1))
else
    echo -e "${YELLOW}[INFO]${NC} Fichiers avec droits setuid/setgid trouvés"
    echo "  À vérifier et valider individuellement :"
    echo "$suid_files" | while read -r file; do
        echo "    - $file"
    done
    echo ""
fi

print_summary