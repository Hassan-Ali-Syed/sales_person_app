import 'package:get_storage/get_storage.dart';
import 'package:sales_person_app/views/main_page/models/tlicustomers_model.dart';
import 'package:sales_person_app/views/sign_in/models/sign_in_model.dart'
    as user;

class Preferences {
  final storage = GetStorage();

  // Clear all stored data
  void clearAll() => storage.erase();
  void setDevice(bool isMobile) => storage.write("isMobile", isMobile);
  getDevice() => storage.read("isMobile");

  void setUserId(String userId) => storage.write("userId", userId);
  getUserId() => storage.read("userId");
  void setUser(user.Data user) => storage.write("user", user);
  getUser() => storage.read("user");

  Future<void> setUserToken(String token) => storage.write("token", token);
  getUserToken() => storage.read("token");
  removeToken() => storage.remove("token");

  // Store created orders in cache
  void setCreatedOrders(List<Map<String, dynamic>> createdOrders) =>
      storage.write('createdOrders', createdOrders);
  getCreatedOrders() => storage.read('createdOrders');

  // Store Selected Customer Data
  void setSelectedCustomerData(Map<String, dynamic> selectedCustomerData) =>
      storage.write('selectedCustomerData', selectedCustomerData);
  getSelectedCustomerData() => storage.read('selectedCustomerData');

  // Store Customers Record in cache
  void setCustomerRecords(TliCustomers? customerRecords) =>
      storage.write('customerRecords', customerRecords);

  getCustomerRecords() => storage.read('customerRecords');

  // Store Failed Orders in cache
  void setFailedOrders(List<Map<String, dynamic>> failedOrders) =>
      storage.write('failedOrders', failedOrders);

  getFailedOrders() => storage.read('failedOrders');

  clearOrdersCache() async {
    await storage.remove('createdOrders');
    await storage.remove('failedOrders');
  }

  // Set the attendees data as a list of maps
  // void setAttendeesData(List<Map<String, dynamic>> attendeesList) {
  //   storage.write("attendeesData", attendeesList);
  // }

  // // Get the attendees data as a list of maps
  // List<Map<String, dynamic>> getAttendeesData() {
  //   return storage.read("attendeesData") ??
  //       []; // Return an empty list if no data found
  // }

  // // Get a specific attendee by name
  // Map<String, dynamic>? getAttendee(String name) {
  //   List<Map<String, dynamic>> attendees = getAttendeesData();
  //   return attendees.firstWhere(
  //     (attendee) => attendee['name'] == name,
  //     // Return null if attendee not found
  //   );
  // }

  // // Add a new attendee
  // void addAttendee(Map<String, dynamic> newAttendee) {
  //   List<Map<String, dynamic>> attendees = getAttendeesData();
  //   attendees.add(newAttendee); // Add new attendee to the list
  //   setAttendeesData(attendees); // Save updated list back to storage
  // }

  // // Remove a specific attendee by name
  // void removeAttendee(String name) {
  //   List<Map<String, dynamic>> attendees = getAttendeesData();
  //   attendees.removeWhere((attendee) => attendee['name'] == name); // Remove attendee
  //   setAttendeesData(attendees); // Save updated list back to storage
  // }

//   // Update an existing attendee
//   void updateAttendee(String name, Map<String, dynamic> updatedAttendee) {
//     List<Map<String, dynamic>> attendees = getAttendeesData();
//     int index = attendees.indexWhere((attendee) => attendee['name'] == name);
//     if (index != -1) {
//       attendees[index] = updatedAttendee; // Update the attendee
//       setAttendeesData(attendees); // Save updated list back to storage
//     }
//   }
// }

// ================OlD METHODS===============

  void setAttendeesData(Map<String, dynamic> attendeesList) =>
      storage.write("attendeesData", attendeesList);
  getAttendeesData() => storage.read("attendeesData");
  getAttendee(String name) => storage.read("attendeesData")[name];

  // void setUserRole(String userRole) => storage.write("userRole", userRole);
  // getUserRole() => storage.read("userRole");

  // void setSelectedEnvironmentInfo(Map<String, dynamic> data) =>
  //     storage.write("environment", data);
  // getSelectedEnvironmentInfo() => storage.read("environment");
}
