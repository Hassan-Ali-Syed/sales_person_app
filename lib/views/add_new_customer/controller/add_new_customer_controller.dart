import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/queries/api_mutate/create_customer_mutation.dart';
import 'package:sales_person_app/queries/api_quries/multiqueries.dart';
import 'package:sales_person_app/queries/api_quries/tlicountrys_query.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/utils/custom_snackbar.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlicustomerpostgrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlicustomerpricegrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tligenbuspostgrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlitaxareas_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlsalespersons_model.dart';
import 'package:sales_person_app/views/add_ship_to_address/models/tlicountrys_model.dart';
import 'package:sales_person_app/views/main_page/controllers/main_page_controller.dart';

class AddNewCustomerController extends GetxController {
  // GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> addNewCustomerScaffoldKey =
      GlobalKey<ScaffoldState>();

  // UI State Toggles
  final RxBool generalPressed = false.obs;
  final RxBool addressContactPressed = false.obs;
  final RxBool invoicingPressed = false.obs;
  // final RxBool taxButtonPressed = false.obs;

  // Drop-down Expansion Toggles
  final RxBool isSalesPersonCodeExpanded = false.obs;
  final RxBool isCountryRegionExpanded = false.obs;
  final RxBool isTaxAreaCodeExpanded = false.obs;
  final RxBool isGenBusGroupExpanded = false.obs;
  final RxBool isCustomerPostingGroupExpanded = false.obs;
  final RxBool isCustomerPriceGroupExpanded = false.obs;

  // Refresh State Toggles
  final RxBool salesPersonCodeFieldRefresh = false.obs;
  final RxBool countryRegionFieldRefresh = false.obs;
  final RxBool taxAreaCodeFieldRefresh = false.obs;
  final RxBool genBusFieldRefresh = false.obs;
  final RxBool customerPostingFieldRefresh = false.obs;
  final RxBool customerPriceFieldRefresh = false.obs;

  // Selected Values
  final RxString selectedSalesPersonCode = ''.obs;
  final RxString selectedCountryRegionCode = ''.obs;
  final RxString selectedTaxAreaCode = ''.obs;
  final RxString selectedGenBusPostGrpCode = ''.obs;
  final RxString selectedCustomerPostGrpCode = ''.obs;
  final RxString selectedCustomerPriceGrpCode = ''.obs;
  final RxBool taxLiable = false.obs;

  // Scroll Controllers
  late final ScrollController salesPersonCodeScrollController;
  late final ScrollController countryRegionScrollController;
  late final ScrollController taxAreaCodeScrollController;
  late final ScrollController genBusPostingScrollController;
  late final ScrollController customerPostingScrollController;
  late final ScrollController customerPricingScrollController;

  // Text Editing Controllers
  late final TextEditingController nameController;
  late final TextEditingController salesPersonCodeController;
  late final TextEditingController addressController;
  late final TextEditingController address2Controller;
  late final TextEditingController zipCodeController;
  late final TextEditingController cityController;
  late final TextEditingController stateController;
  late final TextEditingController countryRegionController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController emailController;
  late final TextEditingController homePageController;
  late final TextEditingController taxAreaCodeController;
  late final TextEditingController genBusPostingController;
  late final TextEditingController customerPostingController;
  late final TextEditingController customerPricingController;

  // Model Objects for API Responses
  TliCustomerPostGrps? tliCustomerPostGrps;
  TliCustomerPriceGrps? tliCustomerPriceGrps;
  TliGenBusPostGrps? tliGenBusPostGrps;
  TliSalesPersons? tliSalesPersons;
  TliTaxAreas? tliTaxAreas;
  TliCountrys? tliCountrys;

  late MainPageController _mainPageController;

  @override
  void onInit() async {
    super.onInit();
    log('Initialization start....');
    _mainPageController = Get.find<MainPageController>();
    await initializeControllerData();
    log('Initialization end....');
  }

  /// Initializes data and controllers asynchronously
  Future<void> initializeControllerData() async {
    initializeControllers();
    await fetchCountriesData();
    await fetchMultipleQueriesData();
  }

  /// Initializes scroll and text controllers
  void initializeControllers() {
    // Scroll Controllers
    salesPersonCodeScrollController = ScrollController();
    countryRegionScrollController = ScrollController();
    taxAreaCodeScrollController = ScrollController();
    genBusPostingScrollController = ScrollController();
    customerPostingScrollController = ScrollController();
    customerPricingScrollController = ScrollController();

    // Text Editing Controllers
    nameController = TextEditingController();
    salesPersonCodeController = TextEditingController();
    addressController = TextEditingController();
    address2Controller = TextEditingController();
    zipCodeController = TextEditingController();
    cityController = TextEditingController();
    stateController = TextEditingController();
    countryRegionController = TextEditingController();
    phoneNumberController = TextEditingController();
    emailController = TextEditingController();
    homePageController = TextEditingController();
    taxAreaCodeController = TextEditingController();
    genBusPostingController = TextEditingController();
    customerPostingController = TextEditingController();
    customerPricingController = TextEditingController();
  }

  /// Fetches countries data from the API
  Future<void> fetchCountriesData() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliCountrysQuery.tliCountrysQuery(),
      onSuccessGraph: (response) {
        log("******* RESPONSE: *********\n ${response.data}");
        addCountriesData(response.data!['tliCountrys']);
      },
      onError: (e) => log('*** onError *** \n ${e.message}'),
    );
  }

  /// Fetches data for multiple queries from the API
  Future<void> fetchMultipleQueriesData() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: MultiQueries.multiQueries(),
      onLoading: () => log('******* LOADING ********'),
      onSuccessGraph: (response) {
        log('******* On SUCCESS ********\n $response');
        addCustomerPostGroupsData(response.data?['tliCustomerPostGrps']);
        addCustomerPriceGroupsData(response.data?['tliCustomerPriceGrps']);
        addGenBusPostGroupsData(response.data?['tliGenBusPostGrps']);
        addSalesPersonsData(response.data?['tliSalespersons']);
        addTaxAreasData(response.data?['tliTaxAreas']);
      },
      onError: (e) => log('******* ON ERROR******** \n ${e.message}'),
    );
  }

  /// Creates a new customer with the input data
  Future<void> createCustomer() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: CreateCustomerMutation.createCustomerMutation(
        name: nameController.text,
        salespersonCode: selectedSalesPersonCode.value,
        address: addressController.text,
        address2: addressController.text,
        postCode: zipCodeController.text,
        city: cityController.text,
        county: stateController.text,
        countryRegionCode: selectedCountryRegionCode.value,
        phoneNo: phoneNumberController.text,
        eMail: emailController.text,
        homePage: homePageController.text,
        taxLiable: taxLiable.value,
        taxAreaCode: selectedTaxAreaCode.value,
        genBusPostingGroup: selectedGenBusPostGrpCode.value,
        customerPostingGroup: selectedCustomerPostGrpCode.value,
        customerPriceGroup: selectedCustomerPriceGrpCode.value,
      ),
      onLoading: () => log('******* LOADING ********'),
      onSuccessGraph: (response) async {
        log('******* On SUCCESS ********\n $response');
        if (response.data!['createtliCustomer']['success'] &&
            response.data!['createtliCustomer']['status'] == 200) {
          await _mainPageController.getCustomersFromGraphQL();
          Get.offNamed(AppRoutes.CUSTOMER_VISIT);
        } else if (response.data!['createtliCustomer']['status'] == 400) {
          CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error',
            message: '${response.data!['createtliCustomer']['message']}',
            duration: const Duration(seconds: 3),
          );
          log("Error: ${response.data!['createtliCustomer']['message']}");
        }
      },
      onError: (e) => log('******* ON ERROR******** \n ${e.message}'),
    );
  }

  /// Updates the model objects based on API response
  void addSalesPersonsData(dynamic response) {
    tliSalesPersons = TliSalesPersons.fromJson(response);
    log("**** Sales Persons Data: \n ${tliSalesPersons?.toJson()} ");
  }

  void addCountriesData(dynamic response) {
    tliCountrys = TliCountrys.fromJson(response);
    log("**** Countries Data: \n ${tliCountrys?.toJson()} ");
  }

  void addTaxAreasData(dynamic response) {
    tliTaxAreas = TliTaxAreas.fromJson(response);
    log("**** Tax Areas Data: \n ${tliTaxAreas?.toJson()} ");
  }

  void addCustomerPostGroupsData(dynamic response) {
    tliCustomerPostGrps = TliCustomerPostGrps.fromJson(response);
    log("**** Customer Post Groups Data: \n ${tliCustomerPostGrps?.toJson()} ");
  }

  void addCustomerPriceGroupsData(dynamic response) {
    tliCustomerPriceGrps = TliCustomerPriceGrps.fromJson(response);
    log("**** Customer Price Groups Data: \n ${tliCustomerPriceGrps?.toJson()} ");
  }

  void addGenBusPostGroupsData(dynamic response) {
    tliGenBusPostGrps = TliGenBusPostGrps.fromJson(response);
    log("**** Gen. Bus Post Groups Data: \n ${tliGenBusPostGrps?.toJson()} ");
  }

  void toggleGeneral() => generalPressed.value = !generalPressed.value;

  void toggleAddressContact() =>
      addressContactPressed.value = !addressContactPressed.value;

  void toggleInvoicing() => invoicingPressed.value = !invoicingPressed.value;

  // void toggleTaxButton() => taxButtonPressed.value = !taxButtonPressed.value;

  /// Methods for subList OnTap property
  salesPersonCodeOnTap(int index) {
    salesPersonCodeController.text = tliSalesPersons!.value[index].description!;
    selectedSalesPersonCode.value = tliSalesPersons!.value[index].code!;
    log("SalesPersonCode: ${selectedSalesPersonCode.value}");
    isSalesPersonCodeExpanded.value = false;
  }

  countryRegionCodeOnTap(int index) {
    countryRegionController.text = tliCountrys!.value[index].description!;
    selectedCountryRegionCode.value = tliCountrys!.value[index].code!;
    log("countryRegionCodeOnTap: ${selectedCountryRegionCode.value}");

    isCountryRegionExpanded.value = false;
  }

  taxAreaCodeOnTap(int index) {
    taxAreaCodeController.text = tliTaxAreas!.value[index].description!;
    selectedTaxAreaCode.value = tliTaxAreas!.value[index].code!;
    log("taxAreaCodeOnTap: ${selectedTaxAreaCode.value}");

    isTaxAreaCodeExpanded.value = false;
  }

  genBusPostGrpsOnTap(int index) {
    genBusPostingController.text = tliGenBusPostGrps!.value[index].description!;
    selectedGenBusPostGrpCode.value = tliGenBusPostGrps!.value[index].code!;
    log("genBusPostGrpsOnTap: ${selectedGenBusPostGrpCode.value}");

    isGenBusGroupExpanded.value = false;
  }

  customerPostGrpsOnTap(int index) {
    customerPostingController.text =
        tliCustomerPostGrps!.value[index].description!;
    selectedCustomerPostGrpCode.value = tliCustomerPostGrps!.value[index].code!;
    log("customerPostGrpsOnTap: ${selectedCustomerPostGrpCode.value}");
    isCustomerPostingGroupExpanded.value = false;
  }

  customerPriceGrpsOnTap(int index) {
    customerPricingController.text =
        tliCustomerPriceGrps!.value[index].description!;
    selectedCustomerPriceGrpCode.value =
        tliCustomerPriceGrps!.value[index].code!;
    log(" customerPriceGrps: ${selectedCustomerPriceGrpCode.value}");
    isCustomerPriceGroupExpanded.value = false;
  }
}
