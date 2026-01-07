import 'package:connectivity_plus/connectivity_plus.dart';

/// Абстракция для проверки сетевого соединения
abstract class NetworkInfo {
  Future<bool> get isConnected;
}

/// Реализация NetworkInfo с использованием connectivity_plus
class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}
