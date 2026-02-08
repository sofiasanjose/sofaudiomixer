#!/bin/bash
set -e

# sofaudiomixer DMG Build Script
# Creates a professional installer DMG with drag-and-drop to Applications

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

echo "==> Building release app..."
/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild -project "$PROJECT_DIR/sofaudiomixer.xcodeproj" \
    -scheme sofaudiomixer \
    -configuration Release \
    clean build 2>&1 | tail -5

# Find the built app
APP_PATH=$(find ~/Library/Developer/Xcode/DerivedData/sofaudiomixer-*/Build/Products/Release -name "sofaudiomixer.app" -type d | head -1)

if [ -z "$APP_PATH" ]; then
    echo "❌ Error: sofaudiomixer.app not found in build directory"
    exit 1
fi

echo "✅ Found app at: $APP_PATH"

# Create temporary DMG folder
TEMP_DMG="/tmp/sofaudiomixer-dmg"
rm -rf "$TEMP_DMG"
mkdir -p "$TEMP_DMG"

# Copy app to temp folder
cp -R "$APP_PATH" "$TEMP_DMG/"

# Create Applications symlink (for drag-and-drop installation)
ln -s /Applications "$TEMP_DMG/Applications"

# Create DMG
OUTPUT_DMG="$HOME/Desktop/sofaudiomixer-v1.2.0.dmg"
rm -f "$OUTPUT_DMG"

echo "==> Creating DMG installer..."
hdiutil create -volname "sofaudiomixer" \
    -srcfolder "$TEMP_DMG" \
    -ov -format UDZO \
    "$OUTPUT_DMG"

# Clean up
rm -rf "$TEMP_DMG"

echo "✅ DMG created successfully!"
echo "📁 Location: $OUTPUT_DMG"
ls -lh "$OUTPUT_DMG"
