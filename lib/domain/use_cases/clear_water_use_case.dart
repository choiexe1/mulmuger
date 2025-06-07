import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';

class ClearWaterUseCase {
  const ClearWaterUseCase(this._repository);

  final SharedPrefsLocalRepository _repository;

  Future<void> execute() async {
    await _repository.remove('water');
  }
}
