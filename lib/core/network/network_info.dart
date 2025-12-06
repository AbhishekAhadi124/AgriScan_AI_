// ignore: depend_on_referenced_packages
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfoI {
  Future<bool> isConnected();

  Future<ConnectivityResult> get connectivityResult;

  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfo implements NetworkInfoI {
  Connectivity connectivity;

  NetworkInfo(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    if (!result.contains(ConnectivityResult.none)) {
      try {
        final lookup = await InternetAddress.lookup('google.com');
        if (lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    }
    return false;
  }

  @override
  Future<ConnectivityResult> get connectivityResult =>
      throw UnimplementedError();

  @override
  Stream<ConnectivityResult> get onConnectivityChanged =>
      throw UnimplementedError();
}
