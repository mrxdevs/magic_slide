import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:magic_slide/core/config/supabase_config.dart';
import 'package:magic_slide/core/helper/route_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final theme = FThemes.zinc.light;
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: RouteHelper.router,
      theme: theme.toApproximateMaterialTheme(),
    );
  }
}
