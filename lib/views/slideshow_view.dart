import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/slide.dart';
import '../services/slide_service.dart';

/// Main slideshow view that displays images in fullscreen with transitions
class SlideshowView extends StatefulWidget {
  const SlideshowView({super.key});

  @override
  State<SlideshowView> createState() => _SlideshowViewState();
}

class _SlideshowViewState extends State<SlideshowView>
    with SingleTickerProviderStateMixin {
  final SlideService _slideService = SlideService();
  List<Slide> _slides = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _isPaused = false;
  Timer? _autoPlayTimer;

  // Animation controller for fade transitions
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Duration for auto-advancing slides
  static const Duration _slideDuration = Duration(seconds: 5);

  // Transition animation duration
  static const Duration _transitionDuration = Duration(milliseconds: 500);

  // Number of images to precache ahead
  static const int _precacheCount = 3;

  @override
  void initState() {
    super.initState();
    _initializeFadeAnimation();
    _loadSlides();

    // Set fullscreen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  /// Initialize fade animation controller
  void _initializeFadeAnimation() {
    _fadeController = AnimationController(
      duration: _transitionDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Start with the image visible
    _fadeController.value = 1.0;
  }

  /// Load slides from assets
  Future<void> _loadSlides() async {
    try {
      final slides = await _slideService.loadSlides();

      if (mounted) {
        setState(() {
          _slides = slides;
          _isLoading = false;
        });

        // Start auto-play if we have slides
        if (_slides.isNotEmpty) {
          // Precache the first few images
          _precacheNextImages();
          _startAutoPlay();
        }
      }
    } catch (e) {
      debugPrint('Error loading slides: $e');
      if (mounted) {
        setState(() {
          _slides = [];
          _isLoading = false;
        });
      }
    }
  }

  /// Precache the next few images in the background
  void _precacheNextImages() {
    if (_slides.isEmpty || !mounted) return;

    for (int i = 1; i <= _precacheCount; i++) {
      final nextIndex = (_currentIndex + i) % _slides.length;
      final imageUrl = _slides[nextIndex].imageUrl;

      // Precache the image with better error handling
      try {
        precacheImage(
          CachedNetworkImageProvider(imageUrl),
          context,
          onError: (exception, stackTrace) {
            debugPrint(
              'Error precaching image at index $nextIndex: $exception',
            );
          },
        ).catchError((error) {
          debugPrint('Error precaching image at index $nextIndex: $error');
        });
      } catch (e) {
        debugPrint('Exception while precaching image at index $nextIndex: $e');
      }
    }
  }

  /// Start automatic slideshow
  void _startAutoPlay() {
    _stopAutoPlay();
    if (!_isPaused && _slides.isNotEmpty) {
      _autoPlayTimer = Timer.periodic(_slideDuration, (_) {
        if (!_isPaused) {
          _nextSlide();
        }
      });
    }
  }

  /// Stop automatic slideshow
  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  /// Navigate to next slide
  void _nextSlide() {
    if (_slides.isEmpty) return;

    _fadeController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % _slides.length;
        });
        _fadeController.forward();

        // Precache next images after transitioning
        _precacheNextImages();
      }
    });
  }

  /// Navigate to previous slide
  void _previousSlide() {
    if (_slides.isEmpty) return;

    _fadeController.reverse().then((_) {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex - 1 + _slides.length) % _slides.length;
        });
        _fadeController.forward();

        // Precache next images after transitioning
        _precacheNextImages();
      }
    });
  }

  /// Toggle pause/resume
  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });

    if (_isPaused) {
      _stopAutoPlay();
    } else {
      _startAutoPlay();
    }
  }

  /// Handle keyboard input (remote control)
  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowRight:
        case LogicalKeyboardKey.mediaTrackNext:
          _nextSlide();
          break;
        case LogicalKeyboardKey.arrowLeft:
        case LogicalKeyboardKey.mediaTrackPrevious:
          _previousSlide();
          break;
        case LogicalKeyboardKey.enter:
        case LogicalKeyboardKey.select:
        case LogicalKeyboardKey.mediaPlayPause:
        case LogicalKeyboardKey.space:
          _togglePause();
          break;
      }
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _fadeController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(backgroundColor: Colors.black, body: _buildBody()),
    );
  }

  /// Build the main body of the slideshow
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    if (_slides.isEmpty) {
      return const Center(
        child: Text(
          'No images loaded.\n\nPlease check your internet connection\nand restart the app.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 24, height: 1.5),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Main slideshow content
        _buildSlideshow(),

        // Pause indicator overlay
        if (_isPaused) _buildPauseOverlay(),
      ],
    );
  }

  /// Build the slideshow with fade animation
  Widget _buildSlideshow() {
    // Safety check
    if (_slides.isEmpty || _currentIndex >= _slides.length) {
      return const Center(
        child: Text(
          'No slides available',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      );
    }

    final currentSlide = _slides[_currentIndex];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Blurred background image
          CachedNetworkImage(
            imageUrl: currentSlide.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            placeholder: (context, url) => Container(color: Colors.black),
            errorWidget: (context, url, error) =>
                Container(color: Colors.black),
            memCacheWidth: 640,
            memCacheHeight: 360,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                child: Container(color: Colors.black.withValues(alpha: 0.3)),
              ),
            ),
          ),

          // Main centered image
          Center(
            child: CachedNetworkImage(
              imageUrl: currentSlide.imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => _buildPlaceholder(url),
              errorWidget: (context, url, error) {
                debugPrint('Error loading image ${currentSlide.name}: $error');
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.broken_image,
                        color: Colors.white54,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading image:\n${currentSlide.name}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                );
              },
              // Cache configuration optimized for TV (lower resolution to avoid memory issues)
              memCacheWidth: 1280,
              memCacheHeight: 720,
              maxWidthDiskCache: 1920,
              maxHeightDiskCache: 1080,
              // Add timeout for better error handling
              fadeInDuration: const Duration(milliseconds: 300),
              fadeOutDuration: const Duration(milliseconds: 300),
            ),
          ),
        ],
      ),
    );
  }

  /// Build a simple placeholder while the image is loading
  Widget _buildPlaceholder(String url) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white54, strokeWidth: 3),
      ),
    );
  }

  /// Build the pause overlay indicator
  Widget _buildPauseOverlay() {
    return Positioned(
      top: 40,
      right: 40,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.pause, color: Colors.white, size: 24),
            SizedBox(width: 12),
            Text(
              'Paused',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
