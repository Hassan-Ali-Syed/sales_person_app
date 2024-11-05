import 'package:get/get.dart';
import 'package:sales_person_app/views/add_new_customer/controller/add_new_customer_controller.dart';

class AddNewCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewCustomerController>(
      () => AddNewCustomerController(),
    );
  }
}
