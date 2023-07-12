#!/bin/bash

# Ask for user name
read -p "Please enter your name (상원: s, 원철: w, 예진: y, 예은: n, 려환: r): " user

case $user in
  s)
    user_name="상원"
    ;;
  w)
    user_name="원철"
    ;;
  y)
    user_name="예진"
    ;;
  n)
    user_name="예은"
    ;;
  r)
    user_name="려환"
    ;;
  *)
    echo "Invalid user."
    exit 1
    ;;
esac

# Ask for the topic and create the folder if it doesn't exist
read -p "Please enter the topic: " topic
folder_name="${user_name}/${topic}"

if [ -d "$folder_name" ]; then
  echo "Folder already exists: $folder_name"
else
  mkdir -p "$folder_name"
  echo "Folder created: $folder_name"
fi

# Ask for the detail topic and create the markdown file
read -p "Please enter the detail topic: " detail_topic
file_name="$(date +%y-%m-%d)-${detail_topic}.md"
file_path="${folder_name}/${file_name}"

touch "$file_path"
echo "Markdown file created: $file_path"
