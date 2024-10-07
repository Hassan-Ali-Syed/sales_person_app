// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiConstants {
  //Company Ids
  static const String POSH_ID = 'aabdd4f3-a1f4-ec11-82f8-0022483487fb';
  static const String SILK_ID = '0f8bab00-aede-ec11-82f8-0022482fff55';

  static const String BASE_URL = 'https://bc.rs74.net/'; // TESTING SERVER
  // static const String BASE_URL = 'https://bcmobile.rs74.net/'; // PRODUCTION
  static const String BASE_URL_GRAPHQL =
      'https://be2.rs74.net/graphql'; //GRAPHQL
  static const String BASE_URL_API =
      '${BASE_URL}api/v1/'; // RESTFUL API's PRODUCTION

  // AUTHENTICATION API`s
  static const String LOGIN = '${BASE_URL_API}salesRepLogin';
  static const String MICROSOFT_LOGIN = '${BASE_URL}login';

  static const String BASE_URL_REST =
      'https://be2.rs74.net/api/v2/'; //TESTING SERVER
  static const String LOG_OUT = '${BASE_URL_REST}logout';
}
