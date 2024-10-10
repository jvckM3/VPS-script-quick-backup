### VPS-script-quick-backup
Back up the scripts you frequently use with VPS to avoid recreating them every time you rent a new temporary VPS
Automate Your VPS Script Backups to Telegram

## Introduction

This script automates the process of sending .sh and .py files from your VPS to a Telegram chat. This script is designed to only send previously unsent files.

>[!TIP]
>you can edit the code to bypass that as illustrated at the end.

## Procedure

1. Clone the Repository: Clone this repository to the directory containing your script (s).

        git clone https://github.com/yourusername/yourrepository.git
        cd yourrepository


2. Edit the Script: Open the script scriptbackup.sh in a text editor and update the following placeholders with your Telegram details:
 - for terminal, use the command 'nano scriptbackup.sh'

BOT_TOKEN="ENTER BOT TOKEN HERE"
CHAT_ID="ENTER TELEGRAM ID HERE"

Replace *ENTER BOT TOKEN HERE* with your actual bot token and *ENTER TELEGRAM ID HERE* with your chat ID.


3. Make the Script Executable:

        chmod +x scriptbackup.sh


4. Run the Script:

        ./scriptbackup.sh

This will start the script, which will find and send all .sh and .py files in the root directory and its subdirectories to your specified Telegram chat.

## Changing the log location 
Update the SENT_FILES_LOG variable in the script to change where the log file is stored.

## Resend all files again 
If you want to resend all files, simply delete the log file:

    rm /root/sent_files.log
