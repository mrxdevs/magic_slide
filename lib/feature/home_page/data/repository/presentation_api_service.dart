import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:magic_slide/feature/home_page/domain/repository/presentation_api.dart';
import '../model/generate_input_model.dart';
import '../model/generate_response_model.dart';

class PresentationApiService implements PresentationApi {
  static const String baseUrl = 'https://api.magicslides.app';
  static const String generateEndpoint = '/public/api/ppt_from_topic';

  @override
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
        debugPrint(jsonResponse.toString());
        return GenerateResponseModel.fromJson(jsonResponse);
      } else {
        // Handle error responses
        final Map<String, dynamic>? errorResponse =
            jsonDecode(response.body) as Map<String, dynamic>?;
        debugPrint(errorResponse.toString());

        return GenerateResponseModel(
          success: false,
          message:
              errorResponse?['message'] ??
              'Failed to generate presentation. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle exceptions
      debugPrint(e.toString());
      return GenerateResponseModel(success: false, message: 'Error: ${e.toString()}');
    }
  }
}
