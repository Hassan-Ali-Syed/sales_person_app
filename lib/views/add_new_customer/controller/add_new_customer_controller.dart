
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

  TliCustomerPostGrps? tliCustomerPostGrps;
  TliCustomerPriceGrps? tliCustomerPriceGrps;
  TliGenBusPostGrps? tliGenBusPostGrps;
  TliSalesPersons? tliSalesPersons;
  TliTaxAreas? tliTaxAreas;
  TliCountrys? tliCountrys;

  late AddShipToAddressController shipToAddController;
  late ScrollController countryRegionScrollController;
  late TextEditingController countryRegionController;

  @override
  void onInit() async {
    countryRegionScrollController = ScrollController();
    countryRegionController = TextEditingController();
    shipToAddController = Get.find<AddShipToAddressController>();
    await shipToAddController.getTliCountrys();
    log('****** TliCountrys: \n ${shipToAddController.tliCountrys!.toJson()} ');
    await getMultipleQueriesData();
    super.onInit();
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


}
