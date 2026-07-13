import 'package:shared_preferences/shared_preferences.dart';

// This is a simple manual mock for SharedPreferences to use in tests.
class MockSharedPreferences implements SharedPreferences {
  final Map<String, Object> _values = {};

  @override
  Future<bool> setString(String key, String value) {
    _values[key] = value;
    return Future.value(true);
  }

  @override
  String? getString(String key) {
    return _values[key] as String?;
  }

  // --- We don't need to implement the other methods for this test ---
  @override
  Future<bool> clear() => throw UnimplementedError();
  @override
  Future<bool> commit() => throw UnimplementedError();
  @override
  bool containsKey(String key) => throw UnimplementedError();
  @override
  Object? get(String key) => throw UnimplementedError();
  @override
  bool? getBool(String key) => throw UnimplementedError();
  @override
  double? getDouble(String key) => throw UnimplementedError();
  @override
  int? getInt(String key) => throw UnimplementedError();
  @override
  Set<String> getKeys() => throw UnimplementedError();
  @override
  List<String>? getStringList(String key) => throw UnimplementedError();
  @override
  Future<void> reload() => throw UnimplementedError();
  @override
  Future<bool> remove(String key) => throw UnimplementedError();
  @override
  Future<bool> setBool(String key, bool value) => throw UnimplementedError();
  @override
  Future<bool> setDouble(String key, double value) => throw UnimplementedError();
  @override
  Future<bool> setInt(String key, int value) => throw UnimplementedError();
  @override
  Future<bool> setStringList(String key, List<String> value) => throw UnimplementedError();
}