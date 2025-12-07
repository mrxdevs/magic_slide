import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:magic_slide/core/constants/user_info.dart';
import 'package:magic_slide/core/helper/route_handler.dart';
import 'package:magic_slide/core/helper/route_name.dart';
import 'package:magic_slide/core/helper/theme_manager.dart';
import 'package:magic_slide/feature/login_signup/data/auth_controller.dart';
import 'data/repository/presentation_api_service.dart';
import 'data/model/generate_input_model.dart';
import 'data/model/watermark_model.dart';

enum Mode { Default, Editable }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _pageController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _brandUrlController = TextEditingController();

  final PresentationApiService _apiService = PresentationApiService();
  final AuthController _authController = AuthController();

  final bool autoHide = true;
  bool aiImage = false;
  bool imageOnEachPage = false;
  bool googleImage = false;
  bool googleText = false;
  bool _isLoading = false;

  String selectedMode = 'Default';
  String selectedLanguage = 'en';
  String selectedModel = 'gpt-4';
  String selectedPresentationFor = 'student';
  String selectedPosition = 'BottomRight';

  Future<void> _handleLogout() async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Logout')),
        ],
      ),
    );

    if (shouldLogout == true) {
      try {
        await _authController.signOut();
        if (mounted) {
          RouteHandler.navigateTo(RouteName.login);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error logging out: ${e.toString()}')));
        }
      }
    }
  }

  void _toggleTheme() {
    // Toggle between light and dark theme using ThemeManager
    themeManager.toggleTheme();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(themeManager.isDarkMode ? 'Switched to dark mode' : 'Switched to light mode'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _generatePresentation() async {
    // Validate inputs
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a topic')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create the watermark model
      final watermark = WatermarkModel(
        width: _widthController.text.isNotEmpty ? _widthController.text : '48',
        height: _heightController.text.isNotEmpty ? _heightController.text : '48',
        brandURL: _brandUrlController.text.isNotEmpty
            ? _brandUrlController.text
            : 'https://example.com/logo.png',
        position: selectedPosition,
      );

      // Create the input model
      final inputModel = GenerateInputModel(
        topic: _controller.text,
        extraInfoSource: 'Generated from Magic Slide App',
        email: UserInfo.email,
        accessId: 'SinceIDontHaveOne',
        template: 'bullet-point1', // Default template also can add more templates from Dropdown
        language: selectedLanguage,
        slideCount: int.tryParse(_pageController.text) ?? 10,
        aiImages: aiImage,
        imageForEachSlide: imageOnEachPage,
        googleImage: googleImage,
        googleText: googleText,
        model: selectedModel,
        presentationFor: selectedPresentationFor,
        watermark: watermark,
      );

      // Call the API
      final response = await _apiService.generatePresentation(inputModel);

      setState(() {
        _isLoading = false;
      });

      if (response.success && response.data != null) {
        // Show success dialog with URL
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Success!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(response.message),
                  const SizedBox(height: 16),
                  const Text('Presentation URL:'),
                  const SizedBox(height: 8),
                  SelectableText(
                    response.data!.url,
                    style: const TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          );
        }
      } else {
        // Show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${response.message}'),
              duration: const Duration(milliseconds: 500),
            ),
          );

          debugPrint(response.message.toString().toLowerCase());

          if (response.message.toString().toLowerCase().contains("something is missing.")) {
            //This is a hardcoded response for now since the API is not working as it is not ready with API key
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Using Hardcoded Response')));
            RouteHandler.navigateToNext(
              RouteName.pdfViewer,
              extra: "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
            );
          }
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('An error occurred: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FAnimatedTheme(
      data: themeManager.isDarkMode ? FThemes.zinc.dark : FThemes.zinc.light,

      child: Scaffold(
        appBar: AppBar(
          title: const Text('Magic Slide'),
          actions: [
            // Theme toggle button
            IconButton(
              icon: Icon(
                Theme.of(context).brightness == Brightness.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              tooltip: 'Toggle theme',
              onPressed: _toggleTheme,
            ),
            // Logout button
            IconButton(icon: const Icon(Icons.logout), tooltip: 'Logout', onPressed: _handleLogout),
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FTextField(
                  controller: _controller,
                  label: const Text('Topic'),
                  hint: 'Enter your topic',
                  minLines: 5,
                  maxLines: 10,
                ),

                SizedBox(
                  height: 48,

                  child: Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: FSelectMenuTile.fromMap(
                          const {'Default': Mode.Default, 'Editable': Mode.Editable},
                          initialValue: Mode.Default,
                          autoHide: autoHide,
                          validator: (value) => value == null ? 'Select an item' : null,

                          title: const Text('Mode'),
                          detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
                            Mode.Default => 'Default',
                            Mode.Editable => 'Editable',
                            _ => 'None',
                          }),
                        ),
                      ),

                      Expanded(
                        child: FSelectMenuTile.fromMap(
                          const {'English': 'en', 'Arabic': 'ar'},
                          initialValue: 'en',
                          autoHide: autoHide,
                          validator: (value) => value == null ? 'Select an item' : null,

                          title: const Text("Lan"),
                          detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
                            'en' => 'English',
                            'ar' => 'Arabic',
                            _ => 'None',
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: FSwitch(
                            label: const Text('AI Image'),
                            semanticsLabel: 'AI Image',
                            value: aiImage,
                            onChange: (value) => setState(() => aiImage = value),
                          ),
                        ),
                        Expanded(
                          child: FSwitch(
                            label: const Text('Image on Each Page'),
                            semanticsLabel: 'Image on Each Page',
                            value: imageOnEachPage,
                            onChange: (value) => setState(() => imageOnEachPage = value),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FSwitch(
                            label: const Text('Google Image'),
                            semanticsLabel: 'Google Image',
                            value: googleImage,
                            onChange: (value) => setState(() => googleImage = value),
                          ),
                        ),
                        Expanded(
                          child: FSwitch(
                            label: const Text('Google Text'),
                            semanticsLabel: 'Google Text',
                            value: googleText,
                            onChange: (value) => setState(() => googleText = value),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                SizedBox(
                  height: 48,
                  child: Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: FSelectMenuTile.fromMap(
                          const {
                            'gpt-4': 'gpt-4',
                            'gpt-4o': 'gpt-4o',
                            'gpt-4o-mini': 'gpt-4o-mini',
                          },
                          initialValue: 'gpt-4',
                          autoHide: autoHide,
                          validator: (value) => value == null ? 'Select an item' : null,

                          title: const Text('Model'),
                          detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
                            'gpt-4' => 'gpt-4',
                            'gpt-4o' => 'gpt-4o',
                            'gpt-4o-mini' => 'gpt-4o-mini',

                            _ => 'None',
                          }),
                        ),
                      ),
                      Expanded(
                        child: FSelectMenuTile.fromMap(
                          const {
                            'student': 'student',
                            'teacher': 'teacher',
                            'business': 'business',
                          },
                          initialValue: 'student',
                          autoHide: autoHide,
                          validator: (value) => value == null ? 'Select an item' : null,

                          title: const Text('User'),
                          detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
                            'student' => 'student',
                            'teacher' => 'teacher',
                            'business' => 'business',

                            _ => 'None',
                          }),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 64,
                  child: Row(
                    spacing: 20,
                    children: [
                      Expanded(
                        child: FTextFormField(
                          controller: _pageController,
                          label: const Text('Page'),
                          hint: '10',
                          keyboardType: TextInputType.number,

                          maxLines: 1,
                        ),
                      ),
                      Expanded(
                        child: FTextFormField(
                          controller: _widthController,
                          label: const Text('Width'),
                          hint: '10',
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: FTextFormField(
                          controller: _heightController,
                          label: const Text('Height'),
                          hint: '10',
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 64,
                  child: FTextFormField(
                    controller: _brandUrlController,
                    label: const Text('Brand Url'),
                    hint: 'https://example.com',

                    maxLines: 1,
                    validator: (value) => value != null && value.isNotEmpty
                        ? Uri.parse(value).host.contains('http')
                              ? null
                              : 'Not a valid url'
                        : null,
                  ),
                ),

                SizedBox(
                  height: 48,
                  child: FSelectMenuTile.fromMap(
                    const {
                      'Top Right': 'TopRight',
                      'Top Left': 'TopLeft',
                      'Bottom Right': 'BottomRight',
                      'Bottom Left': 'BottomLeft',
                    },
                    initialValue: 'BottomRight',
                    autoHide: autoHide,
                    validator: (value) => value == null ? 'Select a position' : null,
                    title: const Text('Watermark Position'),
                    detailsBuilder: (_, values, _) => Text(switch (values.firstOrNull) {
                      'TopRight' => 'Top Right',
                      'TopLeft' => 'Top Left',
                      'BottomRight' => 'Bottom Right',
                      'BottomLeft' => 'Bottom Left',
                      _ => 'None',
                    }),
                  ),
                ),
                const SizedBox(height: 12),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : FButton(onPress: _generatePresentation, child: const Text('Generate')),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
