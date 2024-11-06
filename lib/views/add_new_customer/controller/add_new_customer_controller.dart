import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_person_app/queries/api_quries/multiqueries.dart';
import 'package:sales_person_app/services/api/api_constants.dart';
import 'package:sales_person_app/services/api/base_client.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlicustomerpostgrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlicustomerpricegrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tligenbuspostgrps_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlitaxareas_model.dart';
import 'package:sales_person_app/views/add_new_customer/models/tlsalespersons_model.dart';
import 'package:sales_person_app/views/add_ship_to_address/controller/add_ship_to_address_controller.dart';
import 'package:sales_person_app/views/add_ship_to_address/models/tlicountrys_model.dart';

class AddNewCustomerController extends GetxController {
  RxBool generalPressed = false.obs;
  RxBool adressContactPressed = false.obs;
  RxBool invoicingPressed = false.obs;
  RxBool taxButtonPressed = false.obs;

  RxBool isSalesPersonCodeExpanded = false.obs;
  RxBool isCountryRegionExpanded = false.obs;
  RxBool isTaxAreaCodeExpanded = false.obs;
  RxBool isGenBusGroupExpanded = false.obs;
  RxBool isCustomerPostingGroupExpanded = false.obs;
  RxBool isCustomerPriceGroupExpanded = false.obs;

  RxBool salesPersonCodeFieldRefresh = false.obs;
  RxBool countryRegionFieldRefresh = false.obs;
  RxBool isTaxAreaCodeFieldRefresh = false.obs;
  RxBool genBusFieldRefresh = false.obs;
  RxBool customerPostingFieldRefresh = false.obs;
  RxBool customerPriceFieldRefresh = false.obs;

  late ScrollController salesPersonCodeScrollController;
  late ScrollController countryRegionScrollController;
  late ScrollController taxAreaCodeScrollController;
  late ScrollController genBusPostingScrollController;
  late ScrollController customerPostingScrollController;
  late ScrollController customerPricingScrollController;

  TliCustomerPostGrps? tliCustomerPostGrps;
  TliCustomerPriceGrps? tliCustomerPriceGrps;
  TliGenBusPostGrps? tliGenBusPostGrps;
  TliSalesPersons? tliSalesPersons;
  TliTaxAreas? tliTaxAreas;
  TliCountrys? tliCountrys;

  late AddShipToAddressController shipToAddController;

  late TextEditingController nameController;
  late TextEditingController salesPersonCodeController;
  late TextEditingController addressController;
  late TextEditingController address2Controller;
  late TextEditingController zipCodeController;
  late TextEditingController cityController;
  late TextEditingController stateController;
  late TextEditingController countryRegionController;
  late TextEditingController phoneNumberController;
  late TextEditingController emailController;
  late TextEditingController homePageController;
  late TextEditingController taxAreaCodeController;
  late TextEditingController genBusPostingController;
  late TextEditingController customerPostingController;
  late TextEditingController customerPricingController;

  @override
  void onInit() async {
    //initializing Scroll Controllers
    salesPersonCodeScrollController = ScrollController();
    countryRegionScrollController = ScrollController();
    taxAreaCodeScrollController = ScrollController();
    genBusPostingScrollController = ScrollController();
    customerPostingScrollController = ScrollController();
    customerPricingScrollController = ScrollController();

    //initializing TextEditing Controllers
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

    shipToAddController = Get.find<AddShipToAddressController>();
    await shipToAddController.getTliCountrys();
    log('****** TliCountrys: \n ${shipToAddController.tliCountrys!.toJson()} ');
    await getMultipleQueriesData();
    super.onInit();
  }

  Future<void> getMultipleQueriesData() async {
    await BaseClient.safeApiCall(
      ApiConstants.BASE_URL_GRAPHQL,
      RequestType.query,
      headersForGraphQL: await BaseClient.generateHeadersWithTokenForGraphQL(),
      query: MultiQueries.multiQueries(),
      onLoading: () {
        log('******* LOADING ********');
      },
      onSuccessGraph: (response) {
        log('******* On SUCCESS ********\n $response');
        addTliCustomerPostGrps(response.data!['tliCustomerPostGrps']);
        addTliCustomerPriceGrps(response.data!['tliCustomerPriceGrps']);
        addTliGenBusPostGrps(response.data!['tliGenBusPostGrps']);
        addTliSalesPersons(response.data!['tliSalespersons']);
        addTliTaxAreas(response.data!['tliTaxAreas']);
      },
      onError: (e) {
        log('******* ON ERROR******** \n ${e.message}');
      },
    );
  }

  addTliCustomerPostGrps(response) {
    tliCustomerPostGrps = TliCustomerPostGrps.fromJson(response);
    log("**** Get tliCustomerPostGrps \n ${tliCustomerPostGrps!.toJson()} ");
  }

  addTliCustomerPriceGrps(response) {
    tliCustomerPriceGrps = TliCustomerPriceGrps.fromJson(response);
    log("**** Get tliCustomerPriceGrps \n ${tliCustomerPriceGrps!.toJson()} ");
  }

  addTliGenBusPostGrps(response) {
    tliGenBusPostGrps = TliGenBusPostGrps.fromJson(response);
    log("**** Get tliGenBusPostGrps \n ${tliGenBusPostGrps!.toJson()} ");
  }

  addTliSalesPersons(response) {
    tliSalesPersons = TliSalesPersons.fromJson(response);
    log("**** Get tliSalespersons \n ${tliSalesPersons!.toJson()} ");
  }

  addTliTaxAreas(response) {
    tliTaxAreas = TliTaxAreas.fromJson(response);
    log("**** Get tliTaxAreas \n ${tliTaxAreas!.toJson()} ");
  }

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
