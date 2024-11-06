import 'package:get/get.dart';
import 'package:sales_person_app/views/list_items/controllers/list_items_controller.dart';

class ListItemsBiniding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListItemsController>(
      () => ListItemsController(),
    );
  }
}
