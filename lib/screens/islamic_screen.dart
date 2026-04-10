import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IslamicScreen extends StatelessWidget {
  const IslamicScreen({super.key});

  Future<List<dynamic>> loadData(String path) async {
    final String response = await rootBundle.loadString(path);
    return json.decode(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المكتبة الإسلامية الشاملة')),
      body: ListView(
        children: [
          _buildCategory(context, 'أحاديث قدسية', 'assets/data/hadiths_qudsy.json', Icons.history_edu),
          _buildCategory(context, 'قصص الأنبياء', 'assets/data/prophets_stories.json', Icons.menu_book),
          _buildCategory(context, 'قصص النساء', 'assets/data/face_retouching_natural', Icons.face),
          _buildCategory(context, 'قصص الحيوان', 'assets/data/animals_stories.json', Icons.pets),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, String path, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      onTap: () async {
        final data = await loadData(path);
        // عرض المحتوى المترجم اللي بعتهولي
      },
    );
  }
}
