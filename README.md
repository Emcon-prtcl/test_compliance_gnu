# Test de conformité GNU/Linux - Recommandations de sécurité de l'ANSSI

Suite de scripts Bash pour vérifier la conformité d'un système GNU/Linux selon les recommandations de configuration de sécurité de l'ANSSI.

**Document de référence** : [Recommandations de configuration d'un système GNU/Linux - ANSSI v2.0](https://messervices.cyber.gouv.fr/documents-guides/fr_np_linux_configuration-v2.0.pdf)

## Démarrage rapide

Tous les scripts s'exécutent de la même manière :

```bash
./R9.sh
./R10.sh
./R12.sh
# etc.
```

Chaque script affiche un résumé des tests avec :
- [OK] : Test réussi
- [ÉCHEC] : Non conforme

## Règles testées

- **R9** : Configuration du noyau et du bootloader (grub)
- **R10** : Droits d'accès et permissions sur les fichiers de configuration
- **R12** : Paramètres sysctl de sécurité réseau (IPv4, IPv6, ARP)
- **R13** : Configuration supplémentaire sysctl (IPv6, ICMP, TIME_WAIT)
- **R18** : Configuration noyau pour la signature des modules
- **R20** : Activation de Seccomp, BPF, et primitives de sécurité (LSM, Yama)
- **R28** : Options de montage requises pour les partitions
- **R32** : Expiration automatique des sessions utilisateur (TMOUT, GNOME)
- **R36** : UMASK par défaut configuré à 0077 pour les shells
- **R40** : Règles sudo ciblant des utilisateurs non-privilégiés (pas de root)
- **R42** : Absence de négations (!) dans les spécifications sudoers
- **R56** : Audit des exécutables avec droits setuid/setgid

## Structure des scripts

Tous les scripts utilisent les fonctions communes de [common_functions.sh](common_functions.sh).

> **Note** : Ce fichier ne contient aucune régle à vérifier mais juste des fonction pour gérer l'affichage des tests et les résumés.



