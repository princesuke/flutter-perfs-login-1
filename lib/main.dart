import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perf_app/providers/secure_storage_provider.dart';
import 'package:perf_app/providers/shared_prefs_provider.dart';
import './screens/simple_prefs_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final storage = const FlutterSecureStorage();
  final token = await storage.read(key: 'token');
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(prefs),
        secureStorageProvider.overrideWithValue(storage),
      ],
      child: MainApp(prefs: prefs, hasToken: token != null),
    ),
  );
}

class MainApp extends StatelessWidget {
  final SharedPreferences prefs;
  final bool hasToken;
  const MainApp({super.key, required this.prefs, required this.hasToken});

  @override
  Widget build(BuildContext context) {
    // final hasUsername = prefs.getString('username')?.isNotEmpty ?? false;

    return MaterialApp(
      title: 'SharedPres Demo',
      initialRoute: hasToken ? AppRoutes.home : AppRoutes.login,
      routes: AppRoutes.routes,
      // home: SimplePrefsPage(),
    );
  }
}
