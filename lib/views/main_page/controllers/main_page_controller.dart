import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/api_quries/tlicustomers_query.dart';
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
  TliCustomers? tliCustomers;

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
  void onInit() {
    super.onInit();
    getCustomersFromGraphQL();
  }

  // Method to update selectedIndex of Bottom Navigation Bar
  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  //**************** CUSTOMER PAGE PORTION ************************//

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

  // attandee (Contact) selected index flag
  RxInt attandeeSelectedIndex = 0.obs;

  //Scroll Controller
  ScrollController customerScrollController = ScrollController();
  ScrollController shipToAddScrollController = ScrollController();

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
  late TextEditingController attandeeController;

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
      query: """ query MyQuery {
        tliItems(
          companyId: "aabdd4f3-a1f4-ec11-82f8-0022483487fb"
          page: 1
          perPage: 10000
          filter: "no eq '$no'"
          ) {
          value {
            description
            systemId
            unitPrice
            no
          }
        }
      }""",
      onSuccessGraph: (response) {
        final data = response.data!["tliItems"];
        isLoading.value = false;
        log(data);
      },
      onLoading: () {
        isLoading.value = true;
      },
      onError: (e) {
        isLoading.value = false;
        log(e.message);
      },
    );
  }

  void setCustomerData(var indexNo) {
    customerAddress.value =
        '${tliCustomers!.value[indexNo].address}.${tliCustomers!.value[indexNo].address2}';
    isAddressFieldVisible.value = true;
    addressController = TextEditingController(text: customerAddress.value);
    setCustomerShipToAdd(indexNo);
  }

// Customer's Ship To Address
  List<String> customersShipToAdd = [''].obs;
  void setCustomerShipToAdd(var index) {
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
