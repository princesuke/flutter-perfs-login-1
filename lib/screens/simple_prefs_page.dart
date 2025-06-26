import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimplePrefsPage extends StatefulWidget {
  const SimplePrefsPage({super.key});

  @override
  State<SimplePrefsPage> createState() => _SimplePrefsPageState();
}

class _SimplePrefsPageState extends State<SimplePrefsPage> {
  String? username;
  int? counter;
  bool? isDark;

  Future<void> loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
      counter = prefs.getInt('counter');
      isDark = prefs.getBool('is_dark');
    });
  }

  Future<void> savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', 'John');
    await prefs.setInt('counter', 9);
    await prefs.setBool('is_dark', true);
    loadPrefs();
  }

  Future<void> removePres() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('counter');
    await prefs.remove('is_dark');
    loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SharedPrefs Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'username: ${username ?? '-'}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Counter: ${counter?.toString() ?? '-'}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Dark: ${isDark == null
                  ? '-'
                  : isDark!
                  ? "Yes"
                  : "No"}',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: savePrefs,
              child: const Text('Save Data'),
            ),
            ElevatedButton(
              onPressed: removePres,
              child: const Text('Remove Data'),
            ),
            ElevatedButton(onPressed: loadPrefs, child: const Text('Reload')),
          ],
        ),
      ),
    );
  }
}
