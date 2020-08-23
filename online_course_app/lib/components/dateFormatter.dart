import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String dateFormatter({Timestamp serverDate, DateTime localDate}) {
  String date;
  if (serverDate != null)
    date = DateFormat('EEE, MMM d, yyyy k:mm')
        .format(DateTime.tryParse(serverDate.toDate().toString()));
  else if (localDate != null)
    date = DateFormat('EEE, MMM d, yyyy k:mm')
        .format(DateTime.tryParse(serverDate.toDate().toString()));

  return date;
}
