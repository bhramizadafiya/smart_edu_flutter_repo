// lib/modules/onlinetestinstruction/controller/onlinetestinstruction_controller.dart
import 'package:get/get.dart';

class OnlineTestInstructionController extends GetxController {
  // AppBar & Main Title
  final RxString pageTitle = "Online Test Instructions".obs;

  final RxString mainInstruction =
      "Please read the following instructions carefully before starting your online mock test".obs;

  final List<Map<String, String>> instructions = [
    {
      "number": "1",
      "title": "Test Environment",
      "desc": "Ensure you're in a quiet place with stable \ninternet connection. The test will run \nfullscreen to minimize distractions."
    },
    {
      "number": "2",
      "title": "Navigation & Timing",
      "desc": "Use the navigation buttons to jump between \nquestions. Timer shows remaining time and \nwarnings at 30, 15, and 5 minutes."
    },
    {
      "number": "3",
      "title": "Answer Selection",
      "desc": "Click to select answers. You can change \nyour selection any time. Mark questions \nfor review using the bookmark icon."
    },
    {
      "number": "4",
      "title": "Auto-Save & Submit",
      "desc": "Your progress is saved every 30 seconds. \nTest auto-submits when time expires or \nyou can click Submit."
    },
    {
      "number": "5",
      "title": "Technical Issues",
      "desc": "If you face technical problems, use the \nhelp button. Your progress will be restored \nwhen you reconnect."
    },
  ];

  final List<Map<String, dynamic>> systemRequirements = [
    {"text": "Internet Connection: Good", "isGood": true},
    {"text": "Browser Compatibility: Chrome 90+", "isGood": true},
    {"text": "Device Battery: 85%", "isGood": true},
    {"text": "Screen Size: Small (Consider landscape)", "isGood": false},
  ];

  // Important Notice - Now with Title + Description
  final RxString importantNoticeTitle = "Important Notice".obs;
  final RxString importantNoticeDesc =
      "Once you start the test, you cannot pause or restart \nit. Switching tabs or app may be flagged. Ensure \nyou have enough time before beginning.".obs;

  final RxString continueButtonText = "Continue to Configuration".obs;

  void continueToTest() {
    Get.toNamed('/online-test'); // Change to your route
  }
}