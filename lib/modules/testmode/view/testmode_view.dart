// views/testmode_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onlinetestinstruction/binding/onlinetestinstruction_binding.dart';
import 'package:smarted/modules/onlinetestinstruction/view/onlinetestinstruction_view.dart';
import 'package:smarted/theme/design_system.dart';
import '../controller/testmode_controller.dart';

class TestModeView extends GetView<TestModeController> {
  const TestModeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TestModeController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Select Test Mode",
          style: TextStyle(color: Color.fromARGB(221, 26, 60, 44), fontWeight: FontWeight.w900, fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: Colors.grey.shade300),
        ),
      ),

      body: Column(
        children: [
          // MAIN CONTENT — SCROLLABLE ONLY WHEN NEEDED
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Smooth scroll
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  // Header
                  Center(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.orange.withOpacity(0.15),
                      child: Icon(Icons.track_changes_outlined, size: 52, color: Colors.orange[700]),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Choose Your Test Format",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color.fromARGB(255, 18, 58, 44)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Select how you want to take your mock test - online with instant feedback or on paper for traditional practice",
                    style: TextStyle(fontSize: 14.5, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  _buildOnlineSection(),
                  const SizedBox(height: 25),
                  _buildPaperSection(),
                  const SizedBox(height: 80), // Final spacing before bottom bar
                ],
              ),
            ),
          ),

          // FIXED BOTTOM SETTINGS BAR (Always visible)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 246, 255, 252),
              border: Border.all(color: const Color(0xFF81C784), width: 1.2),
            ),
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Current Test Settings",
                  style: TextStyle(color: Color(0xFF34BF8E), fontSize: 16, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 10),
                _buildSettingRow(
                  label: "Duration:",
                  value: Obx(() => Text("${controller.duration} minutes",
                      style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF34BF8E)))),
                ),
                const SizedBox(height: 3),
                _buildSettingRow(
                  label: "Difficulty:",
                  value: Obx(() => Text(controller.difficulty.value,
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF34BF8E)))),
                ),
                const SizedBox(height: 3),
                _buildSettingRow(
                  label: "Question Types:",
                  value: Obx(() => Text(controller.questionTypes.value,
                      style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF34BF8E)))),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.settings, size: 20, color: Color(0xFF34BF8E)),
                    label: const Text("Modify Settings", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF34BF8E),
                      side: const BorderSide(color: Color(0xFF34BF8E), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                      backgroundColor: const Color.fromARGB(255, 232, 255, 247),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow({required String label, required Widget value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14.8, color: Colors.black54, fontWeight: FontWeight.w500)),
          Expanded(
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 14.8, color: Colors.black87, fontWeight: FontWeight.w600),
              textAlign: TextAlign.end,
              child: value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineSection() {
    final data = controller.onlineTestData;
    final color = data['color'] as Color;
    final List<dynamic> features = data['features'] ?? [];
    final List<String> pros = (data['pros'] as List?)?.cast<String>() ?? [];
    final List<String> cons = (data['cons'] as List?)?.cast<String>() ?? [];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 1.2),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                 CircleAvatar(
  radius: 32,
  backgroundColor: Colors.transparent,
  child: Container(
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.gradientStartBlue,
          AppColors.gradientMiddleBlue,
          AppColors.gradientEndBlue,
        ],
      ),
    ),
    child: Icon(
      data['icon'] as IconData,
      color: Colors.white,
      size: 38,
    ),
  ),
),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 230, 244, 255), borderRadius: BorderRadius.circular(20)),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.circle, size: 8, color: Colors.blue),
                        SizedBox(width: 6),
                        Text("Interactive", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(data['title'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Color.fromARGB(255, 14, 54, 28))),
              const SizedBox(height: 6),
              Text(data['subtitle'] as String, style: const TextStyle(fontSize: 14.8, color: Colors.black87, height: 1.4)),
              const SizedBox(height: 28),
              ...features.map<Widget>((item) {
                if (item is Map) {
                  final String text = item['text'] ?? "Feature";
                  final IconData icon = (item['icon'] is IconData) ? item['icon'] : Icons.check_circle;
                  final Color iconColor = (item['color'] is Color) ? item['color'] : color;
                  return _buildFeatureRow(text: text, icon: icon, color: iconColor);
                }
                return const SizedBox.shrink();
              }).toList(),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Pros & Consider — Outside Card
        if (pros.isNotEmpty || cons.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (pros.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Pros:", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34BF8E), fontSize: 15.5)),
                        const SizedBox(height: 10),
                        ...pros.map((p) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(children: [
                                const Icon(Icons.check, size: 19, color: Color(0xFF34BF8E)),
                                const SizedBox(width: 10),
                                Expanded(child: Text(p, style: const TextStyle(fontSize: 13.5, height: 1.4))),
                              ]),
                            )),
                      ],
                    ),
                  ),
                if (pros.isNotEmpty && cons.isNotEmpty) const SizedBox(width: 24),
                if (cons.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Consider:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 15.5)),
                        const SizedBox(height: 10),
                        ...cons.map((c) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(children: [
                                const Icon(Icons.info_outline, size: 19, color: Colors.orange),
                                const SizedBox(width: 10),
                                Expanded(child: Text(c, style: const TextStyle(fontSize: 13.5, height: 1.4))),
                              ]),
                            )),
                      ],
                    ),
                  ),
              ],
            ),
          ),

        const SizedBox(height: 15),

        // BEAUTIFUL CENTERED BUTTON (Not full width)
        Center(
  child: SizedBox(
    width: 300,
    height: 58,
    child: ElevatedButton.icon(
      onPressed: () {
        // This will navigate to OnlineTestInstructionView
        Get.to(
          () => const OnlineTestInstructionView(),
          binding: OnlineTestInstructionBinding(),
        );
      },
      icon: const Icon(Icons.play_arrow_rounded, size: 28, color: Colors.white),
      label: Text(
        data['buttonText'] as String,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFeatureRow({required String text, required IconData icon, required Color color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, size: 17, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, height: 1.45))),
        ],
      ),
    );
  }

  Widget _buildPaperSection() {
    final data = controller.paperTestData;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300, width: 1.2),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6))],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: const Color.fromARGB(255, 37, 130, 97),
                    child: Icon(data['icon'] as IconData, color: Colors.white, size: 38),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 231, 255, 247), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.circle, size: 8, color: Color.fromARGB(255, 34, 120, 90)),
                        const SizedBox(width: 6),
                        Text(data['tag'] ?? "Traditional", style: const TextStyle(color: Color.fromARGB(255, 34, 120, 90), fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(data['title'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: const Color.fromARGB(255, 30, 104, 78))),
              const SizedBox(height: 6),
              Text(data['subtitle'] as String, style: const TextStyle(fontSize: 14.8, color: Colors.black87, height: 1.4)),
            ],
          ),
        ),

        const SizedBox(height: 15),

        Center(
          child: SizedBox(
            width: 300,
            height: 58,
            child: ElevatedButton.icon(
              onPressed: controller.generatePaperTest,
              icon: const Icon(Icons.download_rounded, size: 28,color:Colors.white),
              label: Text(data['buttonText'] as String, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 45, 166, 124),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                
              ),
            ),
          ),
        ),
      ],
    );
  }
}