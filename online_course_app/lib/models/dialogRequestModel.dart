import 'package:rflutter_alert/rflutter_alert.dart';

class DialogRequest {
  String title;
  String description;
  AlertType alertType;

  DialogRequest({this.title, this.description, this.alertType});
}
