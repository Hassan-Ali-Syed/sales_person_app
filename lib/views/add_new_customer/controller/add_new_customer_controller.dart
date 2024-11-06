import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/queries/api_quries/multiqueries.dart';
import 'package:sales_person_app/queries/api_quries/tlicountrys_query.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlicustomerpostgrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlicustomerpricegrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tligenbuspostgrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlitaxareas_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlsalespersons_model.dart';
import 'package:sales_person_app/views/add_ship_to_address/models/tlicountrys_model.dart';

class AddNewCustomerController extends GetxController {
  // Add a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> addNewCustomerScaffoldKey =
      GlobalKey<ScaffoldState>();

  // UI State Toggles
  final RxBool generalPressed = false.obs;
  final RxBool addressContactPressed = false.obs;
  final RxBool invoicingPressed = false.obs;
  final RxBool taxButtonPressed = false.obs;

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

  final RxString selectedSalesPersonCode = ''.obs;
  final RxString selectedCountryRegionCode = ''.obs;
  final RxString selectedTaxAreaCode = ''.obs;
  final RxString selectedGenBusPostGrpCode = ''.obs;
  final RxString selectedCustomerPostGrpCode = ''.obs;
  final RxString selectedCustomerPriceGrpCode = ''.obs;

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

  // // Dependency Injection for Ship To Address Controller
  // late final AddShipToAddressController shipToAddController;

  @override
  void onInit() async {
    super.onInit();
    log('Initialization start....');
    await initializeControllerData();
    log('Initialization end....');
  }

  /// Initializes data and controllers asynchronously
  Future<void> initializeControllerData() async {
    initializeControllers();
    await getTliCountrys();
    await getMultipleQueriesData();
  }

  /// Initializes scroll and text controllers
  void initializeControllers() {
    // Initializing Scroll Controllers
    salesPersonCodeScrollController = ScrollController();
    countryRegionScrollController = ScrollController();
    taxAreaCodeScrollController = ScrollController();
    genBusPostingScrollController = ScrollController();
    customerPostingScrollController = ScrollController();
    customerPricingScrollController = ScrollController();

    // Initializing TextEditing Controllers
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

  Future<void> getTliCountrys() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: TliCountrysQuery.tliCountrysQuery(),
      onSuccessGraph: (response) {
        log("******* RESPONSE: *********\n ${response.data}");
        addTliCountrys(response.data!['tliCountrys']);
      },
      onError: (e) {
        log('*** onError *** \n ${e.message}');
      },
    );
  }

  /// Fetches multiple queries data from the API
  Future<void> getMultipleQueriesData() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: MultiQueries.multiQueries(),
      onLoading: () => log('******* LOADING ********'),
      onSuccessGraph: (response) {
        log('******* On SUCCESS ********\n $response');
        addTliCustomerPostGrps(response.data?['tliCustomerPostGrps']);
        addTliCustomerPriceGrps(response.data?['tliCustomerPriceGrps']);
        addTliGenBusPostGrps(response.data?['tliGenBusPostGrps']);
        addTliSalesPersons(response.data?['tliSalespersons']);
        addTliTaxAreas(response.data?['tliTaxAreas']);
      },
      onError: (e) => log('******* ON ERROR******** \n ${e.message}'),
    );
  }

  void addTliSalesPersons(dynamic response) {
    tliSalesPersons = TliSalesPersons.fromJson(response);
    log("**** Get tliSalespersons \n ${tliSalesPersons?.toJson()} ");
  }

  void addTliCountrys(response) {
    tliCountrys = TliCountrys.fromJson(response);
    log("**** Get tliTaxAreas \n ${tliCountrys?.toJson()} ");
  }

  void addTliTaxAreas(dynamic response) {
    tliTaxAreas = TliTaxAreas.fromJson(response);
    log("**** Get tliTaxAreas \n ${tliTaxAreas?.toJson()} ");
  }

  void addTliCustomerPostGrps(dynamic response) {
    tliCustomerPostGrps = TliCustomerPostGrps.fromJson(response);
    log("**** Get tliCustomerPostGrps \n ${tliCustomerPostGrps?.toJson()} ");
  }

  void addTliCustomerPriceGrps(dynamic response) {
    tliCustomerPriceGrps = TliCustomerPriceGrps.fromJson(response);
    log("**** Get tliCustomerPriceGrps \n ${tliCustomerPriceGrps?.toJson()} ");
  }

  void addTliGenBusPostGrps(dynamic response) {
    tliGenBusPostGrps = TliGenBusPostGrps.fromJson(response);
    log("**** Get tliGenBusPostGrps \n ${tliGenBusPostGrps?.toJson()} ");
  }

  void toggleGeneral() => generalPressed.value = !generalPressed.value;

  void toggleAddressContact() =>
      addressContactPressed.value = !addressContactPressed.value;

  void toggleInvoicing() => invoicingPressed.value = !invoicingPressed.value;

  void toggleTaxButton() => taxButtonPressed.value = !taxButtonPressed.value;

  /// Methods for subList OnTap property
  salesPersonCodeOnTap(int index) {
    salesPersonCodeController.text = tliSalesPersons!.value[index].description!;
    selectedSalesPersonCode.value = tliSalesPersons!.value[index].code!;
    isSalesPersonCodeExpanded.value = false;
  }

  countryRegionCodeOnTap(int index) {
    countryRegionController.text = tliCountrys!.value[index].description!;
    selectedCountryRegionCode.value = tliCountrys!.value[index].code!;
    isCountryRegionExpanded.value = false;
  }

  taxAreaCodeOnTap(int index) {
    taxAreaCodeController.text = tliTaxAreas!.value[index].description!;
    selectedTaxAreaCode.value = tliTaxAreas!.value[index].code!;
    isTaxAreaCodeExpanded.value = false;
  }

  genBusPostGrpsOnTap(int index) {
    genBusPostingController.text = tliGenBusPostGrps!.value[index].description!;
    selectedGenBusPostGrpCode.value = tliGenBusPostGrps!.value[index].code!;
    isGenBusGroupExpanded.value = false;
  }

  customerPostGrpsOnTap(int index) {
    customerPostingController.text =
        tliCustomerPostGrps!.value[index].description!;
    selectedCustomerPostGrpCode.value = tliCustomerPostGrps!.value[index].code!;
    isCustomerPostingGroupExpanded.value = false;
  }

  customerPriceGrpsOnTap(int index) {
    customerPricingController.text =
        tliCustomerPriceGrps!.value[index].description!;
    selectedCustomerPriceGrpCode.value =
        tliCustomerPriceGrps!.value[index].code!;
    isCustomerPriceGroupExpanded.value = false;
  }
}
