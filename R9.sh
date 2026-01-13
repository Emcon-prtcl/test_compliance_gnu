#!/bin/bash

# Récupérer le répertoire du script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Charger les fonctions communes
source "$SCRIPT_DIR/common_functions.sh"

# Afficher l'en-tête
print_header "R9"

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

# Afficher le résumé final
print_summary

