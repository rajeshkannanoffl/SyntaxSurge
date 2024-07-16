#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PINK='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
NC='\033[0m' # No Color

# Function to display usage information
usage() {
    echo -e "${YELLOW}Usage: ${RED}$0${NC}"
    echo -e "   ${WHITE}This exclusive script copies all the contents from a source directory to a destination directory.${NC}"
    echo -e "${YELLOW}Options:${NC}"
    echo -e "   ${GREEN}None${NC} - The script will prompt you to enter the source and destination directories."
    exit 1
}

# If the script is called with any arguments, display usage
if [ "$#" -ne 0 ]; then
    usage
fi

# Prompt user for the source directory
read -p "$(echo -e ${BLUE}Enter the source directory: ${NC})" SOURCE_DIR

# Prompt user for the destination directory
read -p "$(echo -e ${BLUE}Enter the destination directory: ${NC})" DESTINATION_DIR

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${RED}Source directory does not exist: $SOURCE_DIR${NC}"
    exit 1
fi

# Check if destination directory exists, create if it doesn't
if [ ! -d "$DESTINATION_DIR" ]; then
    echo -e "${RED}Destination directory does not exist. ${NC}"
    echo -e ""
    echo -e "${GREEN}Creating: $DESTINATION_DIR${NC}"
    mkdir -p "$DESTINATION_DIR"
fi

# Copy contents from source to destination
cp -r "$SOURCE_DIR"/* "$DESTINATION_DIR"

# Verify the copy operation
if [ "$?" -eq 0 ]; then
    echo -e "${GREEN}Task Completed!!!. Successfully copied contents from $SOURCE_DIR to $DESTINATION_DIR${NC}"
else
    echo -e "${RED}Task Failed!!!. Unable to copy contents from $SOURCE_DIR to $DESTINATION_DIR${NC}"
    exit 1
fi

echo ""
echo -e "2024 Rajesh Kannan M"
