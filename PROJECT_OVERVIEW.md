# Studio Slides - Project Overview

## 📁 Project Structure

This document provides a complete overview of all project files and their purposes.

## Core Application Files

### `/lib/main.dart`
**Purpose:** Application entry point
- Initializes Flutter app with TV-optimized settings
- Sets landscape orientation preference
- Configures fullscreen immersive mode
- Defines app theme (dark theme for TV viewing)
- Launches the SlideshowView

**Key Features:**
- Material 3 design
- Dark theme optimized for TV
- System UI configuration

---

### `/lib/views/slideshow_view.dart`
**Purpose:** Main slideshow UI and logic
- Displays images in fullscreen with fade transitions
- Handles remote control input
- Manages slideshow state (playing/paused)
- Implements auto-advance timer
- Shows pause indicator overlay

**Key Features:**
- Smooth fade animations (500ms)
- 5-second slide duration
- Remote control key handling (arrow keys, OK/Enter)
- Image precaching for performance
- Error handling for missing/broken images
- Clean black background design

**Key Methods:**
- `_loadSlides()`: Loads images from assets
- `_startAutoPlay()` / `_stopAutoPlay()`: Timer management
- `_nextSlide()` / `_previousSlide()`: Navigation with animation
- `_togglePause()`: Pause/resume control
- `_handleKeyEvent()`: Remote control mapping
- `_precacheImages()`: Performance optimization

---

### `/lib/services/slide_service.dart`
**Purpose:** Business logic for slide management
- Loads images from assets folder
- Parses asset manifest
- Filters supported image formats
- Creates Slide model instances

**Key Features:**
- Asset manifest parsing
- Image format validation (.jpg, .jpeg, .png, .webp)
- Alphabetical sorting
- Error handling with debug output

**Key Methods:**
- `loadSlides()`: Main entry point for loading images
- `_parseManifest()`: JSON parsing for AssetManifest
- `_isSupportedImageFile()`: Format validation
- `precacheSlides()`: Optional precaching helper

---

### `/lib/models/slide.dart`
**Purpose:** Data model for slideshow images
- Represents a single slide/image
- Stores image path, filename, and index
- Implements equality operators

**Properties:**
- `imagePath`: Full asset path (e.g., "assets/images/photo.jpg")
- `fileName`: Just the filename (e.g., "photo.jpg")
- `index`: Position in slideshow sequence

---

## Configuration Files

### `/pubspec.yaml`
**Purpose:** Flutter project configuration
- Defines project metadata
- Lists dependencies
- Declares assets folder

**Key Dependencies:**
- `flutter`: Flutter SDK
- `cached_network_image: ^3.3.1`: Image caching
- `path_provider: ^2.1.1`: File system access
- `cupertino_icons: ^1.0.8`: iOS-style icons

**Assets Configuration:**
```yaml
assets:
  - assets/images/
```

---

### `/android/app/src/main/AndroidManifest.xml`
**Purpose:** Android TV configuration
- Declares TV support
- Configures launcher behavior
- Sets screen orientation

**Key Configurations:**
- Touchscreen marked as not required (`android:required="false"`)
- Leanback support for TV
- `LEANBACK_LAUNCHER` category for TV launcher
- Landscape orientation preference
- App name: "Studio Slides"
- Banner icon support

**TV-Specific Features:**
```xml
<uses-feature android:name="android.software.leanback" android:required="false" />
<category android:name="android.intent.category.LEANBACK_LAUNCHER"/>
```

---

## Asset Files

### `/assets/images/`
**Purpose:** Image storage directory
- Place your slideshow images here
- Supports: JPG, JPEG, PNG, WebP
- Images loaded alphabetically by filename

### `/assets/images/README.md`
**Purpose:** Instructions for adding images
- Format guidelines
- Usage instructions
- Best practices for TV display

---

## Test Files

### `/test/widget_test.dart`
**Purpose:** Widget tests for the application
- Smoke test to verify app builds
- Tests app initialization
- Verifies app title

**Test Cases:**
1. `Studio Slides app smoke test`: Ensures app builds without errors
2. `App has correct title`: Verifies MaterialApp title is "Studio Slides"

---

## Documentation Files

### `/README.md`
**Purpose:** Main documentation
- Complete feature list
- Installation instructions
- Configuration guide
- Troubleshooting section
- Architecture overview

### `/QUICK_START.md`
**Purpose:** Fast setup guide
- 3-step quick start
- Common commands
- Quick reference for controls
- Common issues resolution

### `/PROJECT_OVERVIEW.md` (this file)
**Purpose:** Technical overview
- File-by-file breakdown
- Architecture explanation
- Code organization

---

## Architecture Pattern

The app follows **Clean Architecture** principles:

```
┌─────────────────────────────────────┐
│           Presentation              │
│         (views/*)                   │
│  - SlideshowView                    │
│  - UI Logic & State Management      │
└──────────────┬──────────────────────┘
               │
               │ uses
               ↓
┌─────────────────────────────────────┐
│          Business Logic             │
│        (services/*)                 │
│  - SlideService                     │
│  - Loading & Management Logic       │
└──────────────┬──────────────────────┘
               │
               │ uses
               ↓
┌─────────────────────────────────────┐
│            Models                   │
│         (models/*)                  │
│  - Slide (data structure)           │
└─────────────────────────────────────┘
```

### Benefits:
- **Separation of Concerns**: Each layer has a single responsibility
- **Testability**: Easy to unit test each layer independently
- **Maintainability**: Clear structure makes updates easier
- **Scalability**: Easy to add new features

---

## Key Design Decisions

### 1. Asset-Based Images
**Why:** Simplicity and offline-first approach
**Trade-off:** Requires app rebuild when adding images
**Future:** Could add network/local file system support

### 2. Fade Transitions
**Why:** Professional, TV-appropriate effect
**Duration:** 500ms for smooth but quick transitions
**Implementation:** AnimationController with CurvedAnimation

### 3. 5-Second Display Duration
**Why:** Balanced viewing time
**Configurable:** Easy to change in `slideshow_view.dart`

### 4. Manual JSON Parsing
**Why:** Avoid adding json dependency for simple manifest
**Trade-off:** Custom parsing code
**Future:** Could use proper JSON parser if manifest gets complex

### 5. Keyboard Input for Remote Control
**Why:** Standard approach for TV apps in Flutter
**Coverage:** Supports arrow keys, Enter, Space, media controls

### 6. Precaching Strategy
**Why:** Ensure smooth transitions on TV hardware
**Implementation:** precacheImage during initialization
**Trade-off:** Slightly longer startup time

---

## Performance Optimizations

1. **Image Precaching**: All images loaded into memory during startup
2. **Asset Bundle**: Images bundled with app for instant access
3. **Efficient State Management**: Minimal rebuilds with targeted setState
4. **Animation Controller**: Hardware-accelerated transitions
5. **Timer Management**: Proper cleanup to prevent memory leaks

---

## Future Enhancement Ideas

### Easy Additions:
- [ ] Shuffle mode
- [ ] Adjustable slide duration
- [ ] Different transition effects (slide, zoom, etc.)
- [ ] Slide counter display (code exists, just commented out)
- [ ] Background music support

### Medium Complexity:
- [ ] Load images from device storage
- [ ] Network image support with caching
- [ ] Multiple slideshow folders
- [ ] Settings screen (duration, transitions, etc.)
- [ ] Resume from last position

### Advanced Features:
- [ ] Cloud storage integration (Google Photos, Dropbox)
- [ ] Video support
- [ ] Ken Burns effect (pan & zoom)
- [ ] Ambient mode integration
- [ ] Chromecast support

---

## Development Commands

```bash
# Get dependencies
flutter pub get

# Run app
flutter run

# Run on specific device
flutter run -d <device_id>

# Build release APK
flutter build apk --release

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format lib/

# Clean build files
flutter clean
```

---

## Code Style & Best Practices

### Followed:
✅ Null safety enabled
✅ Const constructors where possible
✅ Private members prefixed with `_`
✅ Comprehensive documentation comments
✅ Error handling with try-catch
✅ Resource cleanup in dispose methods
✅ Debug prints instead of print
✅ Latest Flutter 3.x APIs
✅ Material 3 design

### Naming Conventions:
- Classes: PascalCase (`SlideshowView`)
- Files: snake_case (`slideshow_view.dart`)
- Private methods: `_methodName`
- Constants: `_constantName` or `constantName`

---

## Dependencies Explained

### cached_network_image (^3.3.1)
**Purpose:** Efficient image caching
**Usage:** Currently for infrastructure, ready for network images
**Benefits:** Memory management, disk caching, placeholder support

### path_provider (^2.1.1)
**Purpose:** Access to device file system paths
**Usage:** Ready for local file system image loading
**Benefits:** Cross-platform path handling

---

## Testing Strategy

### Current Tests:
- Smoke test: App builds without errors
- Widget test: MaterialApp configuration

### Recommended Additional Tests:
- Unit tests for SlideService
- Widget tests for SlideshowView states
- Integration tests for navigation flow
- Image loading error scenarios

---

## File Count Summary

- **Source Files**: 4 (main.dart + 3 feature files)
- **Test Files**: 1
- **Config Files**: 2 (pubspec.yaml, AndroidManifest.xml)
- **Documentation**: 4 (README, QUICK_START, PROJECT_OVERVIEW, assets README)
- **Total Lines of Code**: ~600 lines (excluding comments/blank lines)

---

## Version History

### v1.0.0 - Initial Release
- ✅ Fullscreen slideshow with fade transitions
- ✅ Asset-based image loading
- ✅ Remote control navigation
- ✅ Pause/resume functionality
- ✅ Android TV support
- ✅ Image precaching
- ✅ Clean architecture
- ✅ Null safety
- ✅ Comprehensive documentation

---

**Built with Flutter 3.9.2+ and Material 3** 💙

