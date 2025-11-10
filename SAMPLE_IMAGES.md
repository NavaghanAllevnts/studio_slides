# Sample Images for Testing

Need some images to test your slideshow? Here are some suggestions!

## Quick Test Images

### Method 1: Use Your Own Photos
Simply copy your personal photos to `assets/images/`:

```bash
# From your project root
cp ~/Pictures/vacation/*.jpg assets/images/
```

### Method 2: Free Stock Photo Sites

Download free high-quality images from:

1. **Unsplash** (https://unsplash.com/)
   - Free high-resolution photos
   - No attribution required
   - Great for testing

2. **Pexels** (https://www.pexels.com/)
   - Free stock photos and videos
   - High quality
   - Easy download

3. **Pixabay** (https://pixabay.com/)
   - Free images and videos
   - No attribution required
   - Large variety

### Method 3: Create Test Images with macOS

If you're on macOS, you can quickly grab some sample photos:

```bash
# Copy some default macOS wallpapers (if available)
cp /Library/Desktop\ Pictures/*.jpg assets/images/

# Or use screenshots
# Press Cmd+Shift+3 to take screenshots
# Then copy them to assets/images/
```

## Recommended Image Properties

For best results on Android TV:

| Property | Recommended | Notes |
|----------|-------------|-------|
| **Resolution** | 1920x1080 or higher | Full HD or better |
| **Format** | JPG, PNG, WebP | JPG recommended for photos |
| **File Size** | < 5MB per image | Larger files slow loading |
| **Aspect Ratio** | Any | App handles both portrait & landscape |
| **File Naming** | 001_name.jpg, 002_name.jpg | Numbers ensure order |

## Quick Download Script

Here's a simple way to download test images using curl:

```bash
# Navigate to images folder
cd assets/images/

# Download sample images (requires internet)
# Note: Replace these URLs with actual image URLs from free stock photo sites

# Example structure (you'll need to get actual URLs):
# curl -o 001_landscape.jpg "https://example.com/photo1.jpg"
# curl -o 002_portrait.jpg "https://example.com/photo2.jpg"
# curl -o 003_nature.jpg "https://example.com/photo3.jpg"
```

## Test Image Checklist

Create a diverse test set:

- [ ] At least one landscape (horizontal) image
- [ ] At least one portrait (vertical) image
- [ ] At least one square image
- [ ] Mix of light and dark images
- [ ] Different subjects (people, nature, architecture, etc.)

This helps ensure your slideshow handles all image types correctly.

## Example File Structure

After adding images, your folder should look like:

```
assets/images/
├── 001_sunset.jpg
├── 002_mountain.jpg
├── 003_portrait.jpg
├── 004_city.jpg
├── 005_nature.jpg
└── README.md
```

## After Adding Images

1. **Verify files are in place:**
   ```bash
   ls assets/images/
   ```

2. **Rebuild the app:**
   ```bash
   flutter run
   ```

3. **Enjoy your slideshow!** 🎉

## Notes

- App will automatically detect all supported images in the folder
- Images display in alphabetical order by filename
- Use numbered prefixes (001_, 002_, etc.) to control order
- README.md in the folder is ignored (not an image)
- Supported formats: .jpg, .jpeg, .png, .webp

## Troubleshooting

### Images not showing?
1. Check file extensions are lowercase (.jpg not .JPG)
2. Make sure files are directly in `assets/images/` (not in subfolders)
3. Rebuild the app after adding images
4. Check `pubspec.yaml` has `assets/images/` listed

### App showing "No images found"?
- Add at least one image file
- Rebuild with `flutter run`
- Check file format is supported

---

**Pro Tip:** Start with 5-10 images for testing. You can always add more later!

