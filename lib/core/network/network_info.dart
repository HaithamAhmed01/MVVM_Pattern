import 'package:connectivity_plus/connectivity_plus.dart';

class NetWorkInfo {
  Connectivity connectivity;
  NetWorkInfo(this.connectivity);

  Future<bool> get isConnected async {
    var result = await connectivity.checkConnectivity();

    if (result != ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }
}
