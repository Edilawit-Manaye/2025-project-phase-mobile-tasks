import 'network_info.dart';

// This is a dummy implementation for the task.
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async => true; // Always pretend we are online.
}