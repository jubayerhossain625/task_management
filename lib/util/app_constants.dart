import 'package:intl/intl.dart';
class AppConstants {
  static const String appName = '';
  static const double appVersion = 1.0; ///Flutter sdk 3.24.3
  /// core URL
  static const String baseUrl = 'http://206.189.138.45:8052';
/// Auth URL
  static const String configUri = '';
  static const String registerUri = '/user/profile';
  static const String activateUserUri = '/user/activate-user';
  static const String loginUri = '/user/login';
  static const String updateProfileUri = '/user/update-profile';
  static const String getMyProfileUri = '/user/my-profile';

 /// Task Managements URL
  static const String createTaskUri = '/task/create-task';
  static const String getTaskUri = '/task/get-task';  /// by id
  static const String deleteTaskUri = '/task/delete-task'; /// by id
  static const String getAllTaskUri = '/task/get-all-task';



  /// Shared Key
  static const String theme = 'theme';
  static const String token = 'user_token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';

  /// Status
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String accepted = 'accepted';

  /// time formatter
  String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      // Parse the date string into a DateTime object
      final DateTime parsedDate = DateTime.parse(date);

      // Format the DateTime object
      return DateFormat('hh:mm a MMMM d, yyyy').format(parsedDate);
    } catch (e) {
      // Handle any errors in parsing/formatting
      return date;
    }
  }

}
