import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';

class SaveCurrentWaterUseCase {
  const SaveCurrentWaterUseCase(this._repository);

  final SharedPrefsLocalRepository _repository;

  Future<void> execute(double value) async {
    await _repository.save<double>('water', value);
  }
}
