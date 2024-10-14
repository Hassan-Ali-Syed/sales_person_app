import 'package:get/get.dart';
import 'package:sales_person_app/views/customer_visit/controllers/customer_visit_controller.dart';

class CustomerVisitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerVisitController>(() => CustomerVisitController());
  }
}
