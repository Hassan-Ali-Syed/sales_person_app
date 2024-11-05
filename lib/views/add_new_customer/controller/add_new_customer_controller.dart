import 'package:get/get.dart';

class AddNewCustomerController extends GetxController {

  RxBool generalPressed = false.obs;
  RxBool adressContactPressed = false.obs;
  RxBool invoicingPressed = false.obs;
    RxBool taxButtonPressed = false.obs;

  void toggleGeneral() {
    generalPressed.value = !generalPressed.value;
  }

  void toggleadressContact() {
    adressContactPressed.value = !adressContactPressed.value;
  }

  void toggleInvoicing() {
    invoicingPressed.value = !invoicingPressed.value;
  }

}
