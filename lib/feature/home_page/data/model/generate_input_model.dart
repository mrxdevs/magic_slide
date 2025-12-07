import 'watermark_model.dart';

class GenerateInputModel {
  final String topic;
  final String extraInfoSource;
  final String email;
  final String accessId;
  final String template;
  final String language;
  final int slideCount;
  final bool aiImages;
  final bool imageForEachSlide;
  final bool googleImage;
  final bool googleText;
  final String model;
  final String presentationFor;
  final WatermarkModel watermark;

  GenerateInputModel({
    required this.topic,
    required this.extraInfoSource,
    required this.email,
    required this.accessId,
    required this.template,
    required this.language,
    required this.slideCount,
    required this.aiImages,
    required this.imageForEachSlide,
    required this.googleImage,
    required this.googleText,
    required this.model,
    required this.presentationFor,
    required this.watermark,
  });

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'extraInfoSource': extraInfoSource,
      'email': email,
      'accessId': accessId,
      'template': template,
      'language': language,
      'slideCount': slideCount,
      'aiImages': aiImages,
      'imageForEachSlide': imageForEachSlide,
      'googleImage': googleImage,
      'googleText': googleText,
      'model': model,
      'presentationFor': presentationFor,
      'watermark': watermark.toJson(),
    };
  }
}
