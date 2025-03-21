alias pu="pod update"
alias pi="pod install"
# Usage: find_sim_file "iPhone 16" "iOS-18-0" "DataModel.sqlite"
find_sim_file() {
    IPHONE_NAME="$1"
    IOS_VERSION="$2"
    TARGET_FILE="$3"
    
    SIMULATOR_PATH="$HOME/Library/Developer/CoreSimulator/Devices"
    
    # First, find potential device.plist files more efficiently
    for plist in "$SIMULATOR_PATH"/*/device.plist; do
        # Use grep once with both patterns
        if grep -q "$IPHONE_NAME" "$plist" && grep -q "$IOS_VERSION" "$plist"; then
            DEVICE_FOLDER=$(dirname "$plist")
            
            # Search for the target file directly in the simulator folder
            FOUND_FILE=$(find "$DEVICE_FOLDER" -name "$TARGET_FILE" -type f -print -quit 2>/dev/null)
            if [[ -n "$FOUND_FILE" ]]; then
                echo "File found: $FOUND_FILE"
                return 0
            fi
        fi
    done
    
    echo "❌ No matching file found for $IPHONE_NAME running $IOS_VERSION!"
    return 1
}