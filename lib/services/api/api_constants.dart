// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiConstants {
  //COMPANY IDs
  static const String POSH_ID = 'aabdd4f3-a1f4-ec11-82f8-0022483487fb';
  static const String SILK_ID = '0f8bab00-aede-ec11-82f8-0022482fff55';

  // static const String BASE_URL = 'https://bc.rs74.net/';
  // TESTING SERVER
  static const String BASE_URL = 'https://be2.rs74.net/';

  //GRAPHQL
  static const String BASE_URL_GRAPHQL = 'https://be2.rs74.net/graphql';


  static const String BASE_URL_API = '${BASE_URL}api/v1/';

  // AUTHENTICATION API`s
  static const String LOGIN = '${BASE_URL_API}salesRepLogin';

  // AUTHENTICATION WITH MICROSOFT URL
  static const String MICROSOFT_LOGIN = '${BASE_URL}login';
  static const String MICROSOFT_USER_DATA = "${BASE_URL_REST}getUserInfo";

  //LOG OUT API's URL
  static const String LOG_OUT = '${BASE_URL_REST}logout';


  //LOG OUT API's URL
  static const String LOG_OUT = '${BASE_URL_REST}logout';



  //FOR REST API URL (TESTING SERVER)
  static const String BASE_URL_REST = 'https://be2.rs74.net/api/v2/';

  // POSH BASE URL REST
  static const String BASE_URL_POSH = '${BASE_URL_REST}company($POSH_ID)/';

  // CREATE SALES ORDER IN POSH URL
  static const String CREATE_SALES_ORDER =
      '${BASE_URL_POSH}tliCreateSalesOrder';

  // CREATE SALES LINE COMMENT URL IN POSH
  static const String CREATE_SALES_LINES_COMMENT =
      '${BASE_URL_POSH}tliSalesComments';
}
