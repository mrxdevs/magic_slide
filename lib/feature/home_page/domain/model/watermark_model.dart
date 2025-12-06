class WatermarkModel {
  final String width;
  final String height;
  final String brandURL;
  final String position;

  WatermarkModel({
    required this.width,
    required this.height,
    required this.brandURL,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {'width': width, 'height': height, 'brandURL': brandURL, 'position': position};
  }

  factory WatermarkModel.fromJson(Map<String, dynamic> json) {
    return WatermarkModel(
      width: json['width'] as String,
      height: json['height'] as String,
      brandURL: json['brandURL'] as String,
      position: json['position'] as String,
    );
  }
}
