#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R20" "kernel"

check_kernel_option "CONFIG_SECCOMP" "y" "Active la possibilité de filtrer les appels système faits par une application."

check_kernel_option "CONFIG_SECCOMP_FILTER" "y" "Active la possibilité d'utiliser des script BPF (Berkeley Packet Filter)."

check_kernel_option "CONFIG_SECURITY" "y" "Active les primitives de sécurité du noyau Linux , nécessaire pour les LSM."

check_kernel_option "CONFIG_SECURITY_YAMA" "y" "Active Yama, qui permet de limiter simplement l'usage de l'appel système ptrace(). Une fois les modules de sécurité utilisés par le système sélectionné , il convient de désactiver le support des autres modules de sécurité dans le noyau afin de réduire la surface d'attaque."

print_summary
