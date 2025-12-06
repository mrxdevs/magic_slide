import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:magic_slide/core/helper/route_handler.dart';
import 'package:magic_slide/core/helper/route_name.dart';
import 'data/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final AuthController _authController = AuthController();

  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Send password reset email
      await _authController.resetPassword(email: _emailController.text.trim());

      // Show success state
      if (mounted) {
        setState(() {
          _emailSent = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Forgot Password'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => RouteHandler.navigateTo(RouteName.login),
      ),
    ),
    body: Container(
      padding: const EdgeInsets.all(32),
      child: _emailSent ? _buildSuccessView() : _buildFormView(),
    ),
  );

  Widget _buildFormView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Reset Password',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          FTextFormField.email(
            controller: _emailController,
            hint: 'janedoe@foruslabs.com',
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) =>
                (value?.contains('@') ?? false) ? null : 'Please enter a valid email.',
          ),
          const SizedBox(height: 24),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : FButton(onPress: _handleResetPassword, child: const Text('Send Reset Link')),
          const SizedBox(height: 16),
          FTappable(
            builder: (context, data, child) => Container(child: child!),
            child: const Text('Back to Login', textAlign: TextAlign.center),
            onPress: () {
              RouteHandler.navigateTo(RouteName.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.mark_email_read, size: 80, color: Colors.green),
        const SizedBox(height: 24),
        const Text(
          'Check Your Email',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'We\'ve sent a password reset link to\n${_emailController.text}',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        FButton(
          onPress: () {
            RouteHandler.navigateTo(RouteName.login);
          },
          child: const Text('Back to Login'),
        ),
      ],
    );
  }
}
