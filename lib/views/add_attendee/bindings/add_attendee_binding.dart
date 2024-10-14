import 'package:get/get.dart';
import 'package:sales_person_app/views/add_attendee/controllers/add_attendee_controller.dart';

class AddAttendeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAttendeeController>(
      () => AddAttendeeController(),
    );
  }
}
