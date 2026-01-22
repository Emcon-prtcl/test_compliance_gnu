#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/common_functions.sh"

print_header "R32" "sessions"

check_tmout() {
    TOTAL=$((TOTAL + 1))
    
    if grep -rq "readonly TMOUT" /etc/profile /etc/profile.d/ /etc/bash.bashrc 2>/dev/null; then
        echo -e "${GREEN}[OK]${NC} TMOUT configuré pour expirer les sessions utilisateur TTY"
        echo "  Les sessions shell seront verrouillées après un délai d'inactivité"
        echo ""
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}[ÉCHEC]${NC} TMOUT non configuré pour les sessions TTY"
        echo "  Les sessions shell ne sont pas expirées automatiquement"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi
}

check_gnome_idle() {
    TOTAL=$((TOTAL + 1))
    
    if ! command -v gsettings &> /dev/null; then
        echo -e "${YELLOW}[INFO]${NC} GNOME non détecté sur le système"
        echo ""
        return 0
    fi
    
    local idle_delay
    local lock_enabled
    
    idle_delay=$(gsettings get org.gnome.desktop.session idle-delay 2>/dev/null | awk '{print $NF}')
    lock_enabled=$(gsettings get org.gnome.desktop.screensaver lock-enabled 2>/dev/null)
    
    local idle_minutes=0
    if [ -n "$idle_delay" ] && [ "$idle_delay" -gt 0 ]; then
        idle_minutes=$((idle_delay / 60))
    fi
    
    if [ "$lock_enabled" = "true" ] && [ "$idle_delay" -gt 0 ]; then
        echo -e "${GREEN}[OK]${NC} Écran de veille GNOME configuré"
        echo "  idle-delay: $idle_minutes minutes ($idle_delay secondes)"
        echo "  lock-enabled: $lock_enabled"
        echo ""
        PASSED=$((PASSED + 1))
        return 0
    else
        echo -e "${RED}[ÉCHEC]${NC} Écran de veille GNOME non correctement configuré"
        echo "  idle-delay: ${idle_delay:-0} secondes"
        echo "  lock-enabled: ${lock_enabled:-false}"
        echo ""
        FAILED=$((FAILED + 1))
        return 1
    fi
}

check_tmout
check_gnome_idle

print_summary