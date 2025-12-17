import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onpapertest/controller/onpapertest_controller.dart';

class OnTestPaperView extends GetView<OnTestPaperController> {
  const OnTestPaperView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Configure Paper Test',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // FULL WIDTH LIGHT GREEN HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
              decoration: const BoxDecoration(color: Color(0xFFF1FDF6)),
              child: Column(
                children: [
                  const Icon(Icons.description,
                      size: 70, color: Color(0xFF2DA67C)),
                  const SizedBox(height: 20),
                  const Text(
                    'Customize Your Paper Test',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Upload a custom template or use AI prompts to generate your perfect test paper format',
                    style: TextStyle(
                        fontSize: 15, color: Colors.black54, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // MAIN CONTENT: Custom Template & Pre-built
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Custom Template',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  const SizedBox(height: 20),

                  // Upload Card
                  GestureDetector(
                    onTap: controller.pickAndUploadTemplate,
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 35),
                          padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4)),
                            ],
                          ),
                          child: const Column(
                            children: [
                              Text('Upload Your Template',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87)),
                              SizedBox(height: 12),
                              Text('PDF, DOC, DOCX formats',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black54)),
                              SizedBox(height: 6),
                              Text('Max size: 10MB',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black45)),
                            ],
                          ),
                        ),
                        Positioned(
                          top: -35,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: const BoxDecoration(
                              color: Color(0xFF2DA67C),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    offset: Offset(0, 6))
                              ],
                            ),
                            child: const Icon(Icons.upload,
                                size: 38, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Uploaded File Card
                  Obx(() => controller.isFileUploaded.value
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Colors.green.shade200, width: 1),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.green.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3))
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.description,
                                  color: Color(0xFF2DA67C), size: 28),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(controller.uploadedFileName.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15),
                                        overflow: TextOverflow.ellipsis),
                                    const SizedBox(height: 4),
                                    Text(
                                        'PDF • ${controller.uploadedFileSize.value} • Uploaded successfully',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54)),
                                  ],
                                ),
                              ),
                              IconButton(
                                  icon: const Icon(Icons.close,
                                      color: Colors.red, size: 22),
                                  onPressed: controller.removeUploadedFile),
                            ],
                          ),
                        )
                      : const SizedBox.shrink()),

                  const SizedBox(height: 24),

                  // Preview Template Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F7F7),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 4))
                      ],
                    ),
                    child: TextButton(
                      onPressed: controller.previewTemplate,
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 32),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.visibility,
                              size: 48, color: Colors.grey.shade600),
                          const SizedBox(height: 10),
                          Text('Preview Template',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade700)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  // Pre-built Templates
                  const Text('Or choose from pre-built templates:',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildTemplateOption('Standard', Icons.description_outlined),
                      _buildTemplateOption('Grid Layout', Icons.grid_on),
                      _buildTemplateOption('Compact', Icons.format_align_left),
                    ],
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),

            // AI TEST GENERATION SECTION
            Container(
              width: double.infinity,
              color: const Color(0xFFF0F8FF),
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome,
                          color: Colors.blue.shade600, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        'AI Test Generation',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade700),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Describe how you want your test paper to be formatted and structured',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.blue.shade700),
                  ),
                  const SizedBox(height: 20),

                  // Custom Prompt Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue.shade300, width: 2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Custom Prompt',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue.shade700),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: controller.promptController,
                          maxLines: 10,
                          minLines: 6,
                          decoration: InputDecoration(
                            hintText:
                                'Generate a mathematics test paper with 25 MCQs and 5 short answer questions. Include space for student details at the top, clear instructions, and proper answer sheet format. Use standard CBSE pattern with 3 hours duration.',
                            hintStyle: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.grey.shade300, width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Colors.blue.shade400, width: 2),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                          ),
                          style: const TextStyle(
                              fontSize: 15, height: 1.6, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Example Prompts
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb_outline,
                                color: Colors.orange.shade600, size: 26),
                            const SizedBox(width: 8),
                            Text(
                              'Example Prompts:',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.orange.shade700),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...[
                          'Create a 2-column format with OMR-style answer bubbles',
                          'Include diagrams space for geometry questions',
                          'Add school header template',
                        ].map((prompt) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('→ ',
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Expanded(
                                    child: Text(
                                      prompt,
                                      style: const TextStyle(
                                          fontSize: 14.5,
                                          color: Colors.black87,
                                          height: 1.5),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // PAPER SETTINGS SECTION - EXACTLY LIKE YOUR IMAGE
            Container(
              width: double.infinity,
              color: const Color(0xFFFFF8E8),
              padding: const EdgeInsets.fromLTRB(20, 40, 5, 60),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  const Text(
                    'Paper Settings',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Paper Size & Orientation Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Paper Size
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Paper Size',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                // TODO: Show bottom sheet or dialog with paper size options
                                Get.snackbar('Paper Size', 'Selection coming soon');
                              },
                              child: Container(
                                height: 56,
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.grey.shade300, width: 1.5),
                                ),
                                child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => Text(
                    controller.selectedPaperSize.value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              const SizedBox(height: 1),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.keyboard_arrow_down,
                  size: 20,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Orientation
                      Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Orientation',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
      const SizedBox(height: 12),
      Obx(() => Row(
            children: [
              // Portrait Button
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.toggleOrientation(true),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: controller.isPortrait.value
                          ? Colors.orange.shade600
                          : Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: controller.isPortrait.value
                            ? Colors.orange.shade600
                            : Colors.grey.shade300,
                        width: controller.isPortrait.value ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description,
                          color: controller.isPortrait.value
                              ? Colors.white
                              : Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Portrait',
                          style: TextStyle(
                            color: controller.isPortrait.value
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 5),
              // Landscape Button
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.toggleOrientation(false),
                  child: Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: !controller.isPortrait.value
                          ? Colors.orange.shade600
                          : Colors.white,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(
                        color: !controller.isPortrait.value
                            ? Colors.orange.shade600
                            : Colors.grey.shade300,
                        width: !controller.isPortrait.value ? 1.5 : 1.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mobile_friendly_outlined,
                          color: !controller.isPortrait.value
                              ? Colors.white
                              : Colors.black54,
                          size: 20,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          'Landscape',
                          style: TextStyle(
                            color: !controller.isPortrait.value
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    ],
  ),
),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Include Answer Key
                  Obx(() => _buildSwitchTile(
                        title: 'Include Answer Key',
                        subtitle: 'Generate separate answer sheet',
                        value: controller.includeAnswerKey.value,
                        onChanged: controller.toggleAnswerKey,
                        activeColor: Colors.green.shade600,
                      )),

                  const SizedBox(height: 30),

                  // Add Logo
                  Obx(() => _buildSwitchTile(
                        title: 'Add Logo',
                        subtitle: 'Custom text or logo',
                        value: controller.addLogo.value,
                        onChanged: controller.toggleAddLogo,
                        activeColor: Colors.grey.shade500,
                      )),

                  const SizedBox(height: 50),

                  // Thin bottom border (light blue-gray as in image)
                  Container(
                    height: 1,
                    color: Colors.blue.shade100.withOpacity(0.5),
                  ),
                ],
              ),
            ),

            // FINAL ACTION BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(
                      onPressed: controller.finalizeGeneratePaper,
                      icon: const Icon(Icons.description, size: 28),
                      label: const Text('Generate Test Paper',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 8,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: OutlinedButton.icon(
                      onPressed: controller.previewBeforeGenerate,
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                      label: const Text('Preview Before Generate',
                          style: TextStyle(fontSize: 17, color: Colors.blue, fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Generated paper will be available for download in PDF and DOC formats',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required Color activeColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Colors.black87)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: activeColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }

  Widget _buildTemplateOption(String label, IconData icon) {
    return Expanded(
      child: Obx(() {
        final isSelected = controller.selectedTemplate.value == label;
        return GestureDetector(
          onTap: () => controller.selectTemplate(label),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2DA67C) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: isSelected ? const Color(0xFF2DA67C) : Colors.grey.shade300,
                  width: 1.5),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4))
              ],
            ),
            child: Column(
              children: [
                Icon(icon,
                    size: 36,
                    color: isSelected ? Colors.white : const Color(0xFF2DA67C)),
                const SizedBox(height: 12),
                Text(label,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF2DA67C))),
              ],
            ),
          ),
        );
      }),
    );
  }
}