#!/bin/bash

# Your bot token and user ID
BOT_TOKEN="ENTER BOT TOKEN HERE"
CHAT_ID="ENTER TELEGRAM ID HERE"

# Root directory to search for .sh and .py files
ROOT_DIRECTORY="."

# Log file to track sent files
SENT_FILES_LOG="/root/sent_files.log"

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

# Function to check if a file has been sent before
file_sent_before() {
    local file_path=$1
    grep -Fxq "$file_path" "$SENT_FILES_LOG"
}

# Find and send all .sh and .py files in the root directory and its subdirectories
file_count=0
while IFS= read -r file; do
    if ! file_sent_before "$file"; then
        echo "Sending $file to Telegram..."
        send_file "$file"
        echo "Sent $file."
        echo "$file" >> "$SENT_FILES_LOG"
        file_count=$((file_count + 1))
    else
        echo "$file has already been sent. Skipping."
    fi
done < <(find "${ROOT_DIRECTORY}" -type f -name "*.sh" -o -name "*.py")

# Check if no files were found
if [ $file_count -eq 0 ]; then
    echo "No new .sh or .py files found to send."
else
    # Send a message with the folder name after all files have been sent
    echo "Sending root directory name to Telegram..."
    send_message "All new .sh and .py files have been sent from the directory: ${ROOT_DIRECTORY}"
    echo "Sent root directory name."
fi

# JvckM3 @ 2024 > add a star if you find it helpful 🙂
