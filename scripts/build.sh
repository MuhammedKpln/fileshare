#!/bin/bash
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

printf "${CYAN} TASK: Clean build_runner\n${NC}"
flutter pub run build_runner clean
printf "${CYAN} TASK: Generate locale files\n${NC}"
source $(pwd)/scripts/generate_locale.sh
printf "${GREEN} DONE: Generating locale files\n${NC}"

printf "${CYAN} TASK: Watching\n${NC}"
flutter pub run build_runner watch --delete-conflicting-outputs
