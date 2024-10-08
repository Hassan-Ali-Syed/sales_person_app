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
import 'package:sales_person_app/views/main_page/api_quries/api_mutate/tlicontact_mutate.dart';
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
  RxList<String> selectedAttendees = <String>[].obs;
  Map<String, dynamic> attendeeItemsMap = {};
  // flag for tracking API process
  var isLoading = false.obs;
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

  // Initialize the list to hold customer data
  List<Map<String, dynamic>> customersData = [];

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

// Reactive variable for Customers
  RxString customerNo = ''.obs;
  RxString customerAddress = ''.obs;

  // Customer's Ship To Address
  List<String> customersShipToAdd = [''].obs;
  List<String> customersContacts = [''].obs;
  List<Widget> attendeeButtons = [];
  String? selectedAttendee;

  //flags for customer text field
  RxBool isCustomerExpanded = false.obs;
  RxBool isCustomerSearch = false.obs;

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
  RxBool barcodeScanned = false.obs;

  //Scroll Controller
  ScrollController customerScrollController = ScrollController();
  ScrollController shipToAddScrollController = ScrollController();
  ScrollController attandeeScrollController = ScrollController();
  ScrollController contactScrollController = ScrollController();

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
        isLoading.value = true;
        log('******* LOADING ********');
      },
      onError: (e) {
        isLoading.value = false;
        log('******* ON ERROR******** \n ${e.message}');
      },
    );
  }

  void setCustomerData(var indexNo) async {
    isAddressFieldVisible.value = false;
    customerAddress.value =
        "${tliCustomers!.value[indexNo].address}  ${tliCustomers!.value[indexNo].address2}";
    addressController = TextEditingController(text: customerAddress.value);
    isAddressFieldVisible.value = true;
    customerNo.value = tliCustomers!.value[indexNo].no!;
    log(customerNo.value);
    await getCustomerbyIdFromGraphQL(customerNo.value);

    shipToAddController = TextEditingController(text: '');
    isShipToAddFieldVisible.value = true;
    setCustomerContacts();
    setCustomerShipToAdd();
  }

  void setCustomerShipToAdd() {
    customersShipToAdd.clear();
    var instanceCustomerShipToAdd = tliCustomerById!.value;
    if (instanceCustomerShipToAdd.isNotEmpty) {
      for (var values in instanceCustomerShipToAdd) {
        var tliShipToAddresses = values.tliShipToAdds;
        for (var element in tliShipToAddresses!) {
          customersShipToAdd.add('${element.address!}.${element.address2!}');
        }
      }
    }
  }

  void setCustomerContacts() {
    customersContacts.clear();
    var instanceCustomer = tliCustomerById!.value;
    if (instanceCustomer.isNotEmpty) {
      for (var values in instanceCustomer) {
        var tliContacts = values.tliContact;
        for (var element in tliContacts!) {
          customersContacts.add('${element.name}');
        }
        checkBoxStates.value =
            List.generate(customersContacts.length, (index) => false);
      }
    }
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
    tliItem = TliItems.fromJson(response);
    log('============After Parse================');
    if (attendeeItemsMap[selectedAttendee!].length == 0) {
      log('============If Block================');
      attendeeItemsMap[selectedAttendee!] = [tliItem!.value.first];
    } else {
      log('============ELSE Block================');
      attendeeItemsMap[selectedAttendee!].add(tliItem!.value.first);
    }
    Preferences().setAttendeesData(attendeeItemsMap);
    log('=============attendee data===${attendeeItemsMap.toString()}==============');
    List item = Preferences().getAttendee(selectedAttendee!);
    log(' =====List of Items :  $item ===========');
    for (var description in item) {
      log("===========${description.description}================");
    }
    isLoading.value = false;
  }

  void onCheckboxChanged(bool? value, int index) {
    checkBoxStates[index] = value!;
    if (value) {
      selectedAttendees.add(customersContacts[index]);
      for (String attendeeName in selectedAttendees) {
        attendeeItemsMap[attendeeName] = '';
      }
    } else {
      selectedAttendees.remove(customersContacts[index]);
      attendeeItemsMap.remove(customersContacts[index]);
    }
    Preferences().setAttendeesData(attendeeItemsMap);
    attandeeController.text = selectedAttendees.join(',');
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
      await getSingleItemFromGraphQL('S10082-002');
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
    String? email,
    String? phoneNo,
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
