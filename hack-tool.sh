#!/bin/bash

# Function: Check if required commands exist
check_dependencies() {
	required_cmds=("nmap" "gobuster" "curl" "jq" "w3m" "yt-dlp" "speedtest-cli" "cowsay" "lolcat")
	for cmd in "${required_cmds[@]}"; do
		if ! command -v $cmd &>/dev/null; then
			echo "Error: $cmd is not installed. Please install it and try again."
			exit 1
		fi
	done
}

# Functions for each feature
nmap_scan() {
	echo 'Running Nmap Scan...'
	read -p "Enter Target IP or Domain: " target
	nmap -sC -sV "$target"
}

dir_enum() {
	echo 'Running Gobuster...'
	read -p 'Enter Target URL (Add http or https): ' url
	gobuster dir -u "$url" -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 200 -x php 2>/dev/null
}

browse_web() {
	echo 'Web Browser...'
	read -p 'Enter the URL: ' url
	gnome-terminal -- w3m "$url" 2>/dev/null
}

get_ip() {
	echo 'Fetching your public IP address...'
	curl -s https://api64.ipify.org
	echo
}

check_ip() {
	echo 'Checking IP Info...'
	read -p 'Enter the Public IP: ' ip
	curl -s "http://ip-api.com/json/$ip" | jq
}

url_short_info() {
	echo 'Fetching Original URL from Shortened URL...'
	read -p 'Enter the Shortened URL: ' short_url

	location=$(curl -I -Ls "$short_url" | grep -i 'Location' | awk 'NR>1 {print $2}' | tr -d '\r')

	if [ -z "$location" ]; then
		echo "No Redirect Found. The URL might not be shortened."
	else
		echo "Original URL(s):"
		echo "$location"
	fi
}

system_monitor() {
	echo 'Checking System Resources...'
	echo 'CPU Usage:'
	top -bn1 | grep "Cpu(s)"
	echo 'Memory Usage:'
	free -h
	echo "Disk Usage:"
	df -h
}

internet_speed() {
	echo 'Checking Internet Speed...'
	speedtest-cli --simple
}

password_gen() {
	echo 'Generating a Random Password...'
	echo ''
	head /dev/urandom | tr -dc A-Za-z0-9 | head -c 16
	echo ""
}

weather_info() {
	echo 'Fetching Weather Information...'
	read -p 'Enter City Name (Ex. Kolkata): ' city
	curl -s "https://wttr.in/$city?format=3"
}

youtube_download() {
	echo 'YouTube Video Downloader...'
	read -p 'Enter YouTube URL: ' yt_url
	read -p 'Enter Download Format (e.g., mp4, mp3): ' format
	yt-dlp -f "$format" "$yt_url"
	echo 'Download Complete!'
}

# Welcome Message
cowsay "Welcome to the Ultimate Hacking Tool" | lolcat
echo '============================' | lolcat
echo 'Author: Parzival' | lolcat
echo ''

# Menu Loop
while true; do
	echo ''
	echo 'Options:'
	echo '1 ) Nmap Scan'
	echo '2 ) Directory Brute Force'
	echo '3 ) Browse a Website'
	echo '4 ) Get Public IP'
	echo '5 ) Check IP Info'
	echo '6 ) Check Short URL Info'
	echo '7 ) System Monitor'
	echo '8 ) Check Internet Speed'
	echo '9 ) Random Password Generator' 
	echo '10) Get Weather Info'
	echo '11) Download YouTube Video'
	echo '12) Clear Terminal'
	echo '13) Exit'
	echo ''

	read -p "Enter your choice (1-13): " choice

	case $choice in
		1) nmap_scan ;;
		2) dir_enum ;;
		3) browse_web ;;
		4) get_ip ;;
		5) check_ip ;;
		6) url_short_info ;;
		7) system_monitor ;;
		8) internet_speed ;;
		9) password_gen ;;
		10) weather_info ;;
		11) youtube_download ;;
		12) clear ;;
		13)
			echo 'Exiting...'
			exit 0
			;;
		*) 
			echo 'Invalid Option. Please Try Again!' ;;
	esac
done
