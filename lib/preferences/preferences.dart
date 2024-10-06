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

  // void setUser(User.Data user) => storage.write("user", user);
  // getUser() => storage.read("user");

  // void setUserRole(String userRole) => storage.write("userRole", userRole);
  // getUserRole() => storage.read("userRole");

  // void setSelectedEnvironmentInfo(Map<String, dynamic> data) =>
  //     storage.write("environment", data);
  // getSelectedEnvironmentInfo() => storage.read("environment");
}
