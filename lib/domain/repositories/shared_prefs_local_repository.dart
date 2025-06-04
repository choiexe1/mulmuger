abstract interface class SharedPrefsLocalRepository {
  Future<void> save<T>(String key, T data);
  T? get<T>(String key);
}
