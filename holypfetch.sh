#!/bin/bash

# Check if jq and pfetch are installed
if ! command -v jq &> /dev/null || ! command -v pfetch &> /dev/null; then
    echo "Error: jq or pfetch is not installed."
    exit 1
fi

# Define colors
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Clear the screen
clear

# Hide the cursor
tput civis

# Display menu
while true; do
    echo -e "${YELLOW}Menu:${NC}"
    echo -e "${YELLOW}1. Manual without cross${NC}"
    echo -e "${YELLOW}2. Automatic without cross${NC}"
    echo -e "${YELLOW}3. Manual with cross${NC}"
    echo -e "${YELLOW}4. Automatic with cross${NC}"
    echo -e "${YELLOW}5. Uninstall${NC}"
    echo -e "${YELLOW}6. Exit${NC}"

    # Get user choice
    read -p "" choice

    case $choice in
        1)
            # Add actions for Manual without cross
            echo "You chose Manual without cross."
            # Add function to ~/.bashrc
            echo '
# Function to fetch a random Bible verse
fetch_verse() {
  local verse_json=$(curl -s "https://labs.bible.org/api/?passage=random&type=json")
  local verse_text=$(echo "$verse_json" | jq -r ".[0].text")
  local verse_reference=$(echo "$verse_json" | jq -r ".[0].bookname + \" \" + .[0].chapter + \":\" + .[0].verse")
  echo -e "\nVerse of the terminal session:\n$verse_text\n\n- $verse_reference\n"
}

# Function to run pfetch and fetch a random Bible verse
holypfetch() {
  pfetch
  fetch_verse
}

# Run holypfetch if it is explicitly called
if [ "$1" == "holypfetch" ]; then
  holypfetch
fi' >> ~/.bashrc
            echo "Function added to ~/.bashrc. Rerun Terminal to apply changes."
            ;;
        2)
            # Add actions for Automatic without cross
            echo "You chose Automatic without cross."
            # Add function to ~/.bashrc
            echo '
# Function to fetch a random Bible verse
fetch_verse() {
  local verse_json=$(curl -s "https://labs.bible.org/api/?passage=random&type=json")
  local verse_text=$(echo "$verse_json" | jq -r ".[0].text")
  local verse_reference=$(echo "$verse_json" | jq -r ".[0].bookname + \" \" + .[0].chapter + \":\" + .[0].verse")
  echo -e "\nVerse of the terminal session:\n$verse_text\n\n- $verse_reference\n"
}

# Function to run pfetch and fetch a random Bible verse
holypfetch() {
  pfetch
  fetch_verse
}

# Check if this is a new terminal session
if [ -z "$HOLY_FETCH_DONE" ]; then
  export HOLY_FETCH_DONE=true
  holypfetch
fi' >> ~/.bashrc
            echo "Function added to ~/.bashrc. Rerun Terminal to apply changes"
            ;;
        3)
            # Add actions for Manual with cross
            echo "You chose Manual with cross."
            # Backup pfetch
            sudo cp /usr/bin/pfetch /usr/bin/pfetch.backup
            # Add functions directly to ~/.bashrc
            echo '
# Function to fetch a random Bible verse
fetch_verse() {
  local verse_json=$(curl -s "https://labs.bible.org/api/?passage=random&type=json")
  local verse_text=$(echo "$verse_json" | jq -r ".[0].text")
  local verse_reference=$(echo "$verse_json" | jq -r ".[0].bookname + \" \" + .[0].chapter + \":\" + .[0].verse")
  echo -e "\nVerse of the terminal session:\n$verse_text\n\n- $verse_reference\n"
}

# Function to run pfetch with custom ASCII art and fetch a random Bible verse
holypfetch() {
  PF_ASCII="cross" pfetch
  fetch_verse
}

# Run holypfetch if it is explicitly called
if [ "$1" == "holypfetch" ]; then
  holypfetch
fi' >> ~/.bashrc
            # Additional script execution
            echo "# Check if running with sudo
if [ \"\$EUID\" -ne 0 ]
then
  sudo \"\$0\" \"\$@\"
  exit \$?
fi

# Path to the pfetch file
pfetch_file=\"/usr/bin/pfetch\"

# Text to add to line 1349
custom_text='                [Cc]ross*)
            read_ascii 4 <<-EOF
\${c3}    .-.
\${c3}  __| |__
\${c3} [__   __]
\${c3}    | |
\${c3}    | |
\${c3}    | |
\${c3}    '\''-'\''
EOF
        ;;'

# Insert the custom text at line 1349
awk -v line=1349 -v text=\"\$custom_text\" 'NR == line {print text} {print}' \"\$pfetch_file\" > \"\${pfetch_file}.tmp\"

# Replace the original file with the modified file
mv \"\${pfetch_file}.tmp\" \"\$pfetch_file\"

# Make the pfetch file executable
chmod +x \"\$pfetch_file\"

echo \"Custom text added to line 1349 of pfetch.\"" >> /tmp/holypfetch_tmp_script.sh
            chmod +x /tmp/holypfetch_tmp_script.sh
            /tmp/holypfetch_tmp_script.sh
            ;;
        4)
            # Add actions for Automatic with cross
            echo "You chose Automatic with cross."
            # Add function to ~/.bashrc
            cat << 'EOF' >> ~/.bashrc
# Function to fetch a random Bible verse
fetch_verse() {
  local verse_json=$(curl -s "https://labs.bible.org/api/?passage=random&type=json")
  local verse_text=$(echo "$verse_json" | jq -r '.[0].text')
  local verse_reference=$(echo "$verse_json" | jq -r '.[0].bookname + " " + .[0].chapter + ":" + .[0].verse')
  echo -e "\nVerse of the terminal session:\n$verse_text\n\n- $verse_reference\n"
}

# Function to run pfetch with custom ASCII art and fetch a random Bible verse
holypfetch() {
  PF_ASCII="cross" pfetch
  fetch_verse
}

# Check if this is a new terminal session
if [ -z "$HOLY_FETCH_DONE" ]; then
  export HOLY_FETCH_DONE=true
  holypfetch
fi
EOF
# Additional script execution
echo "# Check if running with sudo
if [ \"\$EUID\" -ne 0 ]
then
  sudo \"\$0\" \"\$@\"
  exit \$?
fi

# Path to the pfetch file
pfetch_file=\"/usr/bin/pfetch\"

# Text to add to line 1349
custom_text='                [Cc]ross*)
            read_ascii 4 <<-EOF
\${c3}    .-.
\${c3}  __| |__
\${c3} [__   __]
\${c3}    | |
\${c3}    | |
\${c3}    | |
\${c3}    '\''-'\''
EOF
        ;;'

# Insert the custom text at line 1349
awk -v line=1349 -v text=\"\$custom_text\" 'NR == line {print text} {print}' \"\$pfetch_file\" > \"\${pfetch_file}.tmp\"

# Replace the original file with the modified file
mv \"\${pfetch_file}.tmp\" \"\$pfetch_file\"

# Make the pfetch file executable
chmod +x \"\$pfetch_file\"

echo \"Custom text added to line 1349 of pfetch.\"" >> /tmp/holypfetch_tmp_script.sh
chmod +x /tmp/holypfetch_tmp_script.sh
/tmp/holypfetch_tmp_script.sh
            ;;
        5)
            # Add actions for Uninstall
            echo "Uninstalling holypfetch..."
           #Remove all added text from ~/.bashrc
            sed -i '/fetch_verse/d' ~/.bashrc
            sed -i '/holypfetch/d' ~/.bashrc
            sed -i '/HOLY_FETCH_DONE/d' ~/.bashrc
            sed -i '/# Function to fetch a random Bible verse/,/# fi/d' ~/.bashrc
            sed -i '/# Function to run pfetch with custom ASCII art and fetch a random Bible verse/,/# fi/d' ~/.bashrc
             # Restore pfetch from backup if it exists
            if [ -f /usr/bin/pfetch.backup ]; then
                sudo mv /usr/bin/pfetch.backup /usr/bin/pfetch
            fi
            echo "Holypfetch uninstalled. Please  remove pfetch and jq manually to properly unistall holyfetch. "
            ;;

        6)
            echo "Exiting..."
            # Show the cursor
            tput cnorm
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac
done
