import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/api_quries/tlicustomers_query.dart';
import 'package:sales_person_app/views/main_page/api_quries/tliitems_query.dart';
import 'package:sales_person_app/views/main_page/models/tli_items_model.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/views/main_page/views/contact_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/customer_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/home_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/more_page_screen.dart';

class MainPageController extends GetxController {
  final GlobalKey<ScaffoldState> mainPageScaffoldKey =
      GlobalKey<ScaffoldState>();
  // Observable for selecte Index from NavBar
  var selectedIndex = 1.obs;
  RxList<String> selectedItems = <String>[].obs;

  // Pages for bottom navigation
  List pages = [
    const HomePageScreen(),
    const CustomerPageScreen(),
    const ContactPageScreen(),
    const MorePageScreen()
  ];

  // AppBar title
  final List<String> appBarTitle = [
    AppStrings.HOME_TITLE,
    AppStrings.CUSTOMER_TITLE,
    AppStrings.CONTACT_TITLE,
    AppStrings.MORE_TITLE
  ];

  // flag for tracking API process
  var isLoading = false.obs;

  // Initialize the list to hold customer data
  List<Map<String, dynamic>> customersData = [];
  // reactive variable for scanning result
  RxString scanBarcode = ''.obs;
  // RxString token = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCustomersFromGraphQL();
    checkBoxStates.value = List.filled(tliCustomers!.value.length, false);
  }

  // Method to update selectedIndex of Bottom Navigation Bar
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> userLogOut() async {
    await BaseClient.safeApiCall(
      ApiConstants.LOG_OUT,
      RequestType.post,
      headers: await BaseClient.generateHeadersForLogout(),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccess: (response) {
        Preferences().removeToken();
        isLoading.value = false;
        Get.offAllNamed(AppRoutes.SIGN_IN);
      },
      onError: (p0) {
        isLoading.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: p0.message,
          duration: const Duration(seconds: 2),
        );
      },
    );
  }

  //**************** CUSTOMER PAGE PORTION ************************//
  //Instance of Models which
  TliCustomers? tliCustomers;
  TliItems? tliItems;

  // Customer's Ship To Address
  List<String> customersShipToAdd = [''].obs;

  //flags for customer text field
  RxBool isCustomerExpanded = false.obs;
  RxBool isCustomerSearch = false.obs;

  //Reactive variable for customer's Address
  RxString customerAddress = ''.obs;

  //flags for ship to Address text fields
  RxBool isShipToAddExpanded = false.obs;
  RxBool isShipToAddSearch = false.obs;

// flags for Textfields visibilty
  RxBool isAddressFieldVisible = false.obs;
  RxBool isShipToAddFieldVisible = false.obs;
  RxBool isAttandeesFieldVisible = false.obs;

//Flags of attandee
  RxBool isAttandeeFieldVisible = false.obs;
  RxBool isAttandeeExpanded = false.obs;
  RxBool isAttandeeSearch = false.obs;

  //attandee List of checkbox
  RxList<bool> checkBoxStates = <bool>[].obs;

  // attandee (Contact) selected index flag
  RxInt attandeeSelectedIndex = 0.obs;

  //Scroll Controller
  ScrollController customerScrollController = ScrollController();
  ScrollController shipToAddScrollController = ScrollController();
  ScrollController attandeeScrollController = ScrollController();

  // Customer's TextFields
  late TextEditingController customerController;
  TextEditingController customerTextFieldController = TextEditingController();
  TextEditingController searchCustomerController = TextEditingController();
  // Customer's Bill to Address TextField
  late TextEditingController addressController;
// Ship to Address TextField
  late TextEditingController shipToAddController;
  TextEditingController searchShipToAddController = TextEditingController();
  // Contacts textField
  TextEditingController attandeeController = TextEditingController();
  TextEditingController searchAttandeeController = TextEditingController();

  Future<void> getCustomersFromGraphQL() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicustomersQuery.tliCustomersQuery(),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        log("########RESPONSE: ############## \n ${response.data}");
        addTliCustomerModel(response.data!['tliCustomers']);
        isLoading.value = false;
      },
      onError: (e) {
        isLoading.value = false;
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error',
          message: e.message,
          duration: const Duration(seconds: 5),
        );
        log('*** onError *** \n ${e.message}');
      },
    );
  }

  Future<void> getSingleItemFromGraphQL(String no) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliItemsQuery.tliItemsQuery(no),
      onSuccessGraph: (response) {
        addTliItemsModel(response.data!["tliItems"]);
        isLoading.value = false;
        log('******* On SUCCESS ******** \n $tliItems');
      },
      onLoading: () {
        isLoading.value = true;
        log('******* LOADING ********');
      },
      onError: (e) {
        isLoading.value = false;
        log('******* ON ERROR******** \n ${e.message}');
      },
    );
  }

  void setCustomerData(var indexNo) {
    isAddressFieldVisible.value = false;

    customerAddress.value =
        "${tliCustomers!.value[indexNo].address}  ${tliCustomers!.value[indexNo].address2}";
    isAddressFieldVisible.value = true;
    addressController = TextEditingController(text: customerAddress.value);
    setCustomerShipToAdd(indexNo);
    isAddressFieldVisible.value = true;
  }

  void setCustomerShipToAdd(var index) {
    customersShipToAdd.clear();
    var instanceCustomerShipToAdd = tliCustomers!.value[index].tliShipToAdds;
    if (instanceCustomerShipToAdd != null) {
      for (var element in instanceCustomerShipToAdd) {
        customersShipToAdd.add('${element.address!}.${element.address2!}');
      }
    }
    shipToAddController = TextEditingController(text: '');
    isShipToAddFieldVisible.value = true;
  }

  addTliCustomerModel(response) {
    tliCustomers = TliCustomers.fromJson(response);
    isLoading.value = false;
  }

  addTliItemsModel(response) {
    tliItems = TliItems.fromJson(response);
    isLoading.value = false;
  }

  void onCheckboxChanged(bool? value, int index) {
    checkBoxStates[index] = value!;
    if (value) {
      selectedItems.add(tliCustomers!.value[index].contact!);
    } else {
      selectedItems.remove(tliCustomers!.value[index].contact!);
    }
    attandeeController.text = selectedItems.join(',');
  }

// Method for scanning barcode
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (barcodeScanRes != 'Failed to get platform version.') {
      getSingleItemFromGraphQL(barcodeScanRes);
    }
  }

  // CONTACT PAGE

  //MORE PAGE
}

// Future<void> getSingleCustomerFromGraphQL(String no) async {
//     await BaseClient.safeApiCall(
//       ApiConstants.BASE_URL_GRAPHQL,
//       RequestType.query,
//       headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
//       query: """query MyQuery {
//         tliCustomers(
//           companyId: "${ApiConstants.SILK_ID}",
//           page: 1,
//           perPage: 1000,
//           filter: "name eq '$no'",
//           )
//           {
//           message
//           success
//           value {
//             systemId
//             name
//             no

//           }
//         }
//       }""",
//       onSuccessGraph: (response) {
//         final data = response.data!["tliCustomers"];
//         isLoading.value = false;
//         print(data);
//       },
//       onLoading: () {
//         isLoading.value = true;
//       },
//       onError: (e) {
//         isLoading.value = false;
//         print(e.message);
//       },
//     );
//   }

//   Future<void> getSingleCustomerShipToAddressFromGraphQL(
//       String customerNo) async {
//     await BaseClient.safeApiCall(
//       ApiConstants.BASE_URL_GRAPHQL,
//       RequestType.query,
//       headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
//       query: """
//       query MyQuery {
//       tliShipToAdds(
//         companyId: "${ApiConstants.SILK_ID}"
//         page: 1
//         perPage: 10,
//         filter: " customerNo eq 'C00005'"
//         )
//         {
//         message
//         value {
//           address
//           address2
//           code
//           customerNo
//           }
//         }
//       }
//     }""",
//       onSuccessGraph: (response) {
//         final data = response.data!["tliShipToAdds"];
//         isLoading.value = false;
//         print(data);
//       },
//       onLoading: () {
//         isLoading.value = true;
//       },
//       onError: (e) {
//         isLoading.value = false;
//         print(e.message);
//       },
//     );
//   }

//   Future<void> getSingleCustomerContactsFromGraphQL(String customerNo) async {
//     await BaseClient.safeApiCall(
//       ApiConstants.BASE_URL_GRAPHQL,
//       RequestType.query,
//       headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
//       query: """ query MyQuery {
//       tliContacts(
//         companyId: "${ApiConstants.SILK_ID}"
//         page: 1
//         perPage: 100
//         filter: "customerNo eq '$customerNo'"
//       ) {
//         status
//         success
//         value {
//           address
//           address2
//           customerNo
//           name
//         }
//       }
//     }""",
//       onSuccessGraph: (response) {
//         final data = response.data!["tliContacts"];
//         isLoading.value = false;
//         print(data);
//       },
//       onLoading: () {
//         isLoading.value = true;
//       },
//       onError: (e) {
//         isLoading.value = false;
//         print(e.message);
//       },
//     );
//   }
