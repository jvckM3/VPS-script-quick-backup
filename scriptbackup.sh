#!/bin/bash

# Your bot token and user ID
BOT_TOKEN="ENTER BOT TOKEN HERE"
CHAT_ID="ENTER TELEGRAM ID HERE"

# Root directory to search for .sh and .py files
ROOT_DIRECTORY="."

# Function to send a file via Telegram
send_file() {
    local file_path=$1
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendDocument" \
        -F chat_id="${CHAT_ID}" \
        -F document=@"${file_path}"
}

# Function to send a text message via Telegram
send_message() {
    local message=$1
    curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
        -d chat_id="${CHAT_ID}" \
        -d text="${message}"
}

# Find and send all .sh and .py files in the root directory and its subdirectories
file_count=0
while IFS= read -r file; do
    echo "Sending $file to Telegram..."
    send_file "$file"
    echo "Sent $file."
    file_count=$((file_count + 1))
done < <(find "${ROOT_DIRECTORY}" -type f -name "*.sh" -o -name "*.py")

# Check if no files were found
if [ $file_count -eq 0 ]; then
    echo "No .sh or .py files found in the directory."
else
    # Send a message with the folder name after all files have been sent
    echo "Sending root directory name to Telegram..."
    send_message "All .sh and .py files have been sent from the directory: ${ROOT_DIRECTORY}"
    echo "Sent root directory name."
fi

# JvckM3 @ 2024 > add a star if you find it helpful 🙂
