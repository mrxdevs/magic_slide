import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/model/generate_input_model.dart';
import '../domain/model/generate_response_model.dart';

class PresentationApiService {
  // TODO: Replace with your actual API endpoint
  static const String baseUrl = 'https://api.magicslides.app';
  static const String generateEndpoint = '/public/api/ppt_from_topic';

  Future<GenerateResponseModel> generatePresentation(GenerateInputModel input) async {
    try {
      final url = Uri.parse('$baseUrl$generateEndpoint');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(input.toJson()),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        return GenerateResponseModel.fromJson(jsonResponse);
      } else {
        // Handle error responses
        final Map<String, dynamic>? errorResponse =
            jsonDecode(response.body) as Map<String, dynamic>?;

        return GenerateResponseModel(
          success: false,
          message:
              errorResponse?['message'] ??
              'Failed to generate presentation. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle exceptions
      return GenerateResponseModel(success: false, message: 'Error: ${e.toString()}');
    }
  }
}
