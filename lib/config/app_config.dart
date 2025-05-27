enum Flavor { dev, prod }

class AppConfig {
  factory AppConfig({required Flavor flavor, required String appName}) {
    if (_instance != null) {
      throw Exception('AppConfig이 이미 초기화 되어있습니다.');
    } else {
      _instance = AppConfig._(flavor: flavor, appName: appName);
      return _instance!;
    }
  }

  const AppConfig._({required this.flavor, required this.appName});

  final Flavor flavor;
  final String appName;

  static AppConfig? _instance;

  static AppConfig get instance {
    if (_instance == null) {
      throw Exception(
        'AppConfig이 초기화 되지 않았습니다. 먼저 AppConfig.initialize()를 호출하세요.',
      );
    }

    return _instance!;
  }

  bool get isProduction => flavor == Flavor.prod;
  bool get isDevelopment => flavor == Flavor.dev;
}
