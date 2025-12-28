class ApiEnvironment {
  static const String development = 'http://localhost:8000/ybai';
  static const String staging = 'https://staging.smarted.ybaisolution.com/ybai';
  static const String production = 'http://smarted.ybaisolution.com/ybai';
}

class ApiConfig {
  // Use production for live server
  static const String baseUrl = ApiEnvironment.production;

  // Authentication
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String logout = '$baseUrl/logout';
  static const String verifyEmail = '$baseUrl/verify-email';
  static const String resendVerification = '$baseUrl/resend-verification';
  static const String authtoken = '$baseUrl/generate-token';

  // Password
  static const String forgotPassword = '$baseUrl/forgot-password';
  static const String resetPassword = '$baseUrl/reset-password';

  // Standards & Subjects
  static const String getAllStandards = '$baseUrl/get-all-standards';
  static const String getSubjectsByStandardId = '$baseUrl/get-subjects-by-standard-id';
  static const String getAllLanguages = '$baseUrl/get-all-languages';

 // ✅ FETCH LIST
   static const String getMyResources = "$baseUrl/get-my-resources"; 
  // ✅ UPDATE
  static const String updateResource = "$baseUrl/update-resource";

  // ✅ UPLOAD
  static const String uploadResource = "$baseUrl/upload-resource";

  static const String filterResources = '$baseUrl/filter-resources-with-search';
  
static const String deleteResources = '$baseUrl/delete-resource';
  

static const String createResourceVector = '$baseUrl/create-resource-vector';

static const String chatResource = '$baseUrl/chat-resource';

  }