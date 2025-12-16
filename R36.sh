#!/bin/bash

echo "R36 - Modifier la valeur par défaut de UMASK"

CURRENT_UMASK=$(umask)

# Affiche la valeur actuelle
echo "UMASK actuelle : $CURRENT_UMASK"

# Compare avec la valeur attendue
if [ "$CURRENT_UMASK" = 0077 ]; then
    echo "----> Conforme"
else
    echo "----> Non conforme, 'umask 0077' pour corriger)"
fi