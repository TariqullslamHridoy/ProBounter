#!/bin/bash

# =================================================================
# Name        : ProBounter v2.0 (Break For Bounty HW6)
# Author      : tariqul.cx
# =================================================================


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' 

banner() {
    clear
    echo -e "${PURPLE}"
    echo "  ____             ____                    _            "
    echo " |  _ \ _ __ ___  | __ )  ___  _   _ _ __ | |_ ___ _ __ "
    echo " | |_) | '__/ _ \ |  _ \ / _ \| | | | '_ \| __/ _ \ '__|"
    echo " |  __/| | | (_) || |_) | (_) | |_| | | | | ||  __/ |   "
    echo " |_|   |_|  \___/ |____/ \___/ \__,_|_| |_|\__\___|_|   "
    echo -e "${CYAN}${BOLD}     >>> Professional Recon Tool for Break For Bounty HW6 @CyberTariqul <<<${NC}\n"
}

show_help() {
    banner 
    echo -e "${YELLOW}${BOLD}Usage Instructions:${NC}"
    echo -e "  $0 -t <target_domain>   ${BLUE} To start scanning a target${NC}"
    echo -e "  $0 -h                   ${BLUE} To see this help menu${NC}"
    echo -e "\n${CYAN}Example:${NC} ./pro_bounter.sh -t <target_domain>"
    echo "--------------------------------------------------------"
}

log_result() {
    local type=$1
    local msg=$2
    case $type in
        "info") echo -e "${BLUE}[INFO]${NC} $msg" ;;
        "success") echo -e "${GREEN}[+]${NC} $msg" ;;
        "warn") echo -e "${YELLOW}[!]${NC} $msg" ;;
        "error") echo -e "${RED}[ERROR]${NC} $msg" ;;
    esac
}

start_recon() {
    local TARGET=$1
    local DIR="recon_$(date +%F_%H-%M)_$TARGET"
    mkdir -p "$DIR"

    log_result "info" "Session started for: $TARGET"
    
    log_result "info" "Gathering DNS Intelligence..."
    dig +short ANY "$TARGET" > "$DIR/dns_info.txt"
    log_result "success" "DNS data captured."

    log_result "info" "Scanning Top 1000 Ports... Please wait."
    nmap -sV --top-ports 1000 "$TARGET" -oN "$DIR/nmap_report.txt"
    log_result "success" "Port scan finished."

    log_result "info" "Auditing HTTP Security Headers..."
    curl -I -L -s --max-time 10 "$TARGET" > "$DIR/headers.txt"
    
    local VULN_FOUND=0
    for header in "Content-Security-Policy" "X-Frame-Options" "Strict-Transport-Security" "X-Content-Type-Options"; do
        if ! grep -qi "$header" "$DIR/headers.txt"; then
            log_result "warn" "ALERT: $header is MISSING!"
            echo "[!] $header is missing" >> "$DIR/vulnerabilities.txt"
            ((VULN_FOUND++))
        fi
    done

    echo -e "\n${CYAN}${BOLD}================ REPORT SUMMARY ================${NC}"
    log_result "success" "Scan Complete! Results stored in: $DIR/"
    log_result "info" "Total Security Issues Found: $VULN_FOUND"
    echo -e "${CYAN}${BOLD}================================================${NC}"
}

if [ "$#" -lt 1 ]; then
    show_help
    exit 1
fi

while getopts ":t:h" opt; do
    case ${opt} in
        t ) 
            banner
            start_recon "$OPTARG"
            ;;
        h )
            show_help
            exit 0
            ;;
        \? )
            log_result "error" "Invalid option: -$OPTARG"
            show_help
            exit 1
            ;;
    esac
done