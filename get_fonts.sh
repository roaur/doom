#!/bin/bash

# Set variables
DOWNLOAD_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip"
FONT_DIR="$HOME/.fonts"
ZIP_FILE="/tmp/FiraCode.zip"

# Create fonts directory if it doesn't exist
if [ ! -d "$FONT_DIR" ]; then
    echo "Creating font directory: $FONT_DIR"
    mkdir -p "$FONT_DIR"
fi

# Download the file
echo "Downloading FiraCode.zip..."
wget -O "$ZIP_FILE" "$DOWNLOAD_URL"

# Check if the download was successful
if [ $? -ne 0 ]; then
    echo "Failed to download FiraCode.zip"
    exit 1
fi

# Extract the contents to the fonts directory
echo "Extracting contents to $FONT_DIR..."
unzip -o "$ZIP_FILE" -d "$FONT_DIR"

# Check if extraction was successful
if [ $? -ne 0 ]; then
    echo "Failed to extract FiraCode.zip"
    exit 1
fi

# Clean up the temporary zip file
echo "Cleaning up..."
rm "$ZIP_FILE"

# Refresh font cache
echo "Refreshing font cache..."
fc-cache -fv

echo "FiraCode fonts installed successfully!"
