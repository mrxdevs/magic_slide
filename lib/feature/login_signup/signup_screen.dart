import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:magic_slide/core/helper/route_handler.dart';
import 'package:magic_slide/core/helper/route_name.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      padding: const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FTextFormField.email(
              controller: _emailController,
              hint: 'janedoe@foruslabs.com',
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
            ),
            const SizedBox(height: 10),
            FTextFormField.password(
              hint: 'New Password',
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
            ),
            const SizedBox(height: 10),
            FTextFormField.password(
              label: Text("Confirm Password"),

              hint: 'Confirm Password',
              controller: _confirmPasswordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  _passwordController.text == value ? null : 'Passwords do not match.',
            ),
            const SizedBox(height: 20),
            FButton(
              child: const Text('Sign Up'),
              onPress: () {
                if (!_formKey.currentState!.validate()) {
                  RouteHandler.navigateTo(RouteName.home);
                }
              },
            ),
            const SizedBox(height: 15),

            FTappable(
              builder: (context, data, child) => Container(child: child!),
              child: const Text('Already  have an account? Login'),
              onPress: () {
                RouteHandler.navigateTo(RouteName.login);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
