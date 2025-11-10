import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'views/slideshow_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for TV (landscape)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Set fullscreen mode
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(const StudioSlidesApp());
}

/// Main application widget for Studio Slides
class StudioSlidesApp extends StatelessWidget {
  const StudioSlidesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio Slides',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Use Material 3 for modern design
        useMaterial3: true,

        // Dark theme for TV viewing
        brightness: Brightness.dark,

        // Primary color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
        ),

        // Background color
        scaffoldBackgroundColor: Colors.black,

        // Typography
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
          bodySmall: TextStyle(color: Colors.white),
        ),
      ),
      home: const SlideshowView(),
    );
  }
}
