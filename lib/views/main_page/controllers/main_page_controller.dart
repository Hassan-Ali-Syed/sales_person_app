import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tli_sales_line.dart';
import 'package:sales_person_app/views/main_page/queries/api_mutate/tlicontact_mutate.dart';
import 'package:sales_person_app/views/main_page/queries/api_quries/tlicustomers_query.dart';
import 'package:sales_person_app/views/main_page/queries/api_quries/tliitems_query.dart';
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

  // flag for tracking API process
  var isLoading = false.obs;
  // Pages for bottom navigation
  List pages = [
    const HomePageScreen(),
    const CustomerPageScreen(),
    const ContactPageScreen(),
    const MorePageScreen()
  ];
  RxInt itemIndex = 0.obs;
  // AppBar title
  final List<String> appBarTitle = [
    AppStrings.HOME_TITLE,
    AppStrings.CUSTOMER_TITLE,
    AppStrings.CONTACT_TITLE,
    AppStrings.MORE_TITLE
  ];

  // Initialize the list to hold customer data
  List<Map<String, dynamic>> customersData = [];
  RxList<String?> customerNames = <String?>[].obs;

  // reactive variable for scanning result
  RxString scanBarcode = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    await getCustomersFromGraphQL();
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
  TliCustomers? tliCustomerById;
  TliItems? tliItem;
  TliSalesLine? tliSalesLine;

// Reactive variable for Customers
  String customerNo = '';
  String shipToCode = '';
  RxString customerAddress = ''.obs;
  String shipToAddCode = '';

  // Customer's Ship To Address
  List<Map<String, dynamic>> customersShipToAdd = <Map<String, dynamic>>[];
  // List<String> customersContacts = [''].obs;
  RxList<Map<String, dynamic>> customerContacts = <Map<String, dynamic>>[].obs;
  List<Widget> attendeeButtons = [];
  RxString selectedAttendee = ''.obs;
  List<Map<String, dynamic>> listOfTliItems = [];

  //flags for customer text field
  RxBool isCustomerExpanded = false.obs;
  RxBool isCustomerSearch = false.obs;

  //flags for ship to Address text fields
  RxBool isShipToAddExpanded = false.obs;
  RxBool isShipToAddSearch = false.obs;
  RxBool userItemListReferesh = true.obs;

// flags for Textfields visibility
  RxBool isAddressFieldVisible = false.obs;
  RxBool isShipToAddFieldVisible = false.obs;
  RxBool isAttandeesFieldVisible = false.obs;

//Flags of attandee
  RxBool isAttandeeFieldVisible = false.obs;
  RxBool isAttandeeExpanded = false.obs;
  RxBool isAttandeeSearch = false.obs;
  RxBool itemsListRefresh = false.obs;
  RxBool isQtyPressed = false.obs;

  //attandee List of checkbox
  RxList<bool> checkBoxStates = <bool>[].obs;

  // attandee (Contact) selected index flag
  RxInt attandeeSelectedIndex = 0.obs;
  RxBool barcodeScanned = false.obs;
  RxList<Map<String, dynamic>> selectedAttendees = <Map<String, dynamic>>[].obs;
  Map<String, List> attendeeItemsMap = {};

  //Scroll Controller
  ScrollController customerScrollController = ScrollController();
  ScrollController shipToAddScrollController = ScrollController();
  ScrollController attandeeScrollController = ScrollController();
  ScrollController contactScrollController = ScrollController();

  // Customer's TextFields

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
  TextEditingController itemQntyController = TextEditingController();

// GET ALL CUSTOMERS RECORDS
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
        log("########RESPONSE: ############## \n ${response.data!['tliCustomers']}");
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

  void searchQuery(List items, String item, TextEditingController controller) {
    if (items.contains(item)) {
      controller.text = item;
    }
  }

  Future<void> getCustomerbyIdFromGraphQL(String no) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicustomersQuery.tliCustomerGetByIdQuery(no),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        log("########RESPONSE: ############## \n ${response.data}");
        addTliCustomerByIdModel(response.data!['tliCustomers']);

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
        log('******* On SUCCESS ********');
        log("=================${response.data}==============");

        addTliItemModel(response.data!["tliItems"]);
        isLoading.value = false;
      },
      onLoading: () {
        userItemListReferesh.value = true;
        isLoading.value = true;
        log('******* LOADING ********');
      },
      onError: (e) {
        isLoading.value = false;
        log('******* ON ERROR******** \n ${e.message}');
      },
    );
  }

//******* CREATE SALES ORDER *************/
  Future<void> createSalesOrderRest({
    required String sellToCustomerNo,
    required String contact,
    required String externalDocumentNo,
    required List<Map<String, dynamic>>? tliSalesLines,
  }) async {
    await BaseClient.safeApiCall(
        ApiConstants.CREATE_SALES_ORDER, RequestType.post,
        headers: await BaseClient.generateHeadersWithToken(),
        data: {
          "no": "",
          "sellToCustomerNo": sellToCustomerNo,
          "contact": contact,
          "externalDocumentNo": createExternalDocumentNo(contact),
          "locationCode": "SYOSSET",
          "tliSalesLines": tliSalesLines,
        });
  }

// ******** CREATE SALES LINE COMMENT ************
  Future<void> createSalesLineComment({
    required List<Map<String, dynamic>>? tliSalesLines,
  }) async {
    await BaseClient.safeApiCall(
        ApiConstants.CREATE_SALES_LINES_COMMENT, RequestType.post,
        headers: await BaseClient.generateHeadersWithToken(),
        data: {
          {
            "no": "SO12693",
            "documentLineNo": 10000,
            "lineNo": 10000,
            "date": "2023-03-14",
            "comment": "Order Line One Comment"
          }
        });
  }

  String createExternalDocumentNo(String contactNo) {
    String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
    return "VISIT_${formattedDate}_$contactNo";
    // return formattedDate;
  }

  void setCustomerData(var indexNo) async {
    isAddressFieldVisible.value = false;

    customerAddress.value =
        "${tliCustomers!.value[indexNo].address}  ${tliCustomers!.value[indexNo].address2}";
    addressController = TextEditingController(text: customerAddress.value);
    isAddressFieldVisible.value = true;
    customerNo = tliCustomers!.value[indexNo].no!;

    log('Customer No: $customerNo');
    await getCustomerbyIdFromGraphQL(customerNo);

    shipToAddController = TextEditingController(text: '');
    isShipToAddFieldVisible.value = true;
    setCustomerShipToAdd();
    setCustomerContacts();
  }

// SET CUSTOMER'S SHIP TO ADDRESSES
  void setCustomerShipToAdd() {
    // Clear the current list of ship-to addresses
    customersShipToAdd.clear();

    // Retrieve customer data from tliCustomerById
    var instanceCustomerShipToAdd = tliCustomerById?.value;

    // Check if there is any customer data to process
    if (instanceCustomerShipToAdd != null &&
        instanceCustomerShipToAdd.isNotEmpty) {
      // Iterate through each customer
      for (var values in instanceCustomerShipToAdd) {
        // Retrieve the list of ship-to addresses for each customer
        var tliShipToAddresses = values.tliShipToAdds;

        // Ensure ship-to addresses are not null
        if (tliShipToAddresses != null) {
          for (var element in tliShipToAddresses) {
            // Add each ship-to address to the customersShipToAdd list
            customersShipToAdd.add({
              'address':
                  '${element.address ?? ''} ${element.address2 ?? ''}'.trim(),
              'shipToAddsCode': element.code ?? '',
            });
          }
        }
      }
    }
  }

// SET CUSTOMER'S CONTACTS
  void setCustomerContacts() {
    customerContacts.clear();
    var instanceCustomer = tliCustomerById!.value;
    if (instanceCustomer.isNotEmpty) {
      for (var values in instanceCustomer) {
        var tliContacts = values.tliContact;
        for (var element in tliContacts!) {
          customerContacts.add({
            'name': element.name,
            'contactNo': element.no,
            'tliSalesLine': []
          });
        }
        checkBoxStates.value =
            List.generate(customerContacts.length, (index) => false);
      }
    }
  }

  // Set Selected Ship to Add
  String setSelectedShipToAdd(int index) {
    if (index < 0 || index >= customersShipToAdd.length) {
      log('Invalid index: $index');
      return 'Invalid index';
    }
    var address = customersShipToAdd[index]['address'] ?? 'Address not found';
    shipToAddCode = customersShipToAdd[index]['shipToAddsCode'];
    log('**** After selecting address from ship to add list ******');
    log('**** Ship to Address: $address');
    log('**** Ship to Code: $shipToAddCode');
    return address;
  }

  addTliCustomerModel(response) {
    tliCustomers = TliCustomers.fromJson(response);
    isLoading.value = false;
  }

  addTliCustomerByIdModel(response) {
    tliCustomerById = TliCustomers.fromJson(response);
    isLoading.value = false;
  }

  addTliItemModel(response) {
    itemsListRefresh.value = true;

    tliItem = TliItems.fromJson(response);
    log('============ After Parse ${tliItem!.value}================');

    List<dynamic> currentSalesLines =
        selectedAttendees[attandeeSelectedIndex.value]['tliSalesLine'] ?? [];

    currentSalesLines.add(
      TliSalesLineElement(
        lineNo: currentSalesLines.isNotEmpty
            ? (currentSalesLines.length + 1) * 10000
            : 10000,
        type: 'Item',
        no: tliItem!.value[0].no!,
        quantity: num.parse(tliItem!.value[0].qntyController!.text),
        unitPrice: num.parse(tliItem!.value[0].unitPrice.toString()),
        itemDescription: tliItem!.value[0].description!,
      ),
    );
    var tliSalesLineList = selectedAttendees[attandeeSelectedIndex.value]
        ['tliSalesLine'] = currentSalesLines;
    if (selectedAttendees[attandeeSelectedIndex.value]['tliSalesLine']
        .isNotEmpty) {
      for (var salesLine in tliSalesLineList) {
        if (salesLine is TliSalesLineElement) {
          log('Line No: ${salesLine.lineNo}');
          log('Type: ${salesLine.type}');
          log('No: ${salesLine.no}');
          log('Quantity: ${salesLine.quantity}');
          log('Unit Price: ${salesLine.unitPrice}');
          log('Description: ${salesLine.itemDescription}');
        } else {
          log('Invalid sales line element.');
        }
      }
    } else {
      log('No sales line data available.');
    }
    itemsListRefresh.value = false;
    userItemListReferesh.value = false;
    isLoading.value = false;
    log('==SELECTED ATTENDEES LIST==========${selectedAttendees[0]['tliSalesLine'].length}=========================');
    log('==SELECTED ATTENDEES LIST==========${selectedAttendees[0]['tliSalesLine'][0].itemDescription}=========================');
  }

  void onCheckboxChanged(bool? value, int index) {
    if (value == true) {
      checkBoxStates[index] = true;
      selectedAttendees.add({
        'name': customerContacts[index]['name'],
        'contactNo': customerContacts[index]['contactNo'],
        'tliSalesLine': customerContacts[index]['tliSalesLine']
      });
      log('**** SELECTED ATTANDEES $selectedAttendees ******');
    } else {
      checkBoxStates[index] = false;

      selectedAttendees.removeWhere((attendee) =>
          attendee['name'] == customerContacts[index]['name'] &&
          attendee['contactNo'] == customerContacts[index]['contactNo'] &&
          attendee['tliSalesLine'] == customerContacts[index]['tliSalesLine']);

      log('**** SELECTED ATTANDEES $selectedAttendees ******');
    }

    attandeeController.text =
        selectedAttendees.map((attendee) => attendee['name']).join(',');
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
      await getSingleItemFromGraphQL(barcodeScanRes);
      barcodeScanned.value = true;
    }
  }

  void showCommentDialog(BuildContext context) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'Enter your comment here',
            ),
            maxLines: 3, // Allows multiple lines for the comment
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String comment = commentController.text;
                if (comment.isNotEmpty) {
                  // Perform action with the comment, e.g., save it
                  log('Comment: $comment');
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Show a message or handle empty comment
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Comment cannot be empty')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // **************************** CONTACT PAGE PORTION ************************ //
  // CONTACT PAGE's TEXTFIELD CONTROLLERS
  TextEditingController contactFullNameTextFieldController =
      TextEditingController();
  TextEditingController contactSearchTextFieldController =
      TextEditingController();
  TextEditingController contactCustomerTextFieldController =
      TextEditingController();
  TextEditingController contactEmailTextFieldController =
      TextEditingController();
  TextEditingController contactAddressTextFieldController =
      TextEditingController();
  TextEditingController contactPhoneNoTextFieldController =
      TextEditingController();

  var contactCustomerNo = ''.obs;

// CONTACT PAGE's SCROLL CONTROLLERS
  ScrollController contactCustomerScrollController = ScrollController();

  //FLAGS OF CUSTOMER's TEXTFIELD
  RxBool isContactCustomerExpanded = false.obs;
  RxBool isContactCustomerSearch = false.obs;

  Future<void> createTliContacts({
    required String name,
    required String customerNo,
    required String address,
    required String email,
    required String phoneNo,
  }) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.mutate,
      headersForGraphQL: BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TlicontactMutate.tliContactMutate(
        name: name,
        customerNo: customerNo,
        address: address,
        email: email,
        phoneNo: phoneNo,
      ),
      onLoading: () {
        isLoading.value = true;
      },
      onSuccessGraph: (response) {
        log("******* RESPONSE: *********\n ${response.data!['message']}");

        if (response.data!['createtliContact']['status'] == 400) {
          CustomSnackBar.showCustomToast(
              message: '${response.data!['createtliContact']['success']}',
              duration: const Duration(seconds: 3),
              color: AppColors.redShade5);
          isLoading.value = false;
        } else {
          CustomSnackBar.showCustomToast(
            message: '${response.data!['createtliContact']['message']}',
            duration: const Duration(seconds: 3),
            color: Colors.green,
          );
          isLoading.value = false;
        }
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

  void clearAllTextFieldsOfContactPage() {
    contactFullNameTextFieldController.clear();
    // controller.contactCustomerNo.value,
    contactCustomerTextFieldController.clear();
    contactAddressTextFieldController.clear();
    contactEmailTextFieldController.clear();
    contactPhoneNoTextFieldController.clear();
  }

  //MORE PAGE
}
