import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_person_app/queries/api_quries/tliitems_query.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tli_items_model.dart';
import 'package:sales_person_app/views/main_page/models/tli_sales_line.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/queries/api_quries/tlicustomers_query.dart';

class CustomerVisitController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getCustomersFromGraphQL();
  }

  // Initialize the list to hold customer data
  // List<Map<String, dynamic>> customersData = [];
  // RxList<String?> customerNames = <String?>[].obs;

  //Instance of Models which
  TliCustomers? tliCustomers;
  TliCustomers? tliCustomerById;
  TliItems? tliItem;
  TliSalesLine? tliSalesLine;
  RxBool isLoading = false.obs;
  RxBool isServerError = false.obs;
  RxInt itemIndex = 0.obs;

// Reactive variable for Customers
  String customerNo = '';
  RxString customerAddress = ''.obs;
  String shipToAddCode = '';

  // Customer's Ship To Address
  List<Map<String, dynamic>> customersShipToAdd = <Map<String, dynamic>>[];
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
  RxBool userItemListReferesh = false.obs;

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

  Future<void> createSalesOrdersOfSelectedAttandees() async {
    var attendeesData = selectedAttendees;
    for (var attendeeData in attendeesData) {
      List<Map<String, dynamic>> listOfTliSalesLineMaps = [];
      List<dynamic> tliSalesLineElement = attendeeData['tliSalesLine'];
      if (tliSalesLineElement.isNotEmpty) {
        for (var tliSalesLineMap in tliSalesLineElement) {
          listOfTliSalesLineMaps.add(
            tliSalesLineMap.toJson(),
          );
        }
        for (var i in listOfTliSalesLineMaps) {
          i.remove('itemDescription');
        }

        await createSalesOrderRest(
            sellToCustomerNo: customerNo,
            contact: attendeeData['contactNo'],
            // shipToCode: shipToAddCode,
            tliSalesLines: listOfTliSalesLineMaps);
      }
      log('==LIST OF TLISALESLINE MAP   $listOfTliSalesLineMaps===================');
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
      onLoading: () {
        userItemListReferesh.value = true;
        isLoading.value = true;
        log('******* LOADING ********');
      },
      onSuccessGraph: (response) {
        log('******* On SUCCESS ********');
        log("=================${response.data}==============");

        addTliItemModel(response.data!["tliItems"]);
        isLoading.value = false;
      },
      onError: (e) {
        isLoading.value = false;
        log('******* ON ERROR******** \n ${e.message}');
      },
    );
  }

  Future<void> createSalesOrderRest({
    required String sellToCustomerNo,
    required String contact,
    required List<Map<String, dynamic>>? tliSalesLines,
    // required String shipToCode,
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
          "shipToCode": shipToAddCode,
          "tliSalesLines": tliSalesLines,
        },
        onLoading: () => isLoading.value = true,
        onSuccess: (response) {
          log('******* ON SUCCESS ${response.data}');
          isLoading.value = false;
        },
        onError: (e) {
          isLoading.value = false;
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: e.message,
            duration: const Duration(seconds: 2),
          );
          log('******* ON ERROR******** \n ${e.message}');
        });
  }

  Future<void> createSalesLineComment({
    required List<Map<String, dynamic>>? tliSalesLines,
  }) async {
    await BaseClient.safeApiCall(
        ApiConstants.CREATE_SALES_LINES_COMMENT, RequestType.post,
        headers: await BaseClient.generateHeadersWithToken(),
        data: {
          "no": "SO12693", // SalesOrder No
          "documentLineNo": 10000, // Sales Line No
          "lineNo": 10000, // line no for multiple comments of sales Line
          "date": "2023-03-14",
          "comment": "Order Line One Comment" // comment limit 80 characters
        },
        onLoading: () => isLoading.value = true,
        onSuccess: (response) {
          log('******* ON SUCCESS ${response.data}');
          isLoading.value = false;
        },
        onError: (e) {
          isLoading.value = false;
          log('******* ON ERROR******** \n ${e.message}');
        });
  }

  String createExternalDocumentNo(String contactNo) {
    String formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
    return "VISIT $formattedDate $contactNo";
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

// search query list and Method
  var filteredCustomers = [].obs;
  void filterCustomerList(String query) {
    if (tliCustomers?.value == null) return;
    if (query.isEmpty) {
      filteredCustomers.value = List.from(tliCustomers!.value);
    } else {
      filteredCustomers.value = tliCustomers!.value
          .where((customer) =>
              customer.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

// SET CUSTOMER'S SHIP TO ADDRESSES
  void setCustomerShipToAdd() {
    customersShipToAdd.clear();
    var instanceCustomerShipToAdd = tliCustomerById?.value;
    if (instanceCustomerShipToAdd != null &&
        instanceCustomerShipToAdd.isNotEmpty) {
      for (var values in instanceCustomerShipToAdd) {
        var tliShipToAddresses = values.tliShipToAdds;
        if (tliShipToAddresses != null) {
          for (var element in tliShipToAddresses) {
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

    if (tliItem!.value.isNotEmpty) {
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
}
