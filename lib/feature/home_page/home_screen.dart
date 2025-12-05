import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

enum Mode { Default, Editable }

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  final bool autoHide = true;
  bool aiImage = false;
  bool imageOnEachPage = false;
  bool googleImage = false;
  bool googleText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FTextField(
              controller: _controller,
              label: const Text('Topic'),
              hint: 'Enter your topic',
              description: const Text('Please enter your topic.'),
              minLines: 5,
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 48,
              child: Row(
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
                      const {'en': 'English', 'ar': 'Arabic'},
                      initialValue: 'en',
                      autoHide: autoHide,
                      validator: (value) => value == null ? 'Select an item' : null,

                      title: const Text('Language'),
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
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  Expanded(
                    child: FSelectMenuTile.fromMap(
                      const {'gpt-4': 'gpt-4', 'gpt-4o': 'gpt-4o', 'gpt-4o-mini': 'gpt-4o-mini'},
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
                      const {'student': 'student', 'teacher': 'teacher', 'business': 'business'},
                      initialValue: 'student',
                      autoHide: autoHide,
                      validator: (value) => value == null ? 'Select an item' : null,

                      title: const Text('User Type'),
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
            const SizedBox(height: 20),

            SizedBox(
              height: 64,
              child: Row(
                children: [
                  Expanded(
                    child: FTextField(
                      controller: _controller,
                      label: const Text('Page'),
                      hint: '10',

                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: FTextField(
                      controller: _controller,
                      label: const Text('Width'),
                      hint: '10',
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: FTextField(
                      controller: _controller,
                      label: const Text('Height'),
                      hint: '10',
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 64,
              child: FTextField(
                controller: _controller,
                label: const Text('Brand Url'),
                hint: 'https://example.com',
                maxLines: 1,
              ),
            ),

            SizedBox(
              height: 64,
              child: FTextField(
                controller: _controller,
                label: const Text('Position'),
                hint: 'Position',
                maxLines: 1,
              ),
            ),
            FButton(child: const Text('Generate'), onPress: () {}),
          ],
        ),
      ),
    );
  }
}
