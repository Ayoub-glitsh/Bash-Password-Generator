#!/bin/bash

# ==============================================================================
# Password Generator Script
# Description: Generates secure random passwords using /dev/urandom.
# Created for: Bash Environment (Linux, macOS, WSL, Git Bash)
# ==============================================================================

# --- Colors ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- UI Helpers ---
print_banner() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "  ╔════════════════════════════════════════╗"
    echo "  ║        Secure Password Generator       ║"
    echo "  ╚════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[+]${NC} $1"
}

print_error() {
    echo -e "${RED}[!]${NC} $1"
}

# --- Functions ---

# Function to evaluate password strength
check_strength() {
    local pass="$1"
    local length=${#pass}
    local score=0

    # Basic length check
    if [ "$length" -ge 12 ]; then ((score += 2)); elif [ "$length" -ge 8 ]; then ((score += 1)); fi
    
    # Character diversity check
    [[ "$pass" =~ [0-9] ]] && ((score++))
    [[ "$pass" =~ [A-Z] ]] && ((score++))
    [[ "$pass" =~ [a-z] ]] && ((score++))
    [[ "$pass" =~ [^a-zA-Z0-9] ]] && ((score++))

    echo -n "Strength: "
    if [ "$score" -le 3 ]; then
        echo -e "${RED}WEAK${NC} (Score: $score/6)"
    elif [ "$score" -le 5 ]; then
        echo -e "${YELLOW}MEDIUM${NC} (Score: $score/6)"
    else
        echo -e "${GREEN}STRONG${NC} (Score: $score/6)"
    fi
}

copy_to_clipboard() {
    local pass="$1"
    if command -v pbcopy > /dev/null; then
        echo -n "$pass" | pbcopy
        print_success "Copied to clipboard (macOS)"
    elif command -v xclip > /dev/null; then
        echo -n "$pass" | xclip -selection clipboard
        print_success "Copied to clipboard (Linux/xclip)"
    elif command -v clip.exe > /dev/null; then
        echo -n "$pass" | clip.exe
        print_success "Copied to clipboard (WSL/Windows)"
    else
        print_status "Clipboard utility not found (xclip/pbcopy/clip.exe). Skipping copy."
    fi
}

# --- Main Logic ---

print_banner

# 1. Ask for length
read -p "$(echo -e ${BOLD}"Enter password length (default 16): "${NC})" LENGTH
LENGTH=${LENGTH:-16}

if ! [[ "$LENGTH" =~ ^[0-9]+$ ]]; then
    print_error "Invalid length. Please enter a number."
    exit 1
fi

# 2. Ask for options
read -p "$(echo -e ${BOLD}"Include uppercase letters? (y/n, default y): "${NC})" INCLUDE_UPPER
INCLUDE_UPPER=${INCLUDE_UPPER:-y}

read -p "$(echo -e ${BOLD}"Include numbers? (y/n, default y): "${NC})" INCLUDE_NUM
INCLUDE_NUM=${INCLUDE_NUM:-y}

read -p "$(echo -e ${BOLD}"Include special characters? (y/n, default y): "${NC})" INCLUDE_SPECIAL
INCLUDE_SPECIAL=${INCLUDE_SPECIAL:-y}

# 3. Ask for multiple passwords
read -p "$(echo -e ${BOLD}"How many passwords to generate? (default 1): "${NC})" COUNT
COUNT=${COUNT:-1}

# 4. Ask to save to file
read -p "$(echo -e ${BOLD}"Save to file? (y/n, default n): "${NC})" SAVE_FILE
SAVE_FILE=${SAVE_FILE:-n}

# Build character set
CHARSET="a-z"
[[ "$INCLUDE_UPPER" =~ ^[Yy]$ ]] && CHARSET="${CHARSET}A-Z"
[[ "$INCLUDE_NUM" =~ ^[Yy]$ ]] && CHARSET="${CHARSET}0-9"
[[ "$INCLUDE_SPECIAL" =~ ^[Yy]$ ]] && CHARSET="${CHARSET}@#%^&*()-_=+[]{}|;:,.<>?/"

# Check charset is not empty (though it always has a-z)
if [ -z "$CHARSET" ]; then
    print_error "No characters selected for generation."
    exit 1
fi

echo -e "\n${BLUE}--- Generated Passwords ---${NC}\n"

PASSWORDS=()
for ((i=1; i<=COUNT; i++)); do
    # Generate password using /dev/urandom
    # Using LC_ALL=C to avoid encoding issues with tr
    PASS=$(LC_ALL=C tr -dc "$CHARSET" < /dev/urandom | head -c "$LENGTH")
    PASSWORDS+=("$PASS")
    
    echo -e "${BOLD}${PURPLE}Password #$i:${NC} ${WHITE}$PASS${NC}"
    check_strength "$PASS"
    echo "-----------------------------------"
done

# If only one password, try copy to clipboard
if [ "$COUNT" -eq 1 ]; then
    copy_to_clipboard "${PASSWORDS[0]}"
fi

# Save to file if requested
if [[ "$SAVE_FILE" =~ ^[Yy]$ ]]; then
    FILENAME="generated_passwords_$(date +%Y%m%d_%H%M%S).txt"
    for p in "${PASSWORDS[@]}"; do
        echo "$p" >> "$FILENAME"
    done
    print_success "Passwords saved to: ${BOLD}$FILENAME${NC}"
fi

echo -e "\n${GREEN}Thank you for using the Secure Password Generator!${NC}"
