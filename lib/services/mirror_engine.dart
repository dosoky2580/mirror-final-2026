import 'package:google_mlkit_translation/google_mlkit_translation.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MirrorEngine {
  // نظام المستندات وإدارة المجلدات
  Future<void> initializeStorage() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/Mirror_Records';
    await Directory(path).create(recursive: true);
  }

  // المترجم العالمي (100 لغة) مع تحميل الموديلات
  Future<String> translateFull(String text, String source, String target) async {
    final modelManager = OnDeviceTranslateModelManager();
    if (!(await modelManager.isModelDownloaded(source))) await modelManager.downloadModel(source);
    if (!(await modelManager.isModelDownloaded(target))) await modelManager.downloadModel(target);
    
    final translator = OnDeviceTranslator(
      models: TranslationModelOptions(
        sourceLanguage: TranslateLanguage.values.firstWhere((l) => l.bcp47Code == source),
        targetLanguage: TranslateLanguage.values.firstWhere((l) => l.bcp47Code == target),
      )
    );
    return await translator.translateText(text);
  }

  // بصمات أصوات العائلة (تامر، سيف، سلمى، سما، سارة)
  final Map<String, String> familyVoiceIDs = {
    'Tamer': 'id_tamer', 'Seif': 'id_seif', 'Salma': 'id_salma', 'Sama': 'id_sama', 'Sara': 'id_sara'
  };
}
