#!/bin/bash
# Quick script to add test images to the project

PROJECT_DIR="/Users/flutter/Downloads/Navghan/Projects/studio/studio_slides"
IMAGES_DIR="$PROJECT_DIR/assets/images"

echo "🖼️  Studio Slides - Adding Test Images"
echo "========================================"
echo ""

# Ensure images directory exists
mkdir -p "$IMAGES_DIR"

# Method 1: Look for sample images on the system
echo "Looking for sample images on your Mac..."
echo ""

# Check for macOS wallpapers
WALLPAPERS=$(find "/System/Library/Desktop Pictures" -type f \( -iname "*.jpg" -o -iname "*.png" \) 2>/dev/null | head -3)

if [ ! -z "$WALLPAPERS" ]; then
    echo "✅ Found macOS wallpapers. Copying..."
    COUNT=1
    while IFS= read -r image; do
        EXT="${image##*.}"
        cp "$image" "$IMAGES_DIR/00${COUNT}_wallpaper.$EXT" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "   Copied: $(basename "$image")"
            ((COUNT++))
        fi
    done <<< "$WALLPAPERS"
    echo ""
fi

# Check Pictures folder
PICTURES=$(find ~/Pictures -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) 2>/dev/null | head -3)

if [ ! -z "$PICTURES" ]; then
    echo "✅ Found images in Pictures folder. Copying..."
    COUNT=4
    while IFS= read -r image; do
        EXT="${image##*.}"
        cp "$image" "$IMAGES_DIR/00${COUNT}_photo.$EXT" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "   Copied: $(basename "$image")"
            ((COUNT++))
        fi
    done <<< "$PICTURES"
    echo ""
fi

# Check what we have
IMAGE_COUNT=$(find "$IMAGES_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null | wc -l | xargs)

echo "========================================"
echo "📊 Summary:"
echo "   Images in assets/images/: $IMAGE_COUNT"
echo ""

if [ "$IMAGE_COUNT" -eq 0 ]; then
    echo "❌ No images found automatically."
    echo ""
    echo "📝 Manual steps:"
    echo "   1. Copy some JPG/PNG images to:"
    echo "      $IMAGES_DIR"
    echo ""
    echo "   2. Or download from the web:"
    echo "      cd $IMAGES_DIR"
    echo "      # Then download images manually"
    echo ""
else
    echo "✅ Ready to test!"
    echo ""
    echo "🚀 Next steps:"
    echo "   cd $PROJECT_DIR"
    echo "   flutter run --no-enable-impeller"
    echo ""
fi

echo "💡 Tip: Name images with numbers (001_name.jpg) to control order"
echo ""

