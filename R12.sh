#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R12"


check_sysctl "net.core.bpf_jit_harden" "2" "Atténuation de l'effet de dispersion du JIT noyau au coût d'un compromis sur les performances associées."
check_sysctl "net.ipv4.ip_forward" "0" "Pas de routage entre les interfaces. Cette option est spéciale et peut entrainer des modifications d'autres options."
check_sysctl "net.ipv4.conf.all.accept_local" "0" "Considère comme invalides les paquets reçus de l'extérieur ayant comme source le réseau 127/8."
check_sysctl "net.ipv4.conf.all.accept_redirects" "0" "Refuse la réception de paquet ICMP redirect (all)"
check_sysctl "net.ipv4.conf.default.accept_redirects" "0" "Refuse la réception de paquet ICMP redirect (default)"
check_sysctl "net.ipv4.conf.all.secure_redirects" "0" "Refuse les secure redirects (all)"
check_sysctl "net.ipv4.conf.default.secure_redirects" "0" "Refuse les secure redirects (default)"
check_sysctl "net.ipv4.conf.all.shared_media" "0" "Partage de media désactivé (all)"
check_sysctl "net.ipv4.conf.default.shared_media" "0" "Partage de media désactivé (default)"
check_sysctl "net.ipv4.conf.all.accept_source_route" "0" "Refuse les informations d'en-têtes de source routing fournies par le paquet pour déterminer sa route (all)"
check_sysctl "net.ipv4.conf.default.accept_source_route" "0" "Refuse les informations d'en-têtes de source routing fournies par le paquet pour déterminer sa route (default)"
check_sysctl "net.ipv4.conf.all.arp_filter" "1" "Empêche le noyau Linux de gérer la table ARP globalement"
check_sysctl "net.ipv4.conf.all.arp_ignore" "2" "Ne répond aux sollicitations ARP que si l'adresse source et destination sont sur le même réseau et sur l'interface sur laquelle le paquet a été reçu"
check_sysctl "net.ipv4.conf.all.drop_gratuitous_arp" "1" "Ignore les sollicitations de type gratuitous ARP"
check_sysctl "net.ipv4.conf.all.route_localnet" "0" "Refuse le routage de paquet dont l'adresse source ou destination est celle de la boucle locale"
check_sysctl "net.ipv4.conf.default.rp_filter" "1" "Vérifie que l'adresse source des paquets reçus sur une interface donnée aurait bien été contactée via cette même interface (default)"
check_sysctl "net.ipv4.conf.all.rp_filter" "1" "Vérifie que l'adresse source des paquets reçus sur une interface donnée aurait bien été contactée via cette même interface (all)"
check_sysctl "net.ipv4.conf.default.send_redirects" "0" "N'envoie pas de ICMP redirects (default)"
check_sysctl "net.ipv4.conf.all.send_redirects" "0" "N'envoie pas de ICMP redirects (all)"
check_sysctl "net.ipv4.icmp_ignore_bogus_error_responses" "1" "Ignorer les réponses non conformes à la RFC 1122"
check_sysctl "net.ipv4.ip_local_port_range" "32768 65535" "Augmenter la plage pour les ports éphémères"
check_sysctl "net.ipv4.tcp_rfc1337" "1" "RFC 1337"
check_sysctl "net.ipv4.tcp_syncookies" "1" "Utilise les SYN cookies. Cette option permet la prévention d'attaque de type SYN flood"
check_sysctl "net.core.bpf_jit_harden" "2" "Atténuation de l'effet de dispersion du JIT noyau au coût d'un compromis sur les performances associées."


print_summary