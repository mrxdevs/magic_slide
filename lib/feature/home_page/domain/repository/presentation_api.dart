import 'package:magic_slide/feature/home_page/data/model/generate_input_model.dart';
import 'package:magic_slide/feature/home_page/data/model/generate_response_model.dart';

abstract class PresentationApi {
  Future<GenerateResponseModel> generatePresentation(GenerateInputModel input);
}
