import 'package:flutter/foundation.dart';

import '../models/slide.dart';

/// Service class for loading and managing slides
class SlideService {
  /// Network image URLs from Pexels
  static const List<String> _networkImageUrls = [
    'https://images.pexels.com/photos/7218982/pexels-photo-7218982.jpeg',
    'https://images.pexels.com/photos/707046/pexels-photo-707046.jpeg',
    'https://images.pexels.com/photos/1519192/pexels-photo-1519192.jpeg',
    'https://images.pexels.com/photos/2056075/pexels-photo-2056075.jpeg',
    'https://images.pexels.com/photos/936250/pexels-photo-936250.jpeg',
    'https://images.pexels.com/photos/2882234/pexels-photo-2882234.jpeg',
  ];

  /// Loads all available slides from network URLs
  Future<List<Slide>> loadSlides() async {
    try {
      final slides = <Slide>[];

      for (int i = 0; i < _networkImageUrls.length; i++) {
        final url = _networkImageUrls[i];
        final name = _extractImageName(url);

        slides.add(Slide(imageUrl: url, name: name, index: i, isNetwork: true));
      }

      debugPrint('Loaded ${slides.length} network images');
      return slides;
    } catch (e) {
      debugPrint('Error loading slides: $e');
      return [];
    }
  }

  /// Extracts a display name from the image URL
  String _extractImageName(String url) {
    try {
      final uri = Uri.parse(url);
      final pathSegments = uri.pathSegments;
      if (pathSegments.isNotEmpty) {
        return pathSegments.last.replaceAll('.jpeg', '').replaceAll('.jpg', '');
      }
      return 'Image';
    } catch (e) {
      return 'Image';
    }
  }
}
