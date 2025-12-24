// lib/modules/onlinetestinstruction/views/onlinetestinstruction_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/onlinetestinstruction_controller.dart';

class OnlineTestInstructionView extends GetView<OnlineTestInstructionController> {
  const OnlineTestInstructionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: Obx(() => Text(
              controller.pageTitle.value,
              style: const TextStyle(
                color: Color.fromARGB(255, 12, 69, 37),
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            )),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Top Icon + Title
            Center(
  child: Column(
    mainAxisSize: MainAxisSize.min, // Prevents Column from taking full height
    children: [
    Container(
  width: 80,
  height: 80,
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        AppColors.gradientStartBlue,   // Top: Bright dark-blue
        AppColors.gradientMiddleBlue,  // Middle: Rich mid-blue
        AppColors.gradientEndBlue,     // Bottom: Very deep blue
      ],
    ),
  ),
  child: const Icon(
    Icons.computer_rounded,
    size: 50,
    color: Colors.white,
  ),
),
      const SizedBox(height: 16),
      const Text(
        "Online Test Instructions",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: Color.fromARGB(255, 12, 69, 37),
        ),
        textAlign: TextAlign.center, // Ensures title is centered if it wraps
      ),
      const SizedBox(height: 8),
      Obx(() => Text(
            controller.mainInstruction.value,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: Colors.black54, height: 1.5),
          )),
    ],
  ),
),

            const SizedBox(height: 15),

            // Instructions List (No Icons)
            ...controller.instructions.map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: const Color.fromARGB(255, 31, 143, 255),
                        child: Text(
                          item['number']!,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title']!,
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900,color: Color.fromARGB(255, 12, 69, 37)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['desc']!,
                              style: const TextStyle(fontSize: 14, color: Colors.black, height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 17),

            // System Requirements - Blue Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 235, 247, 254),
                border: Border.all(color: const Color.fromARGB(255, 31, 143, 255), width: 1.5),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "System Requirements Check",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 31, 143, 255)),
                  ),
                  const SizedBox(height: 5),
                  ...controller.systemRequirements.map((req) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Row(
                          children: [
                            Icon(
                              req['isGood'] == true ? Icons.check : Icons.warning_amber_rounded,
                              color: req['isGood'] == true ? Color.fromARGB(255, 46, 170, 126) : Color.fromARGB(255, 233, 153, 73),
                              size: 18,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                req['text'],
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: req['isGood'] == true ? Color.fromARGB(255, 46, 170, 126) : const Color.fromARGB(255, 233, 153, 73),
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Important Notice - Red Box with Title
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 249, 250),
                border: Border.all(color: const Color.fromARGB(255, 255, 144, 144), width: 1.5),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 24),
                      const SizedBox(width: 8),
                      Obx(() => Text(
                            controller.importantNoticeTitle.value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.redAccent,
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                        controller.importantNoticeDesc.value,
                        style: const TextStyle(fontSize: 12.5, height: 1.6, fontWeight: FontWeight.w500  ,color: Colors.redAccent),
                      )),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: controller.continueToTest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1976D2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 8,
                ),
                child: Obx(() => Text(
                      controller.continueButtonText.value,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    )),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}