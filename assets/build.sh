#!/bin/bash

# Specify the folder path
folder_path="./json/"

# Check if the specified folder exists
if [ ! -d "$folder_path" ]; then
	echo "Folder not found: $folder_path"
	exit 1
fi

# Get list of file names in the folder
file_names=$(ls "$folder_path")

# Create JSON structure
json="{\"commands\": ["
for file in $file_names; do
	json+="\"$file\","
done
json="${json%,}" # Remove the trailing comma
json+="]}"

# Write JSON to file
echo "$json" >./files.json

echo "JSON file created with file names: files.json"
