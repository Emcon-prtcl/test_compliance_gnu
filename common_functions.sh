#!/bin/bash

# ==========================================
# Fonctions communes pour les tests de conformité sysctl
# ==========================================

# Couleurs pour l'affichage terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Variables globales pour les compteurs
TOTAL=0
PASSED=0
FAILED=0

# Fonction pour vérifier un paramètre sysctl
# Usage: check_sysctl "param.name" "expected_value" "Description du paramètre"
check_sysctl() {
    local param=$1
    local expected=$2
    local description=$3
    
    TOTAL=$((TOTAL + 1))
    
    # Récupérer la valeur actuelle
    # 2>/dev/null pour ignorer les erreurs si le paramètre n'existe pas
    current=$(sysctl -n "$param" 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERREUR]${NC} $description"
        echo "  Paramètre: $param"
        echo "  Le paramètre n'existe pas ou n'est pas accessible"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi
    
    # Comparer avec la valeur attendue
    if [ "$current" = "$expected" ]; then
        echo -e "${GREEN}[OK]${NC} $description"
        echo "  Paramètre: $param = $current"
        echo ""
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}[ÉCHEC]${NC} $description"
        echo "  Paramètre: $param"
        echo "  Valeur actuelle: $current"
        echo "  Valeur attendue: $expected"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi
}

# Fonction pour afficher le résumé final
print_summary() {
    echo "=========================================="
    echo "  RÉSUMÉ"
    echo "=========================================="
    echo -e "Total de tests: $TOTAL"
    echo -e "${GREEN}Réussis: $PASSED${NC}"
    echo -e "${RED}Échoués: $FAILED${NC}"
    echo ""
}

# Fonction pour afficher l'en-tête d'un test
print_header() {
    local rule_name=$1
    echo "=========================================="
    echo "  Test de conformité sysctl - $rule_name"
    echo "=========================================="
    echo ""
}