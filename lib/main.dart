import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:magic_slide/core/config/supabase_config.dart';
import 'package:magic_slide/core/helper/route_helper.dart';
import 'package:magic_slide/core/helper/theme_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await SupabaseConfig.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: themeManager,
      builder: (context, _) {
        final theme = themeManager.isDarkMode ? FThemes.zinc.dark : FThemes.zinc.light;
        return MaterialApp.router(
          title: 'Magic Slide',
          routerConfig: RouteHelper.router,
          theme: theme.toApproximateMaterialTheme(),
          darkTheme: FThemes.zinc.dark.toApproximateMaterialTheme(),

          themeMode: themeManager.themeMode,
        );
      },
    );
  }
}
