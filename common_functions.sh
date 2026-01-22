#!/bin/bash

# Ce fichier ne contient aucune régle à vérifier mais juste des fonction pour gérer l'affichage des tests et les résumés.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TOTAL=0
PASSED=0
FAILED=0

check_sysctl() {
    local param=$1
    local expected=$2
    local description=$3
    
    TOTAL=$((TOTAL + 1))
    
    current=$(sysctl -n "$param" 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo -e "${RED}[ERREUR]${NC} $description"
        echo "  Paramètre: $param"
        echo "  Le paramètre n'existe pas ou n'est pas accessible"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi
    
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

print_summary() {
    echo "=========================================="
    echo "  RÉSUMÉ"
    echo "=========================================="
    echo -e "Total de tests: $TOTAL"
    echo -e "${GREEN}Réussis: $PASSED${NC}"
    echo -e "${RED}Échoués: $FAILED${NC}"
    echo ""
}


print_header() {
    local rule_name=$1
    local type=${2:-generic} 
    
    case "$type" in
        kernel)
            local type_text="configuration du noyau";;
        filesystem|fs|partitions)
            local type_text="partitionnement et options de montage";;
        sysctl)
            local type_text="sysctl";;
        sessions|users|security)
            local type_text="sessions utilisateur et sécurité";;
        *)
            local type_text="conformité";;
    esac
    
    echo "=========================================="
    echo "  Test de $type_text - $rule_name"
    echo "=========================================="
    echo ""
}


check_mount_options() {
    local path=$1
    local required=$2
    local description=$3

    TOTAL=$((TOTAL + 1))

    local opts
    opts=$(findmnt -T "$path" -no OPTIONS 2>/dev/null)

    if [ -z "$opts" ]; then
        echo -e "${RED}[ERREUR]${NC} $description"
        echo "  Point de montage: $path"
        echo "  Introuvable ou non monté"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi

    local missing=()
    IFS=',' read -r -a req_arr <<< "$required"
    for opt in "${req_arr[@]}"; do
        if [[ "$opts" != *"$opt"* ]]; then
            missing+=("$opt")
        fi
    done

    if [ ${#missing[@]} -eq 0 ]; then
        echo -e "${GREEN}[OK]${NC} $description"
        echo "  Point de montage: $path"
        echo "  Options: $opts"
        echo ""
        PASSED=$((PASSED + 1))
    else
        echo -e "${RED}[ÉCHEC]${NC} $description"
        echo "  Point de montage: $path"
        echo "  Options actuelles: $opts"
        echo "  Options requises manquantes: ${missing[*]}"
        echo ""
        FAILED=$((FAILED + 1))
    fi
}


check_kernel_option() {
    local option=$1
    local expected=$2
    local description=$3
    
    TOTAL=$((TOTAL + 1))
    

    local kernel_config="/boot/config-$(uname -r)"
    
    
    local actual=$(grep "^$option=" "$kernel_config" | cut -d'=' -f2 | tr -d '"')
     
    if [ "$actual" = "$expected" ]; then
        echo -e "${GREEN}[OK]${NC} $description"
        echo "  Paramètre: $option = $actual"
        echo ""
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}[ÉCHEC]${NC} $description"
        echo "  Paramètre: $option"
        echo "  Valeur actuelle: $actual"
        echo "  Valeur attendue: $expected"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi
}