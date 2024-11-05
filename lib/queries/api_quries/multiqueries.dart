import 'package:sales_person_app/queries/api_quries/tlicustomerpostgrpsquery.dart';
import 'package:sales_person_app/queries/api_quries/tlicustomerpricegrpsquery.dart';
import 'package:sales_person_app/queries/api_quries/tligenbuspostgrpsquery.dart';
import 'package:sales_person_app/queries/api_quries/tlisalespersonsquery.dart';
import 'package:sales_person_app/queries/api_quries/tlitaxareasquery.dart';

class MultiQueries {
  static String multiQueries() {
    return """ query MultiQueries {
      ${TliCustomerPostGrpsQuery.tliCustomerPostGrpsQuery()}
      ${TliCustomerPriceGrpsQuery.tliCustomerPriceGrpsQuery()}
      ${TliGenBusPostGrpsQuery.tliGenBusPostGrpsQuery()}
      ${TliSalesPersonsQuery.tliSalesPersonsQuery()}
      ${TliTaxAreasQuery.tliTaxAreasQuery()}
    }""";
  }
}
