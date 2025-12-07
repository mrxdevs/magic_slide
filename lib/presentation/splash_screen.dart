import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magic_slide/core/constants/dir.dart';
import 'package:magic_slide/core/constants/user_info.dart';
import 'package:magic_slide/core/helper/pref_services.dart';
import 'package:magic_slide/core/helper/route_handler.dart';
import 'package:magic_slide/core/helper/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer = Timer(const Duration(seconds: 2), () async {
        final isLoggedIn = await PrefServices.instance.isLoggedIn();
        UserInfo.email = await PrefServices.instance.getUserEmail() ?? '';
        UserInfo.uid = await PrefServices.instance.getUserUid() ?? '';

        if (isLoggedIn) {
          RouteHandler.navigateTo(RouteName.home);
        } else {
          RouteHandler.navigateTo(RouteName.login);
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: Dir.logo,
              placeholder: (context, url) => SizedBox(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text("Magic Slide", style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
