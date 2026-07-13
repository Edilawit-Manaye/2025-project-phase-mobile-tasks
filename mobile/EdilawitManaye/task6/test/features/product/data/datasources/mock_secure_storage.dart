import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// This is the corrected manual mock for FlutterSecureStorage.
class MockFlutterSecureStorage implements FlutterSecureStorage {
  String? tokenToReturn;

  // THIS IS THE CORRECTED METHOD SIGNATURE
  // It now perfectly matches the real class's 'read' method.
  @override
  Future<String?> read({
    required String key,
    IOSOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    MacOsOptions? mOptions,
    WindowsOptions? wOptions,
  }) {
    return Future.value(tokenToReturn);
  }

  // We don't need to implement the other methods for this test
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}