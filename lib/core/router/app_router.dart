import 'package:auto_route/auto_route.dart';
import 'package:mulmuger/config/app_config.dart';
import 'package:mulmuger/core/router/app_router.gr.dart';
import 'package:mulmuger/core/router/routes.dart';
import 'package:mulmuger/core/service_locator.dart';
import 'package:mulmuger/presentation/screens/home/home_view_model.dart';

@AutoRouterConfig(replaceInRouteName: 'ScreenRoot,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, path: AppRoutes.home, initial: true),
  ];

  DeepLink deepLinkHandler(PlatformDeepLink deepLink) {
    if (deepLink.path.startsWith(AppRoutes.home)) {
      final viewModel = sl<HomeViewModel>();
      final config = sl<AppConfig>();

      return DeepLink([
        HomeRoute(viewModel: viewModel, adsId: config.bannerAdsId),
      ]);
    }

    return DeepLink.defaultPath;
  }
}
