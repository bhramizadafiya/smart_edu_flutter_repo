// // // lib/main.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'modules/splash/view/splash_view.dart';
// // import 'modules/splash/binding/splash_binding.dart';
// // import 'modules/login/view/login_view.dart';
// // import 'modules/login/binding/login_binding.dart';
// // import 'modules/userrole/view/userrole_view.dart';
// // import 'modules/userrole/binding/userrole_binding.dart';
// // import 'modules/createaccount/view/createaccount_view.dart';
// // import 'modules/createaccount/binding/createaccount_binding.dart';
// // import 'modules/emailverification/view/emailverification_view.dart';
// // import 'modules/emailverification/binding/emailverification_binding.dart';
// // import 'modules/forgotpassword/view/forgotpassword_view.dart';
// // import 'modules/forgotpassword/binding/forgotpassword_binding.dart';
// // import 'modules/createpassword/view/createpassword_view.dart';
// // import 'modules/createpassword/binding/createpassword_binding.dart';
// // import 'modules/verifyaccount/view/verifyaccount_view.dart';
// // import 'modules/verifyaccount/binding/verifyaccount_binding.dart';
// // import 'modules/dashboard/view/dashboard_view.dart';
// // import 'modules/dashboard/binding/dashboard_binding.dart';
// // import 'modules/subjectselection/view/subjectselection_view.dart';
// // import 'modules/subjectselection/binding/subjectselection_binding.dart';
// // import 'modules/featureselection/view/featureselection_view.dart';
// // import 'modules/featureselection/binding/featureselection_binding.dart';
// // import 'modules/studymateriallist/view/studymateriallist_view.dart';
// // import 'modules/studymateriallist/binding/studymateriallist_binding.dart';
// // import 'modules/chapterlist/view/chapterlist_view.dart';
// // import 'modules/chapterlist/binding/chapterlist_binding.dart';
// // import 'modules/chatscreen/view/chatscreen_view.dart';
// // import 'modules/chatscreen/binding/chatscreen_binding.dart';
// // import 'modules/addchapter/view/addchapter_view.dart';
// // import 'modules/addchapter/binding/addchapter_binding.dart';
// // import 'modules/addstudymaterial/view/addstudymaterial_view.dart';
// // import 'modules/addstudymaterial/binding/addstudymaterial_binding.dart';
// // import 'modules/languageselection/view/languageselection_view.dart ';
// // import 'modules/languageselection/binding/languageselection_binding.dart';
// // import 'modules/chatresourceselection/view/chatresourceselection_view.dart';
// // import 'modules/chatresourceselection/binding/chatresourceselection_binding.dart';

// // void main() {
// //   runApp(
// //     GetMaterialApp(
// //       initialRoute: '/',
// //       getPages: [
// //         GetPage(
// //           name: '/',
// //           page: () => const SplashView(),
// //           binding: SplashBinding(),
// //         ),
// //         GetPage(
// //           name: '/login',
// //           page: () => const LoginView(),
// //           binding: LoginBinding(),
// //         ),
// //         GetPage(
// //           name: '/role-selection',
// //           page: () => const UserRoleView(),
// //           binding: UserRoleBinding(),
// //         ),
// //         GetPage(
// //           name: '/create-account',
// //           page: () => const CreateAccountView(),
// //           binding: CreateAccountBinding(),
// //         ),
// //         GetPage(
// //           name: '/email-verification',
// //           page: () => const EmailVerificationView(),
// //           binding: EmailVerificationBinding(),
// //         ),
// //         GetPage(
// //           name: '/forgot-password',
// //           page: () => const ForgotPasswordView(),
// //           binding: ForgotPasswordBinding(),
// //         ),
// //         GetPage(
// //           name: '/create-password',
// //           page: () => const CreatePasswordView(),
// //           binding: CreatePasswordBinding(),
// //         ),
// //         GetPage(
// //           name: '/verify-account',
// //           page: () => const VerifyAccountView(),
// //           binding: VerifyAccountBinding(),
// //         ),
// //         GetPage(
// //           name: '/dashboard',
// //           page: () => const DashboardView(),
// //           binding: DashboardBinding(),
// //         ),
// //         GetPage(
// //           name: '/subject-selection',
// //           page: () => const SubjectSelectionView(),
// //           binding: SubjectSelectionBinding(),
// //         ),
// //         GetPage(
// //           name: '/feature-selection',
// //           page: () => const FeatureSelectionView(),
// //           binding: FeatureSelectionBinding(),
// //         ),
// //         GetPage(
// //           name: '/study-material-list',
// //           page: () => const StudyMaterialListView(),
// //           binding: StudyMaterialListBinding(),
// //         ),
// //         GetPage(
// //           name: '/add-study-material',
// //           page: () => const AddStudyMaterialView(),
// //           binding: AddStudyMaterialBinding(),
// //         ),
// //         GetPage(
// //           name: '/add-chapter',
// //           page: () => const AddChapterView(),
// //           binding: AddChapterBinding(),
// //         ),
// //         GetPage(
// //           name: '/chapters-list',
// //           page: () => const ChapterListView(),
// //           binding: ChapterListBinding(),
// //         ),
// //         GetPage(
// //           name: '/chatscreen',
// //           page: () => const ChatScreenView(),
// //           binding: ChatScreenBinding(),
// //         ),
// //         GetPage(
// //           name: '/language-selection',
// //           page: () => const LanguageSelectionView(),
// //           binding: LanguageSelectionBinding(),
// //         ),
// //         GetPage(
// //           name: '/chat-resource-selection',
// //           page: () => const ChatResourceSelectionView(),
// //           binding: ChatResourceSelectionBinding(),
// //         ),
// //       ],
// //     ),
// //   );
// // }

// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// import 'modules/splash/view/splash_view.dart';
// import 'modules/splash/binding/splash_binding.dart';
// import 'modules/login/view/login_view.dart';
// import 'modules/login/binding/login_binding.dart';
// import 'modules/userrole/view/userrole_view.dart';
// import 'modules/userrole/binding/userrole_binding.dart';
// import 'modules/createaccount/view/createaccount_view.dart';
// import 'modules/createaccount/binding/createaccount_binding.dart';
// import 'modules/emailverification/view/emailverification_view.dart';
// import 'modules/emailverification/binding/emailverification_binding.dart';
// import 'modules/forgotpassword/view/forgotpassword_view.dart';
// import 'modules/forgotpassword/binding/forgotpassword_binding.dart';
// import 'modules/createpassword/view/createpassword_view.dart';
// import 'modules/createpassword/binding/createpassword_binding.dart';
// import 'modules/verifyaccount/view/verifyaccount_view.dart';
// import 'modules/verifyaccount/binding/verifyaccount_binding.dart';
// import 'modules/dashboard/view/dashboard_view.dart';
// import 'modules/dashboard/binding/dashboard_binding.dart';
// import 'modules/subjectselection/view/subjectselection_view.dart';
// import 'modules/subjectselection/binding/subjectselection_binding.dart';
// import 'modules/featureselection/view/featureselection_view.dart';
// import 'modules/featureselection/binding/featureselection_binding.dart';
// import 'modules/studymateriallist/view/studymateriallist_view.dart';
// import 'modules/studymateriallist/binding/studymateriallist_binding.dart';
// import 'modules/chapterlist/view/chapterlist_view.dart';
// import 'modules/chapterlist/binding/chapterlist_binding.dart';
// import 'modules/chatscreen/view/chatscreen_view.dart';
// import 'modules/chatscreen/binding/chatscreen_binding.dart';
// import 'modules/addchapter/view/addchapter_view.dart';
// import 'modules/addchapter/binding/addchapter_binding.dart';
// import 'modules/addstudymaterial/view/addstudymaterial_view.dart';
// import 'modules/addstudymaterial/binding/addstudymaterial_binding.dart';
// // fixed trailing space in the import below
// import 'modules/languageselection/view/languageselection_view.dart';
// import 'modules/languageselection/binding/languageselection_binding.dart';
// import 'modules/chatresourceselection/view/chatresourceselection_view.dart';
// import 'modules/chatresourceselection/binding/chatresourceselection_binding.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // initialize GetStorage
//   await GetStorage.init();
//   final box = GetStorage();

//   // decide initial route based on stored session (user_id)
//   final String initialRoute =
//       (box.read('user_id') as String?)?.isNotEmpty == true
//       ? '/dashboard'
//       : '/login';

//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: initialRoute,
//       getPages: [
//         GetPage(
//           name: '/',
//           page: () => const SplashView(),
//           binding: SplashBinding(),
//         ),
//         GetPage(
//           name: '/login',
//           page: () => const LoginView(),
//           binding: LoginBinding(),
//         ),
//         GetPage(
//           name: '/role-selection',
//           page: () => const UserRoleView(),
//           binding: UserRoleBinding(),
//         ),
//         GetPage(
//           name: '/create-account',
//           page: () => const CreateAccountView(),
//           binding: CreateAccountBinding(),
//         ),
//         GetPage(
//           name: '/email-verification',
//           page: () => const EmailVerificationView(),
//           binding: EmailVerificationBinding(),
//         ),
//         GetPage(
//           name: '/forgot-password',
//           page: () => const ForgotPasswordView(),
//           binding: ForgotPasswordBinding(),
//         ),
//         GetPage(
//           name: '/create-password',
//           page: () => const CreatePasswordView(),
//           binding: CreatePasswordBinding(),
//         ),
//         GetPage(
//           name: '/verify-account',
//           page: () => const VerifyAccountView(),
//           binding: VerifyAccountBinding(),
//         ),
//         GetPage(
//           name: '/dashboard',
//           page: () => const DashboardView(),
//           binding: DashboardBinding(),
//         ),
//         GetPage(
//           name: '/subject-selection',
//           page: () => const SubjectSelectionView(),
//           binding: SubjectSelectionBinding(),
//         ),
//         GetPage(
//           name: '/feature-selection',
//           page: () => const FeatureSelectionView(),
//           binding: FeatureSelectionBinding(),
//         ),
//         GetPage(
//           name: '/study-material-list',
//           page: () => const StudyMaterialListView(),
//           binding: StudyMaterialListBinding(),
//         ),
//         GetPage(
//           name: '/add-study-material',
//           page: () => const AddStudyMaterialView(),
//           binding: AddStudyMaterialBinding(),
//         ),
//         GetPage(
//           name: '/add-chapter',
//           page: () => const AddChapterView(),
//           binding: AddChapterBinding(),
//         ),
//         GetPage(
//           name: '/chapters-list',
//           page: () => const ChapterListView(),
//           binding: ChapterListBinding(),
//         ),
//         GetPage(
//           name: '/chatscreen',
//           page: () => const ChatScreenView(),
//           binding: ChatScreenBinding(),
//         ),
//         GetPage(
//           name: '/language-selection',
//           page: () => const LanguageSelectionView(),
//           binding: LanguageSelectionBinding(),
//         ),
//         GetPage(
//           name: '/chat-resource-selection',
//           page: () => const ChatResourceSelectionView(),
//           binding: ChatResourceSelectionBinding(),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarted/modules/allstandards/binding/allstandards_binding.dart';
import 'package:smarted/modules/allstandards/view/allstandards_view.dart';
import 'package:smarted/modules/answerkey/binding/answerkey_binding.dart';
import 'package:smarted/modules/answerkey/view/answerkey_view.dart';
import 'package:smarted/modules/morecompetitiveexam/binding/morecompetitiveexam_binding.dart';
import 'package:smarted/modules/morecompetitiveexam/view/morecompetitiveexam_view.dart';
import 'package:smarted/modules/onpapertest/binding/onpapertest_binding.dart';
import 'package:smarted/modules/onpapertest/view/onpapertest_view.dart';
import 'package:smarted/modules/papertestpreview/binding/papertestpreview_binding.dart';
import 'package:smarted/modules/papertestpreview/view/papertestpreview_view.dart';
import 'package:smarted/modules/previewtemplate/binding/previewtemplate_binding.dart';
import 'package:smarted/modules/previewtemplate/view/previewtemplate_view.dart';
import 'package:smarted/modules/testresult/binding/testresult_binding.dart';
import 'package:smarted/modules/testresult/view/testresult_view.dart';
import 'package:smarted/modules/viewsolutions/binding/viewsolutions_binding.dart';
import 'package:smarted/modules/viewsolutions/view/viewsolutions_view.dart';
import 'package:smarted/utils/auth_token_service.dart';

import 'modules/splash/view/splash_view.dart';
import 'modules/splash/binding/splash_binding.dart';
import 'modules/login/view/login_view.dart';
import 'modules/login/binding/login_binding.dart';
import 'modules/userrole/view/userrole_view.dart';
import 'modules/userrole/binding/userrole_binding.dart';
import 'modules/createaccount/view/createaccount_view.dart';
import 'modules/createaccount/binding/createaccount_binding.dart';
import 'modules/emailverification/view/emailverification_view.dart';
import 'modules/emailverification/binding/emailverification_binding.dart';
import 'modules/forgotpassword/view/forgotpassword_view.dart';
import 'modules/forgotpassword/binding/forgotpassword_binding.dart';
import 'modules/createpassword/view/createpassword_view.dart';
import 'modules/createpassword/binding/createpassword_binding.dart';
import 'modules/verifyaccount/view/verifyaccount_view.dart';
import 'modules/verifyaccount/binding/verifyaccount_binding.dart';
import 'modules/dashboard/view/dashboard_view.dart';
import 'modules/dashboard/binding/dashboard_binding.dart';
import 'modules/subjectselection/view/subjectselection_view.dart';
import 'modules/subjectselection/binding/subjectselection_binding.dart';
import 'modules/featureselection/view/featureselection_view.dart';
import 'modules/featureselection/binding/featureselection_binding.dart';
import 'modules/studymateriallist/view/studymateriallist_view.dart';
import 'modules/studymateriallist/binding/studymateriallist_binding.dart';
import 'modules/chapterlist/view/chapterlist_view.dart';
import 'modules/chapterlist/binding/chapterlist_binding.dart';
import 'modules/chatscreen/view/chatscreen_view.dart';
import 'modules/chatscreen/binding/chatscreen_binding.dart';
import 'modules/addchapter/view/addchapter_view.dart';
import 'modules/addchapter/binding/addchapter_binding.dart';
import 'modules/addstudymaterial/view/addstudymaterial_view.dart';
import 'modules/addstudymaterial/binding/addstudymaterial_binding.dart';
import 'package:smarted/modules/mocktest/binding/mocktest_binding.dart';
import 'package:smarted/modules/mocktest/view/mocktest_view.dart';
import 'package:smarted/modules/onlinetest/binding/onlinetest_binding.dart';
import 'package:smarted/modules/onlinetest/view/onlinetest_view.dart';
import 'package:smarted/modules/onlinetestinstruction/binding/onlinetestinstruction_binding.dart';
import 'package:smarted/modules/onlinetestinstruction/view/onlinetestinstruction_view.dart';
import 'package:smarted/modules/onlinetestsummary/binding/onlinetestsummary_binding.dart';
import 'package:smarted/modules/onlinetestsummary/view/onlinetestsummary_view.dart';
import 'package:smarted/modules/testconfiguration/binding/testconfiguration_binding.dart';
import 'package:smarted/modules/testconfiguration/view/testconfiguration_view.dart';
import 'package:smarted/modules/testmode/binding/testmode_binding.dart';
import 'package:smarted/modules/testmode/view/testmode_view.dart';
import 'package:smarted/modules/uploadresource/binding/uploadresource_binding.dart';
import 'package:smarted/modules/uploadresource/view/uploadresource_view.dart';
// fixed trailing space in the import below
import 'modules/languageselection/view/languageselection_view.dart';
import 'modules/languageselection/binding/languageselection_binding.dart';
import 'modules/chatresourceselection/view/chatresourceselection_view.dart';
import 'modules/chatresourceselection/binding/chatresourceselection_binding.dart';
import 'modules/coresubjects/view/coresubjects_view.dart';
import 'modules/coresubjects/binding/coresubjects_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() async => AuthTokenService());

  // create secure storage instance
  const storage = FlutterSecureStorage();

  // decide initial route based on stored session (user_id)
  String initialRoute;
  try {
    final String? storedUserId = await storage.read(key: 'user_id');
    initialRoute = (storedUserId != null && storedUserId.isNotEmpty)
        ? '/dashboard'
        : '/login';
  } catch (e) {
    // if anything goes wrong while reading secure storage, default to login
    initialRoute = '/login';
  }

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashView(),
          binding: SplashBinding(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          name: '/role-selection',
          page: () => const UserRoleView(),
          binding: UserRoleBinding(),
        ),
        GetPage(
          name: '/create-account',
          page: () => const CreateAccountView(),
          binding: CreateAccountBinding(),
        ),
        GetPage(
          name: '/email-verification',
          page: () => const EmailVerificationView(),
          binding: EmailVerificationBinding(),
        ),
        GetPage(
          name: '/forgot-password',
          page: () => const ForgotPasswordView(),
          binding: ForgotPasswordBinding(),
        ),
        GetPage(
          name: '/create-password',
          page: () => const CreatePasswordView(),
          binding: CreatePasswordBinding(),
        ),
        GetPage(
          name: '/verify-account',
          page: () => const VerifyAccountView(),
          binding: VerifyAccountBinding(),
        ),
        GetPage(
          name: '/dashboard',
          page: () => const DashboardView(),
          binding: DashboardBinding(),
        ),
        GetPage(
          name: '/subject-selection',
          page: () => const SubjectSelectionView(),
          binding: SubjectSelectionBinding(),
        ),
        GetPage(
          name: '/feature-selection',
          page: () => const FeatureSelectionView(),
          binding: FeatureSelectionBinding(),
        ),
        GetPage(
          name: '/study-material-list',
          page: () => const StudyMaterialListView(),
          binding: StudyMaterialListBinding(),
        ),
        GetPage(
          name: '/add-study-material',
          page: () => const AddStudyMaterialView(),
          binding: AddStudyMaterialBinding(),
        ),
        GetPage(
          name: '/add-chapter',
          page: () => const AddChapterView(),
          binding: AddChapterBinding(),
        ),
        GetPage(
          name: '/chapters-list',
          page: () => const ChapterListView(),
          binding: ChapterListBinding(),
        ),
        GetPage(
          name: '/chatscreen',
          page: () => const ChatScreenView(),
          binding: ChatScreenBinding(),
        ),
        GetPage(
          name: '/language-selection',
          page: () => const LanguageSelectionView(),
          binding: LanguageSelectionBinding(),
        ),
        GetPage(
          name: '/chat-resource-selection',
          page: () => const ChatResourceSelectionView(),
          binding: ChatResourceSelectionBinding(),
        ),
              GetPage(
          name: '/coresubjects',
          page: () => const CoreSubjectsView(),
          binding: CoreSubjectsBinding(),
        ),
       GetPage(
  name: '/uploadresource',   // ← must match exactly (case-sensitive!)
  page: () => const UploadResourceView(),
  binding: UploadResourceBinding(), // if you use binding
),
    
        GetPage(
          name: '/testeconfiguration',
          page: () => const TestConfigurationView(),
          binding: TestConfigurationBinding(),
        ),
        GetPage(
          name: '/testmode',
          page: () => const TestModeView(),
          binding: TestModeBinding(),
        ),
        GetPage(
          name: '/mocktest',
          page: () => const MockTestView(),
          binding: MockTestBinding(),
        ),
        GetPage(
          name: '/onlinetest',
          page: () => const OnlineTestView(),
          binding: OnlineTestBinding(),
        ),
        GetPage(
          name: '/onlinetestinstruction',
          page: () => const OnlineTestInstructionView(),
          binding: OnlineTestInstructionBinding(),
        ),
        GetPage(
          name: '/onlinetestsummary',
          page: () => const OnlineTestSummaryView(),
          binding: OnlineTestSummaryBinding(),
        ),
        GetPage(
          name: '/testresult',
          page: () => const TestResultView(),
          binding: TestResultBinding(),
        ),
          GetPage(
          name: '/viewsolutions',
          page: () => const ViewSolutionsView(),
          binding: ViewSolutionsBinding(),
        ),
        GetPage(
  name: '/onpapertest',
  page: () => const OnTestPaperView(),
  binding: OnTestPaperBinding(),
),
GetPage(
  name: '/previewtemplate',
  page: () => const PreviewTemplateView(),
  binding: PreviewTemplateBinding(),
),
GetPage(
  name: '/papertestpreview',
  page: () => const PaperTestPreviewView(),
  binding: PaperTestPreviewBinding(),
),
GetPage(
  name: '/answerkey',
  page: () => const AnswerKeyView(),
  binding: AnswerKeyBinding(),
),
// In your routes.dart or main.dart
GetPage(
  name: '/morecompetitiveexam',
  page: () => const MoreCompetitiveExamsView (),
  binding: MoreCompetitiveExamsBinding(),
),
GetPage(
  name: '/allstandards',
  page: () => const AllStandardsView (),
  binding: AllStandardsBinding(),
),

      ],
    ),
  );
}
