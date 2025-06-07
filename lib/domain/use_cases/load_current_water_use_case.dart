import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';

class LoadCurrentWaterUseCase {
  const LoadCurrentWaterUseCase(this._repository);

  final SharedPrefsLocalRepository _repository;

  Future<double> execute() async {
    final water = _repository.get<double>('water');

    return water ?? 0;
  }
}
