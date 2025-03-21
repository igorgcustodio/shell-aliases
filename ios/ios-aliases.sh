alias pu="pod update"
alias pi="pod install"

# Usage: find_sim_file "iPhone 16" "iOS-18-0" "DataModel.sqlite"
find_sim_file() {
    IPHONE_NAME="$1"
    IOS_VERSION="$2"
    TARGET_FILE="$3"
    
    SIMULATOR_PATH="$HOME/Library/Developer/CoreSimulator/Devices"
    
    # Use find to directly search for device.plist with both name and iOS version in one step
    DEVICE_FOLDER=$(find "$SIMULATOR_PATH" -type f -name "device.plist" -exec grep -i -l "$IPHONE_NAME" {} \; -exec grep -i -l "$IOS_VERSION" {} \; | head -n 1)

    if [[ -z "$DEVICE_FOLDER" ]]; then
        echo "❌ No matching simulator found for $IPHONE_NAME running $IOS_VERSION!"
        return 1
    fi
    
    # Get the directory where the device.plist file is located
    DEVICE_FOLDER=$(dirname "$DEVICE_FOLDER")
    
    # Search for the target file directly in the simulator folder
    FOUND_FILE=$(find "$DEVICE_FOLDER" -type f -name "$TARGET_FILE" 2>/dev/null | head -n 1)

    if [[ -z "$FOUND_FILE" ]]; then
        echo "❌ File $TARGET_FILE not found in $DEVICE_FOLDER"
        return 1
    fi

    echo "File found: $FOUND_FILE"
}
