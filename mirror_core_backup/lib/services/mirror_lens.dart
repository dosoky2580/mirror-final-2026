import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'translation_service.dart';

class MirrorLens {
  final TextRecognizer _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  final MirrorTranslator _translator = MirrorTranslator();

  // محرك المسح الضوئي والترجمة الفورية
  Future<String> scanAndTranslate(XFile image, String targetLang) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
    
    String originalText = recognizedText.text;
    
    // إرسال النص المستخرج لمجرك الـ 100 لغة اللي عملناه
    if (originalText.isNotEmpty) {
      return await _translator.translateFull(originalText, "en", targetLang); // افتراضياً من الإنجليزية للغة الهدف
    }
    return "لم يتم العثور على نص";
  }

  void dispose() {
    _textRecognizer.close();
  }
}
