#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R18" "kernel"


check_kernel_option "CONFIG_MODULES" "y" "Activation du support des modules"

check_kernel_option "CONFIG_STRICT_MODULE_RWX" "y" "Cette option a remplacé CONFIG_DEBUG_SET_MODULE_RONX dans le noyau (>=4.11)"


check_kernel_option "CONFIG_MODULE_SIG" "y" "Les modules doivent être signés. Attention , les modules ne doivent pas être strippés après signature."
check_kernel_option "CONFIG_MODULE_SIG_FORCE" "y" "Empèche le chargement des modules non signés ou signés avec une clé qui ne nous appartient pas."
check_kernel_option "CONFIG_MODULE_SIG_ALL" "y" "Activer CONFIG_MODULE_SIG_ALL permet de signer tous les modules automatiquement pendant l'étape \"make modules_install\", sans cette option les modules doivent être signés manuellement en utilisant le script scripts/sign-file. L'option CONFIG_MODULE_SIG_ALL dépend de CONFIG_MODULE_SIG et CONFIG_MODULE_SIG_FORCE , elles doivent donc être activées."


check_kernel_option "CONFIG_MODULE_SIG_SHA512" "y" "La signature des modules utilise SHA512 comme fonction de hash"
check_kernel_option "CONFIG_MODULE_SIG_HASH" "sha512" "La signature des modules utilise SHA512 comme fonction de hash"
check_kernel_option "CONFIG_MODULE_SIG_KEY" "certs/signing_key.pem" "Indique le chemin vers le fichier contenant à la fois la clé privée et son certificat X.509 au format PEM utilisé pour la signature des modules , relatif à la racine du noyau."


print_summary
