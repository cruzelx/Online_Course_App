import 'package:online_course_app/bloc/baseViewModel.dart';
import 'package:online_course_app/services/firebaseBaseAPIService.dart';

class CourseViewModel extends BaseModel {
  FirebaseBaseAPIService _api = FirebaseBaseAPIService("courses");
  
  
}
