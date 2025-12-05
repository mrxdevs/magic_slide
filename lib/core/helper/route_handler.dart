import 'package:magic_slide/core/helper/route_helper.dart';

class RouteHandler {
  //Navigate to
  static void navigateTo(String routeName) {
    checkNavigateState();
    RouteHelper.router.go(routeName);
  }

  //Navigate to and remove
  static void navigateToAndRemove(String routeName) {
    checkNavigateState();
    RouteHelper.router.go(routeName);
  }

  //Pop
  static void pop() {
    checkNavigateState();
    RouteHelper.router.pop();
  }

  //Validate navigator key
  static void checkNavigateState() {
    if (RouteHelper.navigatorKey.currentState == null) {
      throw Exception("Navigator key is null");
    }
  }
}
