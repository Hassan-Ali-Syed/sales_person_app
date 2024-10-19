import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/queries/api_quries/tliitems_query.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tli_items_model.dart';
import 'package:sales_person_app/views/main_page/models/tli_sales_line.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/queries/api_quries/tlicustomers_query.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class CustomerVisitController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getCustomersFromGraphQL();
  }

  final GlobalKey<ScaffoldState> customerVisitScaffoldKey =
      GlobalKey<ScaffoldState>();

  //Instance of Models which
  TliCustomers? tliCustomers;
  TliCustomers? tliCustomerById;
  TliItems? tliItem;
  TliSalesLine? tliSalesLine;

  RxBool isLoading = false.obs;
  RxBool isServerError = false.obs;
  RxInt itemIndex = 0.obs;
  RxBool barcodeScanned = false.obs;
  RxBool userItemListReferesh = false.obs;
  RxBool itemsListRefresh = false.obs;
  RxBool isQtyPressed = false.obs;

  TextEditingController commentController = TextEditingController();
  TextEditingController itemQntyController = TextEditingController();

  // Reactive variables
  String customerNo = '';
  RxString customerAddress = ''.obs;
  String selectedShipToAddCode = '';
  RxInt attendeeSelectedIndex = 0.obs;
  RxString selectedAttendee = ''.obs;
  List<Map<String, dynamic>> customersShipToAdd = <Map<String, dynamic>>[];
  RxList<Map<String, dynamic>> customerContacts = <Map<String, dynamic>>[].obs;
  //selected attendees List of checkbox
  RxList<bool> checkBoxStates = <bool>[].obs;
  RxList<Map<String, dynamic>> selectedAttendees = <Map<String, dynamic>>[].obs;

  //customer's text field & flags
  RxBool isCustomerExpanded = false.obs;
  ScrollController customerScrollController = ScrollController();
  TextEditingController customerTextFieldController = TextEditingController();

  // ADDRESS FIELD's related
  RxBool isAddressFieldVisible = false.obs;
  late TextEditingController addressController;

  // Customer's Ship To Address
  RxBool isShipToAddFieldVisible = false.obs;
  RxBool isShipToAddExpanded = false.obs;
  RxBool isShipToAddSearch = false.obs;
  late TextEditingController shipToAddController;
  TextEditingController searchShipToAddController = TextEditingController();
  ScrollController shipToAddScrollController = ScrollController();

  // Attendee's related flags and controller
  RxBool isAttendeeFieldVisible = false.obs;
  RxBool isAttendeeExpanded = false.obs;
  RxBool isAttendeeSearch = false.obs;
  ScrollController attendeeScrollController = ScrollController();
  TextEditingController attendeeController = TextEditingController();
  TextEditingController searchAttendeeController = TextEditingController();

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
          title: 'Server Error',
          message: 'Data not fetched. Try again later',
          duration: const Duration(seconds: 5),
        );
        log('*** onError *** \n ${e.message}');
      },
    );
  }

// CREATE SALES ORDER OF SELECTED ATTENDEES
  Future<void> createSalesOrdersOfSelectedattendees() async {
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
            tliSalesLines: listOfTliSalesLineMaps);
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Failed to create order',
          message: '${attendeeData['name']} has no item(s)',
          duration: const Duration(seconds: 2),
        );
        log('==Current attendee Data  ${attendeeData['name']}===================');
      }
      log('==LIST OF TliSALESLINE MAP   $listOfTliSalesLineMaps===================');
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
        barcodeScanned.value = true;
        isLoading.value = true;
        log('******* LOADING ********');
      },
      onSuccessGraph: (response) {
        log('******* On SUCCESS ********');
        log("======getSingleItemFromGraphQL===========${response.data}==============");
        addTliItemModel(response.data!["tliItems"]);
        isLoading.value = false;
        userItemListReferesh.value = false;
        barcodeScanned.value = false;
      },
      onError: (e) {
        CustomSnackBar.showCustomErrorSnackBar(
          title: 'Scan failed',
          message: 'Unable to recognize text. Please try again.',
          duration: const Duration(seconds: 2),
        );
        userItemListReferesh.value = false;
        barcodeScanned.value = false;
        isLoading.value = false;
        log('******* ON ERROR******** \n ${e.message}');
      },
    );
  }

  Future<void> createSalesOrderRest({
    required String sellToCustomerNo,
    required String contact,
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
          "shipToCode": selectedShipToAddCode,
          "tliSalesLines": tliSalesLines,
        },
        onLoading: () => isLoading.value = true,
        onSuccess: (response) {
          log('******* ON SUCCESS ${response.data}');
          CustomSnackBar.showCustomSnackBar(
            title: 'Sales Order created',
            message: '',
            duration: const Duration(seconds: 2),
          );
          isLoading.value = false;
        },
        onError: (e) {
          isLoading.value = false;
          if (e.statusCode == 400) {
            CustomSnackBar.showCustomErrorSnackBar(
              title: 'Already created',
              message: 'Failed to create sales order',
              duration: const Duration(seconds: 2),
            );
          }
          if (e.statusCode == 500) {
            CustomSnackBar.showCustomErrorSnackBar(
              title: 'Server Error',
              message: 'Failed to create sales order',
              duration: const Duration(seconds: 2),
            );
          }
          log('******* ON ERROR******** \n ${e.message}');
        });
  }

  Future<void> createSalesLineComment({
    required String salesOrderNo,
    required List<Map<String, dynamic>>? tliSalesLines,
  }) async {
    await BaseClient.safeApiCall(
        ApiConstants.CREATE_SALES_LINES_COMMENT, RequestType.post,
        headers: await BaseClient.generateHeadersWithToken(),
        data: {
          "no": salesOrderNo, // SalesOrder No
          "documentLineNo": 10000, // Sales Line No
          "lineNo": 10000, // line no for multiple comments of sales Line
          "date": currentDate(),
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

  String currentDate() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return formattedDate;
  }

  void setCustomerData(var indexNo) async {
    attendeeController.clear();
    selectedAttendees.clear();
    commentController.clear();
    isCustomerExpanded.value = false;
    filteredCustomers.value = tliCustomers!.value;
    isCustomerExpanded.value = false;
    isAddressFieldVisible.value = false;
    isShipToAddFieldVisible.value = false;
    isAttendeeFieldVisible.value = false;
    filteredCustomers.value = tliCustomers!.value;
    customerAddress.value =
        "${tliCustomers!.value[indexNo].address}  ${tliCustomers!.value[indexNo].address2}";
    addressController = TextEditingController(text: customerAddress.value);
    isAddressFieldVisible.value = true;
    customerNo = tliCustomers!.value[indexNo].no!;
    log('Customer No: $customerNo');

    await getCustomerbyIdFromGraphQL(customerNo);
    setCustomerShipToAdd();
    setCustomerContacts();
    shipToAddController = TextEditingController(text: '');
    isShipToAddFieldVisible.value = true;
    isShipToAddFieldVisible.value = true;
    isAttendeeFieldVisible.value = true;
  }

  // search query list and Method
  var filteredCustomers = [].obs;
  void filterCustomerList(String query) {
    if (tliCustomers?.value == null) return;
    if (query.isEmpty || query == ' ') {
      filteredCustomers.value = tliCustomers!.value;
    } else {
      filteredCustomers.value = tliCustomers!.value
          .where((customer) =>
              customer.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    log('List $filteredCustomers');
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
          if (element.type == 'Person' || element.type == 'person') {
            log("====Before Adding Contacts======${element.type}");
            customerContacts.add({
              'name': element.name,
              'contactNo': element.no,
              'type': element.type,
              'tliSalesLine': []
            });
            log("====After Adding Contacts======$customerContacts");
          }
        }
        checkBoxStates.value =
            List.generate(customerContacts.length, (index) => false);
      }
    }
  }

  // Set Selected Ship to Add
  String setSelectedShipToAdd(int index) {
    var address = customersShipToAdd[index]['address'] ?? 'Address not found';
    selectedShipToAddCode = customersShipToAdd[index]['shipToAddsCode'];
    log('**** After selecting address from ship to add list ******');
    log('**** Ship to Address: $address');
    log('**** Ship to Code: $selectedShipToAddCode');
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
    log('============ After Parse ${tliItem!.value.length}================');

    List<dynamic> currentSalesLines =
        selectedAttendees[attendeeSelectedIndex.value]['tliSalesLine'] ?? [];

    TliSalesLineElement newItem = TliSalesLineElement(
      lineNo: currentSalesLines.isNotEmpty
          ? (currentSalesLines.length + 1) * 10000
          : 10000,
      type: 'Item',
      no: tliItem!.value[0].no!,
      quantity: num.parse(tliItem!.value[0].qntyController!.text),
      unitPrice: num.parse(
        tliItem!.value[0].unitPrice.toString(),
      ),
      itemDescription: tliItem!.value[0].description!,
    );

    bool itemExists = false;
    for (var salesLineItem in currentSalesLines) {
      if (salesLineItem.no == newItem.no) {
        salesLineItem.quantity += newItem.quantity;
        itemExists = true;
        break;
      }
    }

    if (!itemExists) {
      currentSalesLines.add(newItem);
    }

    itemsListRefresh.value = false;
    userItemListReferesh.value = false;
    isLoading.value = false;

    log('==SELECTED ATTENDEES ITEM LIST==========${selectedAttendees[attendeeSelectedIndex.value]['tliSalesLine'][0]}=========================');
  }

  void onCheckboxChanged(bool? value, int index) {
    if (value == true) {
      checkBoxStates[index] = true;
      selectedAttendees.add({
        'name': customerContacts[index]['name'],
        'contactNo': customerContacts[index]['contactNo'],
        'tliSalesLine': customerContacts[index]['tliSalesLine']
      });
      log('**** SELECTED attendeeS $selectedAttendees ******');
    } else {
      checkBoxStates[index] = false;

      selectedAttendees.removeWhere((attendee) =>
          attendee['name'] == customerContacts[index]['name'] &&
          attendee['contactNo'] == customerContacts[index]['contactNo'] &&
          attendee['tliSalesLine'] == customerContacts[index]['tliSalesLine']);

      log('**** SELECTED attendeeS $selectedAttendees ******');
    }

    attendeeController.text =
        selectedAttendees.map((attendee) => attendee['name']).join(',');
  }

  // Method for scanning barcode
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    barcodeScanned.value = true;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (barcodeScanRes == 'Failed to get platform version.') {
      barcodeScanned.value = false;
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Scan failed',
        message: barcodeScanRes,
      );
    } else if (barcodeScanRes.isEmpty) {
      barcodeScanRes = 'Please scan Barcode again';
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Scan failed',
        message: barcodeScanRes,
      );
      barcodeScanned.value = false;
    } else {
      await getSingleItemFromGraphQL(barcodeScanRes);
    }
  }

  void showCommentDialog(BuildContext context,
      {required TextEditingController controller, void Function()? onPressed}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a Comment'),
          titleTextStyle: context.titleLarge.copyWith(
              color: const Color(0xff58595B), fontWeight: FontWeight.w800),
          backgroundColor: LightTheme.appBarBackgroundColor,
          content: TextField(
            maxLength: 80,
            controller: controller,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(),
              hintText: 'Enter your comment here',
            ),
            maxLines: 4,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: Sizes.PADDING_10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomElevatedButton(
                  onPressed: () {
                    Get.back();
                    commentController.clear();
                  },
                  title: AppStrings.CANCEL,
                  minWidht: Sizes.WIDTH_100,
                  minHeight: Sizes.HEIGHT_30,
                  backgroundColor: LightTheme.buttonBackgroundColor2,
                  borderRadiusCircular: BorderRadius.circular(
                    Sizes.RADIUS_6,
                  ),
                ),
                const SizedBox(
                  width: Sizes.WIDTH_20,
                ),
                CustomElevatedButton(
                  onPressed: onPressed,
                  title: 'Submit',
                  minWidht: Sizes.WIDTH_100,
                  minHeight: Sizes.HEIGHT_30,
                  backgroundColor: LightTheme.buttonBackgroundColor2,
                  borderRadiusCircular: BorderRadius.circular(
                    Sizes.RADIUS_6,
                  ),
                ),
              ]),
            )
          ],
        );
      },
    );
  }
}
