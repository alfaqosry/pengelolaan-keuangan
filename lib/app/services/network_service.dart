import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();

  NetworkService() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Stream<bool> get onConnectionStatusChanged =>
      _connectionStatusController.stream;

  Future<void> _updateConnectionStatus(List<ConnectivityResult> _) async {
    final isConnected =
        await InternetConnectionChecker.createInstance().hasConnection;
    _connectionStatusController.add(isConnected);
  }

  void dispose() => _connectionStatusController.close();
}
