import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shared_prefs_provider.dart';
import '../routes/app_routes.dart';
import '../providers/secure_storage_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prefs = ref.watch(sharedPrefsProvider);
    final username = prefs.getString('username') ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: Column(
          children: [
            Text('Welcome, $username', style: TextStyle(fontSize: 22)),
            SizedBox(height: 22),
            ElevatedButton(
              onPressed: () async {
                final storage = ref.watch(secureStorageProvider);
                await prefs.remove('username');
                await storage.delete(key: 'token');

                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
