import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/shared_prefs_provider.dart';
import '../routes/app_routes.dart';
import '../providers/secure_storage_provider.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController usernameController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rememberMe = ref.watch(rememberMeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login Page')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 18),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    ref.read(rememberMeProvider.notifier).state =
                        value ?? false;
                  },
                ),
                const Text('Remember Me'),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final prefs = ref.watch(sharedPrefsProvider);
                final storge = ref.watch(secureStorageProvider);

                if (rememberMe) {
                  await prefs.setString('username', usernameController.text);
                  await storge.write(key: 'token', value: 'myToken123');
                } else {
                  await prefs.remove('username');
                }

                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
