#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R28" "filesystem"

# R28 – Partitionnement type (options requises)

# /boot : nosuid,nodev,noexec
check_mount_options "/boot" "nosuid,nodev,noexec" "Partition /boot: protections d'exécution et privilèges"

# /opt : nosuid,nodev
check_mount_options "/opt" "nosuid,nodev" "Partition /opt: paquets additionnels sans privilèges"

# /tmp : nosuid,nodev,noexec
check_mount_options "/tmp" "nosuid,nodev,noexec" "Partition /tmp: uniquement non-exécutables"

# /srv : nosuid,nodev
check_mount_options "/srv" "nosuid,nodev" "Partition /srv: contenus servis (web/ftp) sans privilèges"

# /home : nosuid,nodev,noexec
check_mount_options "/home" "nosuid,nodev,noexec" "Partition /home: répertoires utilisateurs non exécutables"

# /proc : hidepid=2
check_mount_options "/proc" "hidepid=2" "Montage /proc avec masquage des processus des autres utilisateurs (hidepid=2)"

# /usr : nodev
check_mount_options "/usr" "nodev" "Partition /usr: pas de périphériques"

# /var : nosuid,nodev,noexec
check_mount_options "/var" "nosuid,nodev,noexec" "Partition /var: données variables sans exécution"

# /var/log : nosuid,nodev,noexec
check_mount_options "/var/log" "nosuid,nodev,noexec" "Partition /var/log: logs système non exécutables"

# /var/tmp : nosuid,nodev,noexec
check_mount_options "/var/tmp" "nosuid,nodev,noexec" "Partition /var/tmp: fichiers temporaires conservés sans exécution"

print_summary
