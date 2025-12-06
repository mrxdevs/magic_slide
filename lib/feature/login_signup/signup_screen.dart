import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

import 'package:magic_slide/core/helper/route_handler.dart';
import 'package:magic_slide/core/helper/route_name.dart';
import 'data/auth_controller.dart';

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
  final AuthController _authController = AuthController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Sign up with Supabase
      await _authController.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully! Please sign in.'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login screen
        RouteHandler.navigateTo(RouteName.login);
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
              label: const Text("Confirm Password"),
              hint: 'Confirm Password',
              controller: _confirmPasswordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  _passwordController.text == value ? null : 'Passwords do not match.',
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : FButton(onPress: _handleSignUp, child: const Text('Sign Up')),
            const SizedBox(height: 15),

            FTappable(
              builder: (context, data, child) => Container(child: child!),
              child: const Text('Already have an account? Login'),
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
