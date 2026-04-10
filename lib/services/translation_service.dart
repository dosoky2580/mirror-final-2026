import 'package:google_mlkit_translation/google_mlkit_translation.dart';

class MirrorTranslator {
  // المنهج الجديد: دعم 100 لغة مع إدارة تحميل النماذج
  Future<String> translateFull(String text, String sourceCode, String targetCode) async {
    // تحديد اللغات بناءً على الأكواد المبعوثة (مثل 'en', 'ar', 'tr')
    final sourceLang = TranslateLanguage.values.firstWhere(
      (l) => l.bcp47Code == sourceCode || l.name == sourceCode,
      orElse: () => TranslateLanguage.english,
    );
    final targetLang = TranslateLanguage.values.firstWhere(
      (l) => l.bcp47Code == targetCode || l.name == targetCode,
      orElse: () => TranslateLanguage.arabic,
    );

    final options = TranslationModelOptions(
      sourceLanguage: sourceLang,
      targetLanguage: targetLang,
    );

    final translator = OnDeviceTranslator(models: options);
    final modelManager = OnDeviceTranslateModelManager();

    try {
      // التأكد من وجود الموديلات على الجهاز قبل الترجمة
      bool isSourceDownloaded = await modelManager.isModelDownloaded(sourceLang.bcp47Code);
      bool isTargetDownloaded = await modelManager.isModelDownloaded(targetLang.bcp47Code);

      if (!isSourceDownloaded) await modelManager.downloadModel(sourceLang.bcp47Code);
      if (!isTargetDownloaded) await modelManager.downloadModel(targetLang.bcp47Code);

      final String result = await translator.translateText(text);
      return result;
    } catch (e) {
      return "خطأ في محرك الترجمة: $e";
    } finally {
      translator.close();
    }
  }
}
