// network_utils.dart

import 'package:connectivity/connectivity.dart';

class NetworkUtils {

  static Future<bool> checkConnectivity() async {
    try{
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult != ConnectivityResult.none;
    }
    catch(e) {
      return false;
    }
  }
}
