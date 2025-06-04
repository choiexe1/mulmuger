import 'package:mulmuger/domain/repositories/shared_prefs_local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsLocalRepositoryImpl implements SharedPrefsLocalRepository {
  const SharedPrefsLocalRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<void> save<T>(String key, T data) async {
    if (T == String) {
      await _prefs.setString(key, data as String);
    } else if (T == int) {
      await _prefs.setInt(key, data as int);
    } else if (T == bool) {
      await _prefs.setBool(key, data as bool);
    } else if (T == double) {
      await _prefs.setDouble(key, data as double);
    } else if (T == List<String>) {
      await _prefs.setStringList(key, data as List<String>);
    } else {
      throw ArgumentError('지원하지 않는 타입: $T');
    }
  }

  @override
  T? get<T>(String key) {
    if (T == String) {
      return _prefs.getString(key) as T;
    } else if (T == int) {
      return _prefs.getInt(key) as T;
    } else if (T == bool) {
      return _prefs.getBool(key) as T;
    } else if (T == double) {
      return _prefs.getDouble(key) as T;
    } else if (T == List<String>) {
      return _prefs.getStringList(key) as T;
    } else {
      return null;
    }
  }
}
