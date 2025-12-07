class GenerateResponseModel {
  final bool success;
  final ResponseData? data;
  final String message;

  GenerateResponseModel({required this.success, this.data, required this.message});

  factory GenerateResponseModel.fromJson(Map<String, dynamic> json) {
    return GenerateResponseModel(
      success: json['success'] as bool,
      data: json['data'] != null
          ? ResponseData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
      message: json['message'] as String,
    );
  }
}

class ResponseData {
  final String url;

  ResponseData({required this.url});

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(url: json['url'] as String);
  }
}
