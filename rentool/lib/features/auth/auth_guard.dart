import 'package:auto_route/auto_route.dart';
import 'package:rentool/features/auth/auth.dart';
import 'package:rentool/router/router.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    if (isAuthorized) {
      resolver.next(true);
    } else {
      resolver.redirect(const GuardRoute());
    }
  }
}
