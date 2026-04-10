import 'package:flutter/material.dart';
import 'islamic_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mirror Ultimate 2026')),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _card(context, 'المترجم والعدسة', Icons.camera_alt, Colors.blue),
          _card(context, 'المكتبة الإسلامية', Icons.menu_book, Colors.green),
          _card(context, 'أصوات العائلة', Icons.record_voice_over, Colors.purple),
          _card(context, 'مولد الفيديو', Icons.movie_creation, Colors.red),
          _card(context, 'الألعاب (شطرنج/روبيك)', Icons.games, Colors.orange),
          _card(context, 'الإعدادات', Icons.settings, Colors.grey),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      child: InkWell(
        onTap: () {
          if (title == 'المكتبة الإسلامية') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const IslamicScreen()));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Icon(icon, size: 40, color: color), Text(title)],
        ),
      ),
    );
  }
}
