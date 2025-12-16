#!/bin/bash

# Couleurs pour l'affichage pour le terminal vert qaund le test est passé et rouge quand il a échoué
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "=========================================="
echo "  Test de conformité sysctl - R9"
echo "=========================================="
echo ""

TOTAL=0
PASSED=0
FAILED=0

# Fonction pour vérifier un paramètre sysctl
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



check_sysctl "kernel.dmesg_restrict" "1" "Restreint l'accès au buffer dmesg"
check_sysctl "kernel.kptr_restrict" "2" "Cache les adresses noyau dans /proc et les différentes autres interfaces, y compris aux utilisateurs privilégiés"
check_sysctl "kernel.pid_max" "65536" " Spécifie explicitement l'espace d'identifiants de processus supporté par le noyau , 65 536 étant une valeur donnée à titre d'exemple"
check_sysctl "kernel.perf_cpu_time_max_percent" "1" "Restreint l'utilisation du sous-système perf"
check_sysctl "kernel.perf_event_max_sample_rate" "1" "Restreint l'utilisation du sous-système perf"
check_sysctl "kernel.perf_event_paranoid" "2" "Interdit l'accès non privilégié à l'appel système perf_event_open(). Avec une valeur plus grande que 2, on impose la possession de CAP_SYS_ADMIN , pour pouvoir recueillir les évènements perf."
check_sysctl "kernel.randomize_va_space" "2" "Active l'ASLR"
check_sysctl "kernel.sysrq" "0" "Désactive les combinaisons de touches magiques (Magic System Request Key)"
check_sysctl "kernel.unprivileged_bpf_disabled" "1" "Restreint l'usage du BPF noyau aux utilisateurs privilégiés"
check_sysctl "kernel.panic_on_oops" "1" "Arrête complètement le système en cas de comportement inattendu du noyau Linux"

# Résumé final
echo "=========================================="
echo "  RÉSUMÉ"
echo "=========================================="
echo -e "Total de tests: $TOTAL"
echo -e "${GREEN}Réussis: $PASSED${NC}"
echo -e "${RED}Échoués: $FAILED${NC}"
echo ""

