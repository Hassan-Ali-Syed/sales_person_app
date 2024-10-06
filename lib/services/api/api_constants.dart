// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiConstants {
  //Company Ids
  static const String POSH_ID = 'aabdd4f3-a1f4-ec11-82f8-0022483487fb';
  static const String SILK_ID = '0f8bab00-aede-ec11-82f8-0022482fff55';

  // static const String BASE_URL_LOCAL = 'https://bc.rs74.net/api/v2/';
  static const String BASE_URL = 'https://bc.rs74.net/'; // TESTING SERVER

  // static const String BASE_URL = 'https://bcmobile.rs74.net/'; // PRODUCTION

  static const String MICROSOFT_LOGIN = '${BASE_URL}login';
  static const String BASE_URL_GRAPHQL = 'https://be2.rs74.net/graphql';

  static const String BASE_URL_API = '${BASE_URL}api/v1/';

  // AUTHENTICATION API`s
  static String LOGIN = '${BASE_URL_API}salesRepLogin';

  //static const String BASE_URL = 'https://bcmobile.rs74.net/'; // PRODUCTION

  // static const String BASE_URL =
  //     'https://bcmobile.rs74.net/api/v1/'; // PRODUCTION
  // static const String MICROSOFT_LOGIN =
  //     'https://bcmobile.rs74.net/login'; // PRODUCTION SERVER

  static const String MICROSOFT_USER_DATA = "${BASE_URL_API}getUserInfo";

  // COMPANY API`s
  static String GET_COMPANY = '${BASE_URL_API}getCompany';

  // SEARCH RESULT
  static String USER_SEARCH = '${BASE_URL_API}searchUserName';

  // STORAGE
  static const String BASE_URL_FOR_FILE = '${BASE_URL}public/storage/';

  // SALES ORDER API`s
  static String GET_PROCESSED_DATA = '${BASE_URL_API}getProcessedMBData';
  static String GET_SALES_ORDER = '${BASE_URL_API}getSalesOrder';

  static String GET_SALES_ORDER_DETAILS = '${BASE_URL_API}getSalesOrderDetails';
  static String UPLOAD_CSV_MB = '${BASE_URL_API}uploadCSV';
  static String DELETE_MB_RECORD = '${BASE_URL_API}deleteCompanyOrder';
  static String ASSIGN_TO = '${BASE_URL_API}updateSalesOrder';
  static String GET_CONTACT_NO = '${BASE_URL_API}getContactNos';
  static String GET_SALES_HEADER_COMMENTS =
      '${BASE_URL_API}getSalesHeaderComments';
  static String UPDATE_SALES_HEADER_COMMENTS =
      '${BASE_URL_API}updateSalesHeaderComment';
  static String GET_SALES_LINE_COMMENTS = '${BASE_URL_API}getSalesLineComments';
  static String UPDATE_SALES_LINE_COMMENTS =
      '${BASE_URL_API}updateSalesLineComment';
  static String GET_HEADER_STANDARD_COMMENTS =
      '${BASE_URL_API}getHeaderAndStandardComments';
  static String UPDATE_STANDARD_COMMENTS =
      '${BASE_URL_API}updateStandardComments';
  static String POST_SALES_ORDER = '${BASE_URL_API}postSalesInvoice';

  //WAREHOUSE SHIPMENT
  static String CREATE_WH_SHIPMENTS = '${BASE_URL_API}createWhseShipments';
  static String GET_WH_SHIPMENT_LINES = '${BASE_URL_API}getWhseShipLineList';
  static String GET_WH_SHIPMENT_DETAILS =
      '${BASE_URL_API}getWhseShipmentLineDetails';
  static String POST_SHIPMENT = '${BASE_URL_API}postSalesShipment';

  //PICKING
  static String CREATE_WH_PICKING = '${BASE_URL_API}createWhsePick';
  static String GET_WH_PICK_LINES_DETAILS =
      '${BASE_URL_API}getWhsePickLineDetails';
  static String GET_WH_PICK_LINES = '${BASE_URL_API}getWhsePickLines';
  static String GET_WH_PICK_ITEM_LIST = '${BASE_URL_API}getPickItemBinList';
  static String GET_WH_PICK_ITEM_INVENTORY_LIST =
      '${BASE_URL_API}getPickItemInventoryList';
  static String UPDATE_PICK_DETAILS = '${BASE_URL_API}updatePickDetails';
  static String REGISTER_PICK = '${BASE_URL_API}registerPick';

  //PACKING
  static String REGISTER_PACKING = '${BASE_URL_API}createPacking';
  static String GET_PACKING_TEST = '${BASE_URL_API}getPackingDetailsTest';
  static String GET_PREVIEW_PACKING_INFO = '${BASE_URL_API}previewPackingInfo';
  static String CREATE_PACKING_LINE_AND_BOX =
      '${BASE_URL_API}createPackingLineAndBox';
  static String DELETE_BOX = '${BASE_URL_API}removePackingLineAndBox';
  static String DELETE_BOX_ITEM = '${BASE_URL_API}removePickItemFromBox';
  static String UPDATE_BOX_DIMENSION = '${BASE_URL_API}updatePackingLines';
  static String GET_PACKING_LABEL = '${BASE_URL_API}whseShipToZpl';
  static String GET_PICK_ITEM_LIST = '${BASE_URL_API}getRegPickItemsList';
  static String PACK_ITEM_ALLOCATION = '${BASE_URL_API}packingLineItemAlloc';

  static String GET_PACKING = '${BASE_URL_API}getPackingDetails';
  static String DELETE_PACKING = '${BASE_URL_API}deletePackingDetails';
  static String GET_BOX_CODE_DIMENSIONS = '${BASE_URL_API}getBoxCodeDimensions';

  //SHIPPING NEW DETAILS
  static String GET_SHIPPING_DETAILS = '${BASE_URL_API}getShippingDetails';
  static String SHIPPING_ADDRESS_VALIDATE =
      '${BASE_URL_API}shippingAddressValidate';
  static String CREATE_SHIPMENT = '${BASE_URL_API}createShipment';
  static String RATE_QUOTE = '${BASE_URL_API}shippingQoutingRate';
  static String GET_SHIPPING_SERVICES = '${BASE_URL_API}getShippingServiceType';
  static String UPDATE_VALIDATED_ADDRESS =
      '${BASE_URL_API}updateValidatedAddress';

  static String GET_MATCH_DATA = '${BASE_URL_API}getMatchData';
  static String GET_CUSTOMER_DATA = '${BASE_URL_API}fetchCustomer';
  static String GET_CONTACT_DATA = '${BASE_URL_API}fetchContact';
  static String POST_CUSTOMER = '${BASE_URL_API}storeCustomer';
  static String POST_CONTACT = '${BASE_URL_API}storeBcContact';
  static String GET_CUSTOMER_OPTIONS = '${BASE_URL_API}getCustomerOptions';
  static String CREATE_SALES_ORDER = '${BASE_URL_API}createSalesOrder';

  static String GET_ITEM_DESCRIPTION = '${BASE_URL_API}getItemDescList';
  static String GET_CUSTOMER = '${BASE_URL_API}getCustomerList';
  static String GET_SHIP_TO = '${BASE_URL_API}getShipToList';
  static String GET_SHIPPING_AGENT_CODE = '${BASE_URL_API}getShippingAgentCode';
  static String GET_SHIPPING_AGENT_SERVICE_CODE =
      '${BASE_URL_API}getShippingAgentServiceCode';
  static String GET_SHIPMENT_METHOD = '${BASE_URL_API}getShipmentMethod';
  static String GET_SHIP_TO_DETAILS = '${BASE_URL_API}getShiptoDetails';
  static String GET_LABELS = '${BASE_URL_API}getShippingLabels';

  //SHIPPING
  static String SEARCH_SALES_ORDER = '${BASE_URL_API}searchSalesOrder';
  static String VALIDATE_ADDRESS = '${BASE_URL_API}UpsAddressValidation/1';
  static String UPS_CREATE_SHIPMENT = '${BASE_URL_API}UpsCreateShipment';

  // INVENTORY MANAGEMENTS API`S
  static String GET_STOCK_DETAILS = '${BASE_URL_API}getStockDetails';

  //WAREHOUSE PICKING API
  static String GET_ITEM_INVENTORY = '${BASE_URL_API}getItemInventory';
  static String GET_ITEM_INVENTORY_BY_DESC =
      '${BASE_URL_API}getItemInvByItemDesc';
}
