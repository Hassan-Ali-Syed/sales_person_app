import 'package:get/get.dart';
import 'package:sales_person_app/routes/app_routes.dart';
import 'package:sales_person_app/views/add_attendee/bindings/add_attendee_binding.dart';
import 'package:sales_person_app/views/add_attendee/views/add_attendee_screen.dart';
import 'package:sales_person_app/views/customer_visit/bindings/customer_visit_binding.dart';
import 'package:sales_person_app/views/customer_visit/views/customer_visit_screen.dart';
import 'package:sales_person_app/views/main_page/views/contact_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/customer_page_screen.dart';
import 'package:sales_person_app/views/main_page/views/home_page_screen.dart';
import 'package:sales_person_app/views/main_page/bindings/main_page_binding.dart';
import 'package:sales_person_app/views/main_page/views/main_page.dart';
import 'package:sales_person_app/views/main_page/views/more_page_screen.dart';
import 'package:sales_person_app/views/sign_in/binding/sign_in_binding.dart';
import 'package:sales_person_app/views/sign_in/views/sign_in_screen.dart';
import 'package:sales_person_app/views/sign_up/binding/sign_up_binding.dart';
import 'package:sales_person_app/views/sign_up/views/sign_up_screen.dart';
import 'package:sales_person_app/views/splash_screen/splash_screen.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.SPLASH_SCREEN,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInScreen(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => const SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.MAIN_PAGE,
      page: () => const MainPage(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: AppRoutes.HOME_PAGE,
      page: () => HomePageScreen(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: AppRoutes.CUSTOMER,
      page: () => const CustomerPageScreen(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: AppRoutes.CONTACT_PAGE,
      page: () => const ContactPageScreen(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: AppRoutes.MORE_PAGE,
      page: () => const MorePageScreen(),
      binding: MainPageBinding(),
    ),
    GetPage(
      name: AppRoutes.CUSTOMER_VISIT,
      page: () => CustomerVisitScreen(),
      binding: CustomerVisitBinding(),
    ),
    GetPage(
      name: AppRoutes.ADD_ATTENDEE_PAGE,
      page: () => AddAttendeeScreen(),
      binding: AddAttendeeBinding(),
    ),
  ];
}
