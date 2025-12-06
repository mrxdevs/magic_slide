import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:magic_slide/core/helper/route_name.dart';
import 'package:magic_slide/feature/home_page/home_screen.dart';
import 'package:magic_slide/feature/login_signup/login_screen.dart';
import 'package:magic_slide/feature/login_signup/signup_screen.dart';
import 'package:magic_slide/feature/login_signup/forgot_password_screen.dart';
import 'package:magic_slide/feature/pdf_viewer/presentation/pdf_viewer_screen.dart';
import 'package:magic_slide/presentation/splash_screen.dart';

class RouteHelper {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final router = GoRouter(
    initialLocation: RouteName.splash,
    navigatorKey: navigatorKey,

    routes: [
      GoRoute(path: RouteName.splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: RouteName.home, builder: (context, state) => HomeScreen()),
      GoRoute(path: RouteName.login, builder: (context, state) => LoginScreen()),
      GoRoute(path: RouteName.signup, builder: (context, state) => SignUpScreen()),
      GoRoute(
        path: RouteName.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(path: RouteName.pdfViewer, builder: (context, state) => PdfViewerScreen()),
    ],
  );
}
