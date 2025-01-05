#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if a command exists
check_and_install() {
    local cmd=$1
    local pkg=$2

    if ! command -v $cmd &>/dev/null; then
        echo -e "${RED}$cmd is not installed. Installing $pkg...${NC}"
        sudo apt update && sudo apt install -y $pkg
        if command -v $cmd &>/dev/null; then
            echo -e "${GREEN}$cmd installed successfully.${NC}"
        else
            echo -e "${RED}Failed to install $pkg. Please check your package manager.${NC}"
        fi
    else
        echo -e "${GREEN}$cmd is already installed.${NC}"
    fi
}

# Install yt-dlp via pip
install_yt_dlp() {
    if ! command -v yt-dlp &>/dev/null; then
        echo -e "${RED}yt-dlp is not installed. Installing it using pip...${NC}"
        python3 -m pip install -U "yt-dlp[default]" --break-system-packages
        if command -v yt-dlp &>/dev/null; then
            echo -e "${GREEN}yt-dlp installed successfully.${NC}"
        else
            echo -e "${RED}Failed to install yt-dlp. Please check your Python and pip setup.${NC}"
        fi
    else
        echo -e "${GREEN}yt-dlp is already installed.${NC}"
    fi
}

# List of tools and their corresponding packages
declare -A tools
tools=(
    ["nmap"]="nmap"
    ["gobuster"]="gobuster"
    ["curl"]="curl"
    ["jq"]="jq"
    ["w3m"]="w3m"
    ["speedtest-cli"]="speedtest-cli"
    ["cowsay"]="cowsay"
    ["lolcat"]="lolcat"
)

# Install tools
echo -e "${GREEN}Starting setup...${NC}"

for tool in "${!tools[@]}"; do
    check_and_install "$tool" "${tools[$tool]}"
done

# Install yt-dlp
install_yt_dlp

# Final message
echo -e "${GREEN}All required tools have been installed. You're ready to run the main script!${NC}"
