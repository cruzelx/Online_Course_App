import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';

class ConnectivityService {
  StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>();

  ConnectivityService() {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none &&
          await DataConnectionChecker().hasConnection)
        networkStatusController.add(NetworkStatus.Online);
      else
        networkStatusController.add(NetworkStatus.Offline);
    });
  }

  // StreamController<ConnectivityStatus> connectionStatusController =
  //     StreamController<ConnectivityStatus>();

//   ConnectivityService() {
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {

//       connectionStatusController.add(_getStatusFromResult(result));
//     });
//   }
// }

// ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
//   switch (result) {
//     case ConnectivityResult.mobile:
//       return ConnectivityStatus.Mobile;
//       break;
//     case ConnectivityResult.wifi:
//       return ConnectivityStatus.Wifi;
//       break;
//     case ConnectivityResult.none:
//       return ConnectivityStatus.Offline;
//       break;
//     default:
//       return ConnectivityStatus.Offline;
//   }
}
