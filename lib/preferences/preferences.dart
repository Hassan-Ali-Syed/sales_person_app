import 'package:get_storage/get_storage.dart';

class Preferences {
  final storage = GetStorage();

  // Clear all stored data
  void clearAll() => storage.erase();
  void setDevice(bool isMobile) => storage.write("isMobile", isMobile);
  getDevice() => storage.read("isMobile");

  void setUserId(String userId) => storage.write("userId", userId);
  getUserId() => storage.read("userId");

  void setUserToken(String token) => storage.write("token", token);
  getUserToken() => storage.read("token");
  removeToken() => storage.remove("token");

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
