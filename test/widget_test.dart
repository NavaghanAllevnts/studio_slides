// This is a basic Flutter widget test for Studio Slides app.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studio_slides/main.dart';

void main() {
  testWidgets('Studio Slides app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StudioSlidesApp());

    // Verify that the app starts (basic smoke test)
    // Since we don't have images in test, we should see the "No images found" message
    // or a loading indicator
    await tester.pump();

    // The app should build without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('App has correct title', (WidgetTester tester) async {
    await tester.pumpWidget(const StudioSlidesApp());

    // Verify the MaterialApp is created with correct title
    final MaterialApp app = tester.widget(find.byType(MaterialApp));
    expect(app.title, 'Studio Slides');
  });
}
