import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'network_info.dart';

// This is the REAL, concrete implementation of our NetworkInfo contract.
class NetworkInfoImpl implements NetworkInfo {
  // It now depends on the InternetConnectionChecker package.
  final InternetConnectionChecker connectionChecker;

  // The constructor requires an instance of InternetConnectionChecker.
  const NetworkInfoImpl(this.connectionChecker);

  // The 'isConnected' getter now performs a real network check
  // by calling the 'hasConnection' method from the package.
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}