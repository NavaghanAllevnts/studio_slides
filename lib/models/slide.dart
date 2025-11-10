/// Model class representing a slide in the slideshow
class Slide {
  /// The URL or path to the image
  final String imageUrl;

  /// The display name of the image
  final String name;

  /// The index position in the slideshow
  final int index;

  /// Whether this is a network image (true) or asset (false)
  final bool isNetwork;

  const Slide({
    required this.imageUrl,
    required this.name,
    required this.index,
    this.isNetwork = false,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Slide &&
          runtimeType == other.runtimeType &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode => imageUrl.hashCode;

  @override
  String toString() =>
      'Slide(index: $index, name: $name, isNetwork: $isNetwork)';
}
