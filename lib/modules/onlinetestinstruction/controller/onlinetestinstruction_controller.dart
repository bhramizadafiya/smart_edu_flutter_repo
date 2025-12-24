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
      "desc": "Ensure you're in a quiet place with stable internet connection. The test will run fullscreen to minimize distractions."
    },
    {
      "number": "2",
      "title": "Navigation & Timing",
      "desc": "Use the navigation buttons to jump between questions. Timer shows remaining time and warnings at 30, 15, and 5 minutes."
    },
    {
      "number": "3",
      "title": "Answer Selection",
      "desc": "Click to select answers. You can change your selection any time. Mark questions for review using the bookmark icon."
    },
    {
      "number": "4",
      "title": "Auto-Save & Submit",
      "desc": "Your progress is saved every 30 seconds. Test auto-submits when time expires or you can click Submit."
    },
    {
      "number": "5",
      "title": "Technical Issues",
      "desc": "If you face technical problems, use the help button. Your progress will be restored when you reconnect."
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
      "Once you start the test, you cannot pause or restart it. Switching tabs or app may be flagged. Ensure you have enough time before beginning.".obs;

  final RxString continueButtonText = "Continue to Configuration".obs;

  void continueToTest() {
    Get.toNamed('/online-test'); // Change to your route
  }
}