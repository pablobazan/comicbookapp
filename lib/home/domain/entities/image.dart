class Image {
  final String? originalUrl;
  final String? iconUrl;

  Image({this.originalUrl, this.iconUrl});

  factory Image.fromJson(Map<String, dynamic> json) {
    return Image(
      originalUrl: json['original_url'],
      iconUrl: json['icon_url'],
    );
  }
}
