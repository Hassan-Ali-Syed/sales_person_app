import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';
import 'package:sales_person_app/preferences/preferences.dart';
import 'package:sales_person_app/queries/api_quries/tliitems_query.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/themes/themes.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/main_page/models/tli_items_model.dart';
import 'package:sales_person_app/views/main_page/models/tli_sales_line.dart';
import 'package:sales_person_app/views/main_page/models/tlicontacts_model.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/queries/api_quries/tlicustomers_query.dart';
import 'package:sales_person_app/views/main_page/models/tlishiptoadds_model.dart';
import 'package:sales_person_app/widgets/custom_elevated_button.dart';

class CustomerVisitController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await addTliCustomerModel();
  }

  final GlobalKey<ScaffoldState> customerVisitScaffoldKey =
      GlobalKey<ScaffoldState>();

  //Instance of Models which
  TliCustomers? tliCustomers;
  TliCustomers? tliCustomerById;
  TliItems? tliItem;
  TliSalesLine? tliSalesLine;

  RxBool isLoading = false.obs;
  RxInt itemIndex = 0.obs;
  RxBool barcodeScanned = false.obs;
  RxBool userItemListReferesh = false.obs;
  RxBool itemsListRefresh = false.obs;
  RxBool isQtyPressed = false.obs;
  // List<Map<String, dynamic>> createdOrders = [];
  // List<Map<String, dynamic>> failedOrders = [];
  RxBool isSalesOrderCreating = false.obs;
  // Rx isSuccessfull = false.obs;
  CustomerValue? selectedCustomer;

  TextEditingController commentController = TextEditingController(text: '');
  TextEditingController itemQntyController = TextEditingController();

  RxString customerAddress = ''.obs;
  String selectedShipToAddCode = '';
  RxInt attendeeSelectedIndex = 0.obs;
  RxString selectedAttendee = ''.obs;

  List<String>? customersShipToAddList = <String>[];
  RxList<Map<String, dynamic>> customerContactsMap =
      <Map<String, dynamic>>[].obs;

  RxList<TliShipToAddress>? tliShipToAddresses = <TliShipToAddress>[].obs;
  RxList<TliContact>? tliContacts = <TliContact>[].obs;

  //selected attendees List of checkbox
  RxList<bool> checkBoxStates = <bool>[].obs;
  RxList<Map<String, dynamic>> selectedAttendees = <Map<String, dynamic>>[].obs;

  // customer's text field & flags
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

  Future<void> getCustomerbyIdFromGraphQL(String no) async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
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
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
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

  String createExternalDocumentNo(String contactNo) {
    String formattedDate = DateFormat('yyyyMMdd HHmmss').format(DateTime.now());
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
    isAddressFieldVisible.value = false;

    addressController = TextEditingController(
        text: "${selectedCustomer!.address}  ${selectedCustomer!.address2}");

    Preferences().setSelectedCustomerData(
      selectedCustomer!.toJson(),
    );

    isAddressFieldVisible.value = true;

    await getCustomerbyIdFromGraphQL(selectedCustomer!.no!);
  }

  // customer search query list and Method
  List<CustomerValue> filteredCustomers = <CustomerValue>[].obs;
  RxBool customerFieldRefresh = false.obs;
  void filterCustomerList() {
    customerFieldRefresh.value = true;
    if (tliCustomers?.value == null) return;
    if (customerTextFieldController.text.isEmpty ||
        customerTextFieldController.text == '') {
      filteredCustomers = tliCustomers!.value;
      customerFieldRefresh.value = false;
    } else {
      filteredCustomers = [];

      for (var element in tliCustomers!.value) {
        if (element.name!.toLowerCase().contains(
              customerTextFieldController.text.toLowerCase(),
            )) {
          filteredCustomers.add(element);
        }
      }
      customerFieldRefresh.value = false;
    }
    log('List $filteredCustomers');
  }

// Ship to Address search query list and Method
  List<TliShipToAddress> filteredShipToAddress = <TliShipToAddress>[].obs;
  RxBool shipToAddressFieldRefresh = false.obs;
  void filterShipToAddressList() {
    shipToAddressFieldRefresh.value = true;
    if (tliShipToAddresses == null) return;
    if (searchShipToAddController.text.isEmpty ||
        searchShipToAddController.text == '') {
      filteredShipToAddress = tliShipToAddresses!;
      shipToAddressFieldRefresh.value = false;
    } else {
      filteredShipToAddress = [];
      for (var element in tliShipToAddresses!) {
        var address = '${element.address} ${element.address2}';
        if (address.toLowerCase().contains(
              searchShipToAddController.text.toLowerCase(),
            )) {
          filteredShipToAddress.add(element);
        }
      }
      shipToAddressFieldRefresh.value = false;
    }
    log('List $filteredShipToAddress');
  }

// Attendee search query list and Method
  List<TliContact> filteredAttendees = <TliContact>[].obs;
  RxBool attendeeFieldRefresh = false.obs;
  List<TliContact> filterAttendeeList() {
    attendeeFieldRefresh.value = true;
    if (tliContacts != null) {
      if (searchAttendeeController.text.isEmpty ||
          searchAttendeeController.text == '') {
        filteredAttendees = tliContacts!;
        attendeeFieldRefresh.value = false;
      } else {
        filteredAttendees = [];
        for (var element in tliContacts!) {
          if (element.name!.toLowerCase().contains(
                searchAttendeeController.text.toLowerCase(),
              )) {
            filteredAttendees.add(element);
          }
        }
        attendeeFieldRefresh.value = false;
      }
      log('List $filteredAttendees');
    }
    return filteredAttendees;
  }

// SET CUSTOMER'S SHIP TO ADDRESSES
  void setCustomerShipToAdd() {
    isShipToAddFieldVisible.value = false;
    tliShipToAddresses!.clear();
    customersShipToAddList!.clear();
    var instanceCustomerShipToAdd = tliCustomerById?.value;
    if (instanceCustomerShipToAdd != null &&
        instanceCustomerShipToAdd.isNotEmpty) {
      for (var values in instanceCustomerShipToAdd) {
        tliShipToAddresses!.addAll(values.tliShipToAdds!);
        //   if (tliShipToAddresses != null) {
        //     for (var element in tliShipToAddresses) {
        //       customersShipToAddList!.add(
        //         '${element.address ?? ''} ${element.address2 ?? ''}'.trim(),
        //       );
        //       customersShipToAddMap.add({
        //         'address':
        //             '${element.address ?? ''} ${element.address2 ?? ''}'.trim(),
        //         'shipToAddsCode': element.code ?? '',
        //       });
        //     }
        //   }
      }

      filteredShipToAddress = tliShipToAddresses!;
      log('****filterShipToAddress**********$filteredShipToAddress*************');
    }
    shipToAddController = TextEditingController(text: '');

    isShipToAddFieldVisible.value = true;
  }

// SET CUSTOMER'S CONTACTS
  void setCustomerContacts() {
    isAttendeeFieldVisible.value = false;
    customerContactsMap.clear();
    tliContacts!.clear();

    var instanceCustomer = tliCustomerById!.value;
    if (instanceCustomer.isNotEmpty) {
      for (var values in instanceCustomer) {
        var tempTliContact = values.tliContact!;
        for (var element in tempTliContact) {
          if (element.type == 'Person' || element.type == 'person') {
            tliContacts!.add(element);
            customerContactsMap.add({'tliSalesLine': []});
          }
        }
      }
    }
    filteredAttendees = tliContacts!;
    checkBoxStates.value =
        List.generate(filterAttendeeList().length, (index) => false);
    isAttendeeFieldVisible.value = true;
    log("====After Adding Contacts======$customerContactsMap");
  }

  List<String> splitComment(String comment, int maxLength) {
    List<String> lines = [];
    int start = 0;
    while (start < comment.length) {
      int end = (start + maxLength > comment.length)
          ? comment.length
          : start + maxLength;
      if (end < comment.length && comment[end] != ' ') {
        int lastSpace = comment.lastIndexOf(' ', end);
        if (lastSpace > start) {
          end = lastSpace;
        }
      }
      lines.add(comment.substring(start, end).trim());
      start = end + 1;
    }
    for (int i = 0; i < lines.length; i++) {
      log('****** Lines ******* \n ${lines[i]} ** \n ');
    }

    return lines;
  }

  Future<void> createSalesOrdersOfSelectedAttendees() async {
    isSalesOrderCreating.value = true;
    Get.dialog(
      const Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        elevation: 0,
        child: SizedBox(
          height: Sizes.HEIGHT_50,
          width: Sizes.WIDTH_10,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
    );
    // createdOrders.clear();
    // failedOrders.clear();

    for (var attendeeData in selectedAttendees) {
      var contactNo = attendeeData['contactNo'];
      // var attendeeName = attendeeData['name'];
      List<dynamic> tliSalesLineElement = attendeeData['tliSalesLine'];

      List<Map<String, dynamic>> listOfTliSalesLineMaps = [];
      if (tliSalesLineElement.isNotEmpty) {
        // Populate the sales lines for the sales order
        for (var tliSalesLineMap in tliSalesLineElement) {
          listOfTliSalesLineMaps.add({
            'lineNo': tliSalesLineMap.lineNo,
            'type': tliSalesLineMap.type,
            'no': tliSalesLineMap.no,
            'quantity': tliSalesLineMap.quantity,
            'unitPrice': tliSalesLineMap.unitPrice,
          });
        }

        // Attempt to create the sales order
        await BaseClient.safeApiCall(
          ApiConstants.CREATE_SALES_ORDER,
          RequestType.post,
          headers: await BaseClient.generateHeadersWithToken(),
          data: {
            "no": "",
            "sellToCustomerNo": selectedCustomer!.no!,
            "contact": contactNo,
            "externalDocumentNo": createExternalDocumentNo(contactNo),
            "locationCode": "SYOSSET",
            "shipToCode": selectedShipToAddCode,
            "tliSalesLines": listOfTliSalesLineMaps,
          },
          onSuccess: (response) async {
            if (response.data['success']) {
              log('******* Sales order created ${response.data} ****');
              // isSuccessfull.value = true;
              var salesOrderNo = response.data['data']['no'];
              // // Store order details in createdOrders list
              // createdOrders.add({
              //   'customerNo': selectedCustomer!.no!,
              //   'attendeeName': attendeeName,
              //   'contactNo': contactNo,
              //   'orderNo': salesOrderNo
              // });

              // Process sales line comments if available
              for (var tliSalesLine in tliSalesLineElement) {
                if (tliSalesLine.comment != null &&
                    tliSalesLine.comment.isNotEmpty) {
                  List<String> commentLines =
                      splitComment(tliSalesLine.comment, 80);
                  for (var i = 0; i < commentLines.length; i++) {
                    await BaseClient.safeApiCall(
                        ApiConstants.CREATE_SALES_LINES_COMMENT,
                        RequestType.post,
                        headers: await BaseClient.generateHeadersWithToken(),
                        data: {
                          "no": salesOrderNo,
                          "documentLineNo": tliSalesLine.lineNo,
                          "lineNo": i < 1 ? 10000 : 10000 + (i * 10000),
                          "date": currentDate(),
                          "comment": commentLines[i]
                        }, onSuccess: (response) {
                      log('******* Sales Line Comment created ${response.data}');
                    }, onError: (e) {
                      log('******* ON Sales Line Comment Error Block******** \n ${e.message}');
                    });
                  }
                }
              }
            }
          },
          onError: (e) {
            String reason = '';
            if (e.statusCode == 400) {
              reason = e.message;
              log('status code 400: ${e.statusCode} ${e.message} ');
            } else if (e.statusCode == 500) {
              reason = e.message;
              log('status code 500 ${e.statusCode}: ${e.message}');
            } else {
              log(' Else status code ${e.statusCode}: ${e.message}');
              reason = e.message;
            }

            // failedOrders.add({
            //   'customerNo': selectedCustomer!.no!,
            //   'attendeeName': attendeeName,
            //   'contactNo': contactNo,
            //   'reason': reason,
            // });

            log('**********Error Message: $reason *************');
            isSalesOrderCreating.value = false;
          },
        );
      }
      //  else {
      //   // failedOrders.add({
      //   //   'customerNo': selectedCustomer!.no!,
      //   //   'attendeeName': attendeeName,
      //   //   'contactNo': contactNo,
      //   //   'reason': 'No Sales Lines Provided',
      //   // });
      // }
    }
    // Preferences().setCreatedOrders(createdOrders);
    // Preferences().setFailedOrders(failedOrders);

    isSalesOrderCreating.value = false;
    if (Get.isDialogOpen!) {
      Get.back();
    }
    showCustomDialog();
  }

  // Set Selected Ship to Add
  void setSelectedShipToAdd(int index) {
    String address =
        '${filteredShipToAddress[index].address} ${filteredShipToAddress[index].address2}';
    selectedShipToAddCode = filteredShipToAddress[index].code!;
    log('**** After selecting address from ship to add list ******');
    log('**** Ship to Address: $address');
    log('**** Ship to Code: $selectedShipToAddCode');
  }

  addTliCustomerModel() {
    tliCustomers = Preferences().getCustomerRecords();
    filteredCustomers = tliCustomers!.value;
    isLoading.value = false;
  }

  addTliCustomerByIdModel(response) {
    tliCustomerById = null;
    tliCustomerById = TliCustomers.fromJson(response);
    if (tliCustomerById != null) {
      setCustomerShipToAdd();
      setCustomerContacts();
    }
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
        'name': filteredAttendees[index].name,
        'contactNo': filteredAttendees[index].no,
        'tliSalesLine': customerContactsMap[index]['tliSalesLine']
      });
      log('**** SELECTED attendeeS $selectedAttendees ******');
    } else {
      checkBoxStates[index] = false;

      selectedAttendees.removeWhere((attendee) =>
          attendee['name'] == filteredAttendees[index].name &&
          attendee['contactNo'] == filteredAttendees[index].no &&
          attendee['tliSalesLine'] ==
              customerContactsMap[index]['tliSalesLine']);

      log('**** SELECTED attendeeS $selectedAttendees ******');
    }

    attendeeController.text =
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
    if (barcodeScanRes.isEmpty) {
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
          contentPadding: EdgeInsets.zero,
          titleTextStyle: context.titleLarge.copyWith(
              color: const Color(0xff58595B), fontWeight: FontWeight.w800),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Sizes.HEIGHT_36,
                color: LightTheme.appBarBackgroundColor,
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Notes',
                  style: context.bodySmall.copyWith(
                      fontSize: Sizes.TEXT_SIZE_16,
                      color: const Color(0xff58595B),
                      fontWeight: FontWeight.w700),
                )),
              ),
              const SizedBox(
                height: Sizes.SIZE_4,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
                child: TextField(
                  style: context.titleSmall.copyWith(
                    color: const Color(0xff58595B),
                  ),
                  controller: controller,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffF3F3F3),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffF3F3F3),
                      ),
                    ),
                    hintText: 'Enter your comment here',
                  ),
                  maxLines: 4,
                ),
              ),
            ],
          ),
          actions: <Widget>[
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
                width: Sizes.WIDTH_26,
              ),
              CustomElevatedButton(
                onPressed: onPressed,
                title: 'Save',
                minWidht: Sizes.WIDTH_100,
                minHeight: Sizes.HEIGHT_30,
                backgroundColor: LightTheme.buttonBackgroundColor2,
                borderRadiusCircular: BorderRadius.circular(
                  Sizes.RADIUS_6,
                ),
              ),
            ])
          ],
        );
      },
    );
  }

  void showCustomDialog() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: const Color(0xffFFFFFF),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: Sizes.HEIGHT_34),
                  child: Column(
                    children: [
                      const SizedBox(height: Sizes.HEIGHT_20),
                      Text(
                        AppStrings.SUCCESS,
                        style: Get.textTheme.titleLarge?.copyWith(
                          fontSize: Sizes.TEXT_SIZE_26,
                          color: const Color(0xff7C8691),
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_12),
                      Text(
                        AppStrings.RECORD_SUCCESSFULLY_SAVED,
                        style: Get.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w100,
                          color: const Color(0xff7C7A7A),
                        ),
                      ),
                      const SizedBox(height: Sizes.HEIGHT_14),
                      Container(
                        padding: const EdgeInsets.only(
                          top: Sizes.PADDING_8,
                          bottom: Sizes.PADDING_12,
                          left: Sizes.PADDING_10,
                          right: Sizes.PADDING_10,
                        ),
                        color: const Color(0xffF1F5F8),
                        height: Sizes.HEIGHT_60,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomElevatedButton(
                              onPressed: () {
                                clearCustomerVisitData();
                                Get.back();
                              },
                              title: AppStrings.BACK,
                              minWidht: Sizes.WIDTH_130,
                              minHeight: Sizes.HEIGHT_30,
                              backgroundColor:
                                  LightTheme.buttonBackgroundColor2,
                              borderRadiusCircular:
                                  BorderRadius.circular(Sizes.RADIUS_6),
                            ),
                            const SizedBox(width: Sizes.WIDTH_20),
                            CustomElevatedButton(
                              onPressed: () {
                                clearCustomerVisitData();
                                Get.offNamed(AppRoutes.MAIN_PAGE);
                              },
                              title: AppStrings.HOME,
                              minWidht: Sizes.WIDTH_130,
                              minHeight: Sizes.HEIGHT_30,
                              backgroundColor: const Color(0xff13C39C),
                              borderRadiusCircular:
                                  BorderRadius.circular(Sizes.RADIUS_6),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -Sizes.HEIGHT_34,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xff13C39C),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(Sizes.PADDING_8),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: Sizes.ICON_SIZE_50,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  clearCustomerVisitData() {
    customerTextFieldController.clear();
    addressController.clear();
    shipToAddController.clear();
    attendeeController.clear();
    isAddressFieldVisible.value = false;
    isShipToAddFieldVisible.value = false;
    isAttendeeFieldVisible.value = false;
    selectedAttendees.clear();
    selectedAttendee.value = '';
    customerAddress.value = '';
    selectedShipToAddCode = '';
    attendeeSelectedIndex.value = 0;
    tliShipToAddresses!.clear();
    customerContactsMap.clear();
  }
}
