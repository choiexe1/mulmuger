import 'package:auto_route/auto_route.dart';
import 'package:mulmuger/core/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRouteRoot.page, path: '/', initial: true),
  ];
}
