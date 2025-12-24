class ApiEnvironment {
  static const String development = 'http://localhost:8000/ybai';
  static const String staging = 'https://staging.smarted.ybaisolution.com/ybai';
  static const String production = 'http://smarted.ybaisolution.com/ybai';
}

class ApiConfig {
  // Base URL (you can switch environments easily here)
  static const String baseUrl = ApiEnvironment.production;

  // Authentication endpoints
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
  static const String verifyEmail = '$baseUrl/verify-email';
  static const String resendVerification = '$baseUrl/resend-verification';

  static const String authtoken = '$baseUrl/generate-token';

  // Future endpoints for example
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String resetPassword = '$baseUrl/reset-password';

  static const String getAllStandards = '$baseUrl/get-all-standards'; // Added as per your API

  static const String getSubjectsByStandardId = '$baseUrl/get-subjects-by-standard-id';
static const String getAllLanguages = '$baseUrl/get-all-languages';
static const String uploadResource = '$baseUrl/upload-resource';

  // You can also define dynamic URLs like:
  // static String userProfile(String userId) => '$baseUrl/user/$userId';
}
