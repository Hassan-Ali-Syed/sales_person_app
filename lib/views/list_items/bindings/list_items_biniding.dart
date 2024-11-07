import 'package:get/get.dart';
import 'package:sales_person_app/views/list_items/controllers/scanner_module_controller.dart';

class ScannerModuleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScannerModuleController>(
      () => ScannerModuleController(),
    );
  }
}
