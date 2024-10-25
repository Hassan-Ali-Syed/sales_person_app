import 'package:get/get.dart';
import 'package:sales_person_app/views/add_ship_to_address/controller/add_ship_to_address_controller.dart';

class AddShipToAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddShipToAddressController>(
      () => AddShipToAddressController(),
    );
  }
}
