import 'package:magic_slide/core/helper/route_helper.dart';
import 'package:magic_slide/core/helper/route_name.dart';

class RouteHandler {
  //Navigate to
  static void navigateTo(String routeName, {Object? extra}) {
    checkNavigateState();
    RouteHelper.router.go(routeName, extra: extra);
  }

  //Navigate to next and pop
  static void navigateToNext(String routeName, {Object? extra}) {
    checkNavigateState();
    RouteHelper.router.push(routeName, extra: extra);
  }

  //Navigate to and remove
  static void navigateToAndRemove(String routeName, {Object? extra}) {
    checkNavigateState();
    RouteHelper.router.go(routeName, extra: extra);
  }

  //Pop
  static void pop() {
    checkNavigateState();
    if (RouteHelper.router.canPop()) {
      RouteHelper.router.pop();
    } else {
      RouteHelper.router.go(RouteName.home);
    }
  }

  //Validate navigator key
  static void checkNavigateState() {
    if (RouteHelper.navigatorKey.currentState == null) {
      throw Exception("Navigator key is null");
    }
  }
}
