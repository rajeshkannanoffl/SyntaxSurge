#!/bin/bash

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                         (START OF FILE)                              ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

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
    echo -e "   ${WHITE}This script copies all the contents from a source directory to a destination directory.${NC}"
    echo -e "${YELLOW}Options:${NC}"
    echo -e "   ${GREEN}None${NC} - The script will prompt you to enter the source and destination directories."
    sleep 2
    exit 1
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                      (Credits and History)                           ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

print_credits () {

    # Clear the terminal
    clear

    #local variables for the credits
    local width=70
    local title="SCRIPT INFO"
    local filename="copy_script.sh"
    local usage="sh copy_script.sh"
    local description="This script copies all contents from a source directory to thedestination directory. Ensure the source directory exists before running the script."
    local options="None"
    local requirements="-"
    local bugs="-"
    local notes="Bash Scripts will run only in the UNIX/Linux Shell."
    local author="Rajesh Kannan M"
    local email="rajeshkannan.offl@gmail.com"
    local url="https://linkedin.com/in/rajeshkannanoffl"
    local company="-"
    local version="0.1"
    local created="2024-07-16"
    local revision="2024-07-16"

    # wrap the text to the next file
    wrap_text() {
        local text="$1"
        local max_width=$2
        while [ ${#text} -gt $max_width ]; do
            local line="${text:0:$max_width}"
            local space_pos=$(echo "$line" | awk '{print length($0)-length($NF)}')
            if [ $space_pos -gt 0 ]; then
                echo "${text:0:$space_pos}"
                text="${text:$space_pos}"
            else
                echo "$line"
                text="${text:$max_width}"
            fi
        done
        echo "$text"
    }

    # Display all the credits
    printf "# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ %s ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n" "$title"
    printf "# ┃                %-62s┃\n" " "
    printf "# ┃ VERSION     : %-62s ┃\n" "$version"
    printf "# ┃ REVISION    : %-62s ┃\n" "$revision"
    printf "# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫\n"
    printf "# ┃ FILE        : %-62s ┃\n" "$filename"
    printf "# ┃ USAGE       : %-62s ┃\n" "$usage"
    printf "# ┃ DESCRIPTION : %-62s ┃\n" "$(echo "$description" | head -c 62)"
    wrap_text "${description:62}" 62 "# ┃" | while IFS= read -r line; do
        printf "# ┃               %-62s ┃\n" "$line"
    done
    printf "# ┃ OPTIONS     : %-62s ┃\n" "$options"
    printf "# ┃ REQUIREMENTS: %-62s ┃\n" "$requirements"
    printf "# ┃ BUGS        : %-62s ┃\n" "$bugs"
    printf "# ┃ NOTES       : %-62s ┃\n" "$notes"
    printf "# ┃ CREATED     : %-62s ┃\n" "$created"
    printf "# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫\n"
    printf "# ┃ AUTHOR      : %-62s ┃\n" "$author"
    printf "# ┃ EMAIL       : %-62s ┃\n" "$email"
    printf "# ┃ URL         : %-62s ┃\n" "$url"
    printf "# ┃ COMPANY     : %-62s ┃\n" "$company"
    printf "# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛\n"
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃             (Prompting for Confirmation and Input)                   ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

confirm_process () {
    # Prompt user to confirm before proceeding
    echo -e "#
#"
    echo -en "# ${GREEN}Do you want to proceed with executing the script? [y/n]: ${NC}"
    read -t 60 -r user_input  # Wait for 60 seconds for user input

    # Check user's input
    if [[ ! "$user_input" =~ ^[Yy]$|^yes$|^YES$ ]]; then
        echo -e "# ${RED}Script execution aborted by user. (Retry & Use: y/Y/yes/YES)${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}End of the Process!!!. Welcome again!!!.${NC}"
        sleep 3
        exit 1
    fi

    # Continue with script execution here
    echo -e "# ${RED}Proceeding with script execution...${NC}"
    sleep 2
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃             (Inputs from the User to start the Process)              ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

user_input () {
    # Clear the terminal
    clear

    # Prompt user for the source directory
    echo -e "#"
    echo -e "# ${YELLOW}Example: If path is C:\Path, then input should be /c/Path${NC}"
    echo -e "#"
    echo -en "# ${GREEN}Enter the source directory: ${NC}"
    read -r SOURCE_DIR

    # Prompt user for the destination directory
    echo -en "# ${PINK}Enter the destination directory: ${NC}"
    read -r DESTINATION_DIR
    echo -e "#"

    # Check if source directory exists
    if [ ! -d "$SOURCE_DIR" ]; then
        echo -e "# ${RED}Error: Source directory does not exist: $SOURCE_DIR${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}End of the Process!!!. Welcome again!!!.${NC}"
        sleep 3
        exit 1
    fi

    # Check if destination directory exists, create if it doesn't
    if [ ! -d "$DESTINATION_DIR" ]; then
        echo -e "# ${RED}Destination directory does not exist.${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}Creating Destination Directory: $DESTINATION_DIR${NC}"
        echo -e "#"
        mkdir -p "$DESTINATION_DIR"
    fi
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃             (Copying Files and Verifying Operation)                  ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# Copy contents from source to destination
copy_contents() {

    # Calculate the size of the source folder in bytes
    total_size=$(du -sb "$SOURCE_DIR" | cut -f1)

    # Define an average copy speed in bytes per second (e.g., 50 MB/s)
    avg_copy_speed=$((10 * 1024 * 1024))

    # Estimate the time required to copy (in seconds)
    est_time=$((total_size / avg_copy_speed))

    # Convert estimated time to minutes and seconds
    est_minutes=$((est_time / 60))
    est_seconds=$((est_time % 60))

    # Display the estimated time
    echo -e "# ${YELLOW}Estimated time to copy: ${est_minutes}m ${est_seconds}s${NC}"

    # Confirm the process
    echo -e "#"
    echo -en "# ${GREEN}Do you want to continue this process? [y/n]: ${NC}"
    read -t 10 -r user_input  # Wait for 10 seconds for user input

    # Check user's input
    if [[ ! "$user_input" =~ ^[Yy]$|^yes$|^YES$ ]]; then
        echo "#"
        echo -e "# ${RED}Process execution aborted by user. (Retry & Use: y/Y/yes/YES)${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}End of the Process!!!. Welcome again!!!.${NC}"
        sleep 3
        exit 1
    fi

    echo "#"
    
    # Get total number of files and directories to copy
    total_files=$(find "$SOURCE_DIR" -type f | wc -l)
    total_dirs=$(find "$SOURCE_DIR" -type d | wc -l)

    # Calculate total items (files + directories)
    total_items=$((total_files + total_dirs))

    # Check if there are items to copy
    if [ "$total_items" -eq 0 ]; then
        echo -e "#"
        echo -e "# ${RED}Error: No files or directories found in $SOURCE_DIR${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}End of the Process!!!. Welcome again!!!.${NC}"
        sleep 3
        exit 1
    fi

    # Display the list of directories to be copied
    echo -e "# ${GREEN}List of Directories to be copied:${NC}"
    for dir in "${total_dirs}"; do
        echo -e "# $dir"
    done

    # Display the list of files to be copied
    echo -e "#"
    echo -e "# ${PINK}List of Files to be copied:${NC}"
    for file in "${total_files}"; do
        echo -e "# $file"
    done

    copied_items=0

    echo "#"

    # Copy files and directories with progress indicator
    for item in "$SOURCE_DIR"/*; do
        cp -r "$item" "$DESTINATION_DIR"
        copied_items=$((copied_items + 1))

        # Calculate progress percentage
        progress=$((copied_items * 100 / total_items))
        
        # Display progress bar with colored dots
        echo -ne "# Task Status: $progress% ["
        
        # Calculate number of dots and spaces for progress bar
        num_dots=$((progress * 50 / 100))
        num_spaces=$((50 - num_dots))
        
        # Print dots
        for ((i = 0; i < num_dots; i++)); do
            echo -n "*"
        done
        
        # Print spaces
        for ((i = 0; i < num_spaces; i++)); do
            echo -n " "
        done
        
        echo -ne "\r"
    done

    # Ensure progress bar reaches 100% at the end
    echo -ne "# 100% ["
    for ((i = 0; i < 50; i++)); do
        echo -n "*"
    done
    echo -ne "] Completed\n"
}



# Verify the copy operation
process_summary () {
    if [ "$?" -eq 0 ]; then
        echo -e "#"
        echo -e "# ${GREEN}Task Completed!!!. Successfully copied contents from $SOURCE_DIR to $DESTINATION_DIR${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}End of the Process!!!. Welcome again!!!.${NC}"
        sleep 3
        exit 1
    else
        echo -e "#"
        echo -e "# ${RED}Task Failed!!!. Unable to copy contents from $SOURCE_DIR to $DESTINATION_DIR${NC}"
        echo -e "#"
        echo -e "# ${YELLOW}End of the Process!!!. Welcome again!!!.${NC}"
        sleep 3
        exit 1
    fi
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                       (Total Run)                                    ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

{
    if [ "$#" -ne 0 ]; then
        usage
    fi
    print_credits
    confirm_process
    user_input
    copy_contents
    process_summary
}

# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃                          (END OF FILE)                               ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛