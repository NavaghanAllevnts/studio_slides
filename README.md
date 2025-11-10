# Studio Slides - Flutter Android TV Slideshow App

A beautiful, fullscreen slideshow application for Android TV built with Flutter. Display your photos with smooth fade transitions and remote control navigation.

## Features

✨ **Fullscreen Experience**
- Automatically launches in fullscreen slideshow mode
- Clean UI with black background and centered photos
- No UI clutter for immersive viewing

🖼️ **Smart Image Display**
- Supports both portrait and landscape images
- Proper scaling that fits images without stretching
- Smooth fade transitions between slides
- 5-second display duration per image

🎮 **Remote Control Navigation**
- **Left/Right Arrow**: Navigate to previous/next photo
- **OK/Enter/Space**: Pause or resume slideshow
- **Media Controls**: Also supports media track next/previous buttons

⏸️ **Pause Indicator**
- Small overlay in top-right corner showing "Paused" status
- Automatically resumes when you press OK/Enter again

⚡ **Performance Optimized**
- Efficient image caching for smooth transitions
- Precaches all images for instant display
- Optimized for Android TV hardware

🏗️ **Clean Architecture**
- Models: Data structures (`Slide`)
- Services: Business logic (`SlideService`)
- Views: UI components (`SlideshowView`)
- Latest Flutter best practices with null safety

## Project Structure

```
studio_slides/
├── lib/
│   ├── models/
│   │   └── slide.dart              # Slide data model
│   ├── services/
│   │   └── slide_service.dart      # Image loading and management
│   ├── views/
│   │   └── slideshow_view.dart     # Main slideshow UI
│   └── main.dart                   # App entry point
├── assets/
│   └── images/                     # Place your images here
│       └── README.md               # Instructions for adding images
└── android/
    └── app/
        └── src/
            └── main/
                └── AndroidManifest.xml  # TV configuration
```

## Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Android Studio or VS Code with Flutter extensions
- Android TV device or emulator

### Installation

1. **Clone or navigate to the project:**
   ```bash
   cd /Users/flutter/Downloads/Navghan/Projects/studio/studio_slides
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Add your images:**
   - Place your image files in the `assets/images/` folder
   - Supported formats: JPG, JPEG, PNG, WebP
   - Recommended resolution: 1920x1080 or higher for best TV quality

4. **Build and run:**
   ```bash
   # For Android TV device
   flutter run -d <device_id>
   
   # Build APK for Android TV
   flutter build apk --release
   ```

### Adding Images

1. Navigate to `assets/images/` folder
2. Add your image files (JPG, PNG, or WebP)
3. Images will be displayed in alphabetical order by filename
4. Rebuild the app to include new images:
   ```bash
   flutter run
   ```

**Tip:** Name your files with numbers to control the order (e.g., `001_photo.jpg`, `002_photo.jpg`)

## Configuration

### Slideshow Duration

To change how long each slide displays, edit `lib/views/slideshow_view.dart`:

```dart
// Change from 5 seconds to your preferred duration
static const Duration _slideDuration = Duration(seconds: 5);
```

### Transition Speed

To adjust the fade transition speed, edit `lib/views/slideshow_view.dart`:

```dart
// Change from 500ms to your preferred duration
static const Duration _transitionDuration = Duration(milliseconds: 500);
```

### Pause Overlay Position

The pause indicator is positioned in the top-right corner. To change it, edit the `Positioned` widget in `_buildPauseOverlay()` method in `lib/views/slideshow_view.dart`.

## Remote Control Mapping

| Remote Button | Action |
|--------------|--------|
| ← Left Arrow | Previous photo |
| → Right Arrow | Next photo |
| OK / Enter | Pause/Resume |
| Space | Pause/Resume |
| Media Previous | Previous photo |
| Media Next | Next photo |
| Media Play/Pause | Pause/Resume |

## Android TV Configuration

The app is configured for Android TV with:
- Touchscreen marked as not required
- Leanback launcher support
- Landscape orientation preference
- TV banner icon support
- Fullscreen immersive mode

Configuration is in `android/app/src/main/AndroidManifest.xml`.

## Development

### Testing on Android TV Emulator

1. Create an Android TV emulator in Android Studio:
   - Tools → Device Manager → Create Device
   - Select TV category → Choose a TV device
   - Select system image and finish

2. Run the app:
   ```bash
   flutter run
   ```

### Testing with ADB

Connect to Android TV over network:
```bash
adb connect <tv_ip_address>:5555
flutter run
```

## Architecture

### Models (`lib/models/`)
- **Slide**: Represents a single image slide with path, filename, and index

### Services (`lib/services/`)
- **SlideService**: Handles loading images from assets, parsing manifest, and precaching

### Views (`lib/views/`)
- **SlideshowView**: Main UI component with slideshow logic, animations, and remote control handling

### Main (`lib/main.dart`)
- App initialization, theme configuration, and entry point

## Dependencies

- `flutter`: Flutter SDK
- `cached_network_image`: Efficient image caching (^3.3.1)
- `path_provider`: Local storage access (^2.1.1)

## Troubleshooting

### No images showing
- Check that images are placed in `assets/images/` folder
- Rebuild the app after adding images: `flutter run`
- Verify images are in supported format (JPG, PNG, WebP)

### Remote control not working
- Ensure the app has focus on Android TV
- Try pressing the D-pad center button to give focus to the app
- Check if your remote is properly connected to the TV

### App not appearing in TV launcher
- Check that `android/app/src/main/AndroidManifest.xml` includes:
  - `android.intent.category.LEANBACK_LAUNCHER` category
  - `android.software.leanback` feature (not required)

### Images look stretched or distorted
- Images use `BoxFit.contain` to maintain aspect ratio
- Ensure images are high resolution for TV displays
- Check that image files are not corrupted

## Building for Production

Create a release APK:
```bash
flutter build apk --release
```

The APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

Install on Android TV:
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

## License

This project is open source and available under the MIT License.

## Support

For issues or questions:
1. Check the troubleshooting section above
2. Review the Flutter documentation: https://docs.flutter.dev/
3. Check Flutter TV development guide: https://docs.flutter.dev/platform-integration/android/android-tv

---

**Built with Flutter 💙**
