#!/bin/bash

# Récupérer le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Charger les fonctions communes
source "$SCRIPT_DIR/common_functions.sh"

# Afficher l'en-tête
print_header "R10"

check_sysctl "kernel.modules_disabled" "1" "Interdit le chargement des modules noyau (sauf ceux déjà chargés à ce point)"

# Afficher le résumé final
print_summary
