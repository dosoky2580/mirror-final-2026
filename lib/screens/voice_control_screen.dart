import 'package:flutter/material.dart';

class VoiceControlScreen extends StatelessWidget {
  final List<String> family = ['Tamer', 'Seif', 'Salma', 'Sama', 'Sara'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('إدارة أصوات المرآة')),
      body: ListView.builder(
        itemCount: family.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.mic),
            title: Text(family[index]),
            trailing: ElevatedButton(
              onPressed: () { /* كود تفعيل البصمة الصوتية */ },
              child: Text('استخدام هذه البصمة'),
            ),
          );
        },
      ),
    );
  }
}
