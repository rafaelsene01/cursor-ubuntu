#!/bin/bash

installCursor() {
    # URLs for Cursor AppImage and Icon
    CURSOR_URL="https://downloads.cursor.com/production/faa03b17cce93e8a80b7d62d57f5eda6bb6ab9fa/linux/x64/Cursor-1.2.2-x86_64.AppImage"
    ICON_URL="https://registry.npmmirror.com/@lobehub/icons-static-png/latest/files/dark/cursor.png"

    # Paths for installation
    APPIMAGE_PATH="/opt/cursor.appimage"
    ICON_PATH="/opt/cursor.png"
    DESKTOP_ENTRY_PATH="/usr/share/applications/cursor.desktop"

    # Install curl if not installed
    if ! command -v curl &> /dev/null; then
        echo "curl is not installed. Installing..."
        sudo apt-get update
        sudo apt-get install -y curl
    fi

    if [ -f "$APPIMAGE_PATH" ]; then
        echo "Cursor AI IDE is already installed. Do you want to update? (y/n)"
        read -r resposta
        if [[ ! "$resposta" =~ ^[yY]$ ]]; then
            echo "Exiting without updating."
            return
        fi
        echo "Do you want to close all open Cursor instances before updating? (y/n)"
        read -r fechar
        if [[ "$fechar" =~ ^[yY]$ ]]; then
            PIDS=$(pgrep -f /opt/cursor.appimage)
            if [ -n "$PIDS" ]; then
                echo "Found running Cursor process(es): $PIDS"
                echo "Closing instances..."
                pkill -9 -f /opt/cursor.appimage
                sleep 2
                # Check if any process remains
                if pgrep -f /opt/cursor.appimage > /dev/null; then
                    echo "Warning: Some Cursor instances could not be closed."
                else
                    echo "All Cursor instances have been closed."
                fi
            else
                echo "No running Cursor instances found."
            fi
        fi
        echo "Updating Cursor AI IDE..."
        sudo rm -f $APPIMAGE_PATH
    else
        echo "Installing Cursor AI IDE..."
    fi

    # Download Cursor AppImage
    echo "Downloading Cursor AppImage..."
    sudo curl -L $CURSOR_URL -o $APPIMAGE_PATH
    sudo chmod +x $APPIMAGE_PATH

    # Download Cursor icon
    echo "Downloading Cursor icon..."
    sudo curl -L $ICON_URL -o $ICON_PATH

    # Create .desktop entry for Cursor
    echo "Creating .desktop entry for Cursor..."
    sudo bash -c "cat > $DESKTOP_ENTRY_PATH" <<EOL
[Desktop Entry]
Name=Cursor AI IDE
Exec=$APPIMAGE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;
EOL

    # Add alias to .bashrc if not exists
    if ! grep -q 'function cursor()' "$HOME/.bashrc"; then
        echo "Adding cursor alias to .bashrc..."
        bash -c "cat >> $HOME/.bashrc" <<EOL

# Cursor alias
function cursor() {
    ( /opt/cursor.appimage --no-sandbox \"\$@\" & ) > /dev/null 2>&1
}
EOL
        source $HOME/.bashrc
    fi

    echo "Cursor AI IDE installation/update complete. You can find it in your application menu."
}

installCursor