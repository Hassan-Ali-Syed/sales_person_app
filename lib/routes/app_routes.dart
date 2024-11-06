// ignore_for_file: constant_identifier_names

import 'package:sales_person_app/views/add_attendee/views/add_attendee_screen.dart';
import 'package:sales_person_app/views/add_new_customer/views/add_new_customer_screen.dart';
import 'package:sales_person_app/views/add_ship_to_address/views/add_ship_to_address_screen.dart';
import 'package:sales_person_app/views/customer_visit/views/customer_visit_screen.dart';
import 'package:sales_person_app/views/list_items/views/list_items_screen.dart';
import 'package:sales_person_app/views/main_page/views/contact_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/customer_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/home_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/main_page.dart';
import 'package:sales_person_app/views/main_page/views/more_page_screen.dart';
import 'package:sales_person_app/views/sign_in/views/sign_in_screen.dart';
import 'package:sales_person_app/views/sign_up/views/sign_up_screen.dart';
import 'package:sales_person_app/views/splash_screen/splash_screen.dart';

class AppRoutes {
  static const String SPLASH_SCREEN = SplashScreen.routeName;
  static const String SIGN_IN = SignInScreen.routeName;
  static const String SIGN_UP = SignUpScreen.routeName;
  static const String MAIN_PAGE = MainPage.routeName;
  static const String HOME_PAGE = HomePageScreen.routeName;
  static const String CUSTOMER = CustomerPageScreen.routeName;
  static const String CONTACT_PAGE = ContactPageScreen.routeName;
  static const String MORE_PAGE = MorePageScreen.routeName;
  static const String ADD_ATTENDEE_PAGE = AddAttendeeScreen.routeName;
  static const String CUSTOMER_VISIT = CustomerVisitScreen.routeName;
  static const String ADD_SHIP_TO_ADDRESS = AddShipToAddressScreen.routeName;
  static const String ADD_NEW_CUSTOMER = AddNewCustomerScreen.routeName;
  static const String LIST_ITEMS = ListItemsScreen.routeName;
}
