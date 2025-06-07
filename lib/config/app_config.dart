import 'package:mulmuger/config/flavor.dart';

class AppConfig {
  const AppConfig({required this.flavor, this.title = '물머거'});

  final Flavor flavor;
  final String title;

  String get bannerAdsId {
    switch (flavor) {
      case Flavor.dev:
        return 'ca-app-pub-3940256099942544/6300978111';
      case Flavor.prod:
        return 'ca-app-pub-4195549707366961/3865971628';
    }
  }
}
