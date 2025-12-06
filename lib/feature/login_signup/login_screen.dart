import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:magic_slide/core/helper/route_handler.dart';
import 'package:magic_slide/core/helper/route_name.dart';
import 'data/auth_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    super.dispose();
  }

  Future<void> _handleLogin() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Sign in with Supabase
      await _authController.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      // Navigate to home on success
      if (mounted) {
        RouteHandler.navigateTo(RouteName.home);
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
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) =>
                  8 <= (value?.length ?? 0) ? null : 'Password must be at least 8 characters long.',
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: FTappable(
                builder: (context, data, child) => Container(child: child!),
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                onPress: () {
                  RouteHandler.navigateTo(RouteName.forgotPassword);
                },
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : FButton(onPress: _handleLogin, child: const Text('Login')),
            const SizedBox(height: 15),

            FTappable(
              builder: (context, data, child) => Container(child: child!),
              child: const Text('New User? Sign Up'),
              onPress: () {
                RouteHandler.navigateTo(RouteName.signup);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
