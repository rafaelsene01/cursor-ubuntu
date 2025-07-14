# Cursor AI IDE Installer/Updater

This repository contains a shell script (`run.sh`) to automate the installation and update of the [Cursor AI IDE](https://www.cursor.so/) on Linux systems.

## Features

- Downloads and installs the latest Cursor AI IDE AppImage and icon
- Creates a desktop entry for easy access from your application menu
- Adds a convenient `cursor` alias to your `.bashrc`
- Checks for existing installations and offers to update if already installed
- Optionally closes all running Cursor instances before updating
- Installs `curl` if not present

## Requirements

- Linux system (tested on Ubuntu)
- `sudo` privileges (required to write to `/opt` and `/usr/share/applications`)
- Internet connection

## Usage

1. **Clone or download this repository.**
2. **Run the script in your terminal:**
   ```bash
   bash run.sh
   ```
   or, if not executable:
   ```bash
   chmod +x run.sh
   ./run.sh
   ```
3. **Follow the on-screen prompts:**
   - If Cursor is already installed, you will be asked if you want to update.
   - You can choose to close all running Cursor instances before updating.

## What the Script Does

- Downloads the latest Cursor AppImage and icon to `/opt`.
- Creates a desktop entry at `/usr/share/applications/cursor.desktop`.
- Adds a `cursor` function alias to your `.bashrc` for easy launching from the terminal.
- Ensures `curl` is installed for downloading files.

## Uninstallation

To remove Cursor AI IDE, delete the following files manually:

- `/opt/cursor.appimage`
- `/opt/cursor.png`
- `/usr/share/applications/cursor.desktop`
- Remove the `cursor` alias from your `~/.bashrc` if desired.

## Important: Updating to New Versions

- The script uses a variable called `CURSOR_URL` inside `run.sh` to define the download link for the Cursor AppImage.
- **If a new version of Cursor is released, you must manually update the `CURSOR_URL` in the script to the latest AppImage URL.**

## License

This script is provided as-is, without warranty. Use at your own risk.
