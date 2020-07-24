import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:online_course_app/constants/enums/connectivityStatus.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectionStatusController =
      StreamController<ConnectivityStatus>();

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connectionStatusController.add(_getStatusFromResult(result));
    });
  }
}

ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
  switch (result) {
    case ConnectivityResult.mobile:
      return ConnectivityStatus.Mobile;
      break;
    case ConnectivityResult.wifi:
      return ConnectivityStatus.Wifi;
      break;
    case ConnectivityResult.none:
      return ConnectivityStatus.Offline;
      break;
    default:
      return ConnectivityStatus.Offline;
  }
}
