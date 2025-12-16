#!/bin/bash

echo "R32 - Éxpirer les sessions utilisateur locales"
echo

# Vérification TMOUT (TTY)
if grep -R "readonly TMOUT" /etc/profile /etc/profile.d/ /etc/bash.bashrc > /dev/null 2>&1; then
    echo "OK --------------------------------- TMOUT configuré pour les sessions TTY"
else
    echo "NON CONFORME ----------------------- TMOUT non configuré"
fi

# Vérification GNOME (si présent)
if command -v gsettings > /dev/null 2>&1; then
    idle=$(gsettings get org.gnome.desktop.session idle-delay 2>/dev/null)
    lock=$(gsettings get org.gnome.desktop.screensaver lock-enabled 2>/dev/null)

    echo "GNOME idle-delay : ----------------- $idle"
    echo "GNOME lock-enabled : --------------- $lock"
else
    echo "GNOME non détecté"
fi