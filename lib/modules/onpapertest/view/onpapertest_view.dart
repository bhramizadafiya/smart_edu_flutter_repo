import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarted/modules/onpapertest/controller/onpapertest_controller.dart';
import 'package:smarted/theme/design_system.dart';

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
          style: TextStyle(color: AppColors.textcolor , fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: PreferredSize(
    preferredSize: const Size.fromHeight(1.2), // Height of the border
    child: Container(
      color: Colors.grey.shade300, // Light grey
      height: 0.5, // Thin border (you can use 1.0 for slightly thicker)
    ),
  ),
      ),
      body: GestureDetector(
        onTap: () {
          // Close keyboard when tapping anywhere outside
          FocusManager.instance.primaryFocus?.unfocus();
        },
        behavior: HitTestBehavior.translucent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive values
          final double horizontalPadding = constraints.maxWidth > 600 ? 40 : 20;
          final double cardHeight = constraints.maxWidth > 600 ? 50 : 44;
          final double iconSize = constraints.maxWidth > 600 ? 18 : 16;
          final double textFontSize = constraints.maxWidth > 600 ? 13 : 12;
          final double paperSizeFont = constraints.maxWidth > 600 ? 14 : 13;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // FULL WIDTH LIGHT GREEN HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 30, horizontalPadding, 40),
                  decoration: const BoxDecoration(color: Color(0xFFF1FDF6)),
                  child: Column(
                    children: [
                      Icon(Icons.description,
                          size: constraints.maxWidth > 600 ? 80 : 70,
                          color: const Color(0xFF2DA67C)),
                      const SizedBox(height: 20),
                      Text(
                        'Customize Your Paper Test',
                        style: TextStyle(
                            fontSize: constraints.maxWidth > 600 ? 28 : 24,
                            fontWeight: FontWeight.w900,
                            color: AppColors.greenColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Upload a custom template or use AI prompts to generate your perfect test paper format',
                        style: TextStyle(
                            fontSize: constraints.maxWidth > 600 ? 16 : 15,
                            color: const Color.fromARGB(255, 22, 107, 86),
                            height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: constraints.maxWidth > 600 ? 30 : 20),

                // MAIN CONTENT
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Custom Template',
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87),
                      ),
                      const SizedBox(height: 10),

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
                              padding: EdgeInsets.fromLTRB(
                                  horizontalPadding, 60, horizontalPadding, 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4)),
                                ],
                              ),
                              child: Column(
                                children: [
                                  const Text('Upload Your Template',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.greenColor)),
                                  const SizedBox(height: 12),
                                  const Text('PDF, DOC, DOCX formats',
                                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                                  const SizedBox(height: 6),
                                  const Text('Max size: 10MB',
                                      style: TextStyle(fontSize: 13, color: Colors.black45)),
                                ],
                              ),
                            ),
                            Positioned(
  top: -5, // Kept the original positioning for overlap effect
  child: Container(
    width: 70,
    height: 70,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF66D1B2), // Light Mint Green
          Color(0xFF3BAA8F), // Medium Teal
          Color(0xFF1C524A), // Dark Teal
        ],
        stops: [0.0, 0.5, 1.0],
      ),
      
    ),
    child: const Icon(
      Icons.upload,
      size: 38,
      color: Colors.white,
    ),
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
                                color: const Color.fromARGB(255, 241, 255, 242),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: AppColors.greenbutton, width: 1),
                                
                              ),
                              child: Row(
  children: [
    // Square Dark Green Background with White Description Icon
    Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: AppColors.greenbutton, // Dark green
        borderRadius: BorderRadius.circular(10), // Rounded square (adjust for more/less roundness)
      ),
      child: const Icon(
        Icons.description,
        color: Colors.white,
        size: 28,
      ),
    ),
    const SizedBox(width: 14),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            controller.uploadedFileName.value,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 4),
          RichText(
  text: TextSpan(
    style: const TextStyle(fontSize: 12), // Base style
    children: [
      const TextSpan(
        text: 'PDF',
        style: TextStyle(
          
          color: Colors.black87, // Bold black for "PDF"
        ),
      ),
      TextSpan(
        text: ' • ${controller.uploadedFileSize.value}    ',
    
        style: const TextStyle(color: Colors.black54),
      ),
      const TextSpan(
        text: 'Uploaded successfully',
        style: TextStyle(
          color: Color(0xFF2DA67C), // Your app's green color
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  ),
),
        ],
      ),
    ),
    IconButton(
      icon: const Icon(Icons.cancel_outlined, color: Colors.red, size: 24),
      onPressed: controller.removeUploadedFile,
    ),
  ],
),
                            )
                          : const SizedBox.shrink()),

                      const SizedBox(height: 15),

                      // Preview Template Card
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
        offset: const Offset(0, 4),
      )
    ],
  ),
  child: TextButton(
    onPressed: () {
      // This line opens the preview screen with the uploaded file
      controller.previewTemplate();
    },
    style: TextButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 32),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.visibility, size: 48, color: Colors.grey.shade600),
        const SizedBox(height: 10),
        Text(
          'Preview Template',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  ),
),

                      const SizedBox(height: 15),

                      // Pre-built Templates
                      const Text('Or choose from pre-built templates:',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(height: 16),
                     // Template Options Row - Aligned to left with right spacing
Padding(
  padding: const EdgeInsets.only(right: 20), // Extra space on the right
  child:// Template Options Row - with 5px space between boxes
Row(
  children: [
    _buildTemplateOption('Standard', Icons.description_outlined),
    const SizedBox(width: 8), // 5px space
    _buildTemplateOption('Grid Layout', Icons.grid_on),
    const SizedBox(width: 8), // 5px space
    _buildTemplateOption('Compact', Icons.format_align_left),
    const Spacer(), // Keeps them left-aligned with space on the right
  ],
),
),

                      const SizedBox(height: 15),
                    ],
                  ),
                ),

                // AI TEST GENERATION SECTION
               Container(
                    width: double.infinity,
                    color: const Color(0xFFF0F8FF),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
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

                        // Custom Prompt Card - Tappable to open keyboard
                        GestureDetector(
                          onTap: () {
                            // Focus the TextField when tapping anywhere on the card
                            FocusScope.of(context).requestFocus(controller.promptFocusNode);
                          },
                          child: Container(
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
                                  focusNode: controller.promptFocusNode, // Important for focus control
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
                                    contentPadding: const EdgeInsets.all(15),
                                  ),
                                  style: const TextStyle(
                                      fontSize: 16, height: 1.6, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Example Prompts
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(8),
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
                                '"Create a 2-column format with OMR-style answer bubbles"',
                                '"Include diagrams space for geometry questions"',
                                '"Add school header template"',
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
                  Container(
                    height: 1.2,
                    color: Colors.blue.shade700,
                    margin: const EdgeInsets.symmetric(horizontal: 0),
                  ),

                Column(
  children: [
    // Paper Settings Section with individual padding and full-width orange border
    Container(
      width: double.infinity,
      color: const Color(0xFFFFF8E8),
      padding: EdgeInsets.fromLTRB(horizontalPadding, 30, horizontalPadding, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Paper Settings',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Paper Size',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => Get.snackbar('Paper Size', 'Selection coming soon'),
                      child: Container(
                        height: 56,
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(color: Colors.grey.shade300, width: 1.2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() => Text(
                                  controller.selectedPaperSize.value,
                                  style: TextStyle(
                                    fontSize: paperSizeFont,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                )),
                            // Icon(
                            //   Icons.keyboard_arrow_down,
                            //   size: 20,
                            //   color: Colors.grey.shade600,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            

           Expanded(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        'Orientation',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
      const SizedBox(height: 15),
      Obx(() => Row(
            children: [
              Flexible( // ← Changed from Expanded to Flexible
                child: _buildOrientationButton(
                  'Portrait',
                  Icons.description,
                  controller.isPortrait.value,
                  () => controller.toggleOrientation(true),
                  cardHeight,
                ),
              ),
              const SizedBox(width: 4),
              Flexible( // ← Changed from Expanded to Flexible
                child: _buildOrientationButton(
                  'Landscape',
                  Icons.mobile_friendly_outlined,
                  !controller.isPortrait.value,
                  () => controller.toggleOrientation(false),
                  cardHeight,
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

          Obx(() => _buildSwitchTile(
                title: 'Include Answer Key',
                subtitle: 'Generate separate answer sheet',
                value: controller.includeAnswerKey.value,
                onChanged: controller.toggleAnswerKey,
              )),

          const SizedBox(height: 40),

          Obx(() => _buildSwitchTile(
                title: 'Add Logo',
                subtitle: 'Custom text or logo',
                value: controller.addLogo.value,
                onChanged: controller.toggleAddLogo,
              )),

          const SizedBox(height: 30),
        ],
      ),
    ),

    // Full-width orange border touching left and right edges
    Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.orange.shade600,
    ),
  ],
),

                // FINAL ACTION BUTTONS
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
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
                            backgroundColor: AppColors.greenbutton,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton.icon(
                          onPressed: controller.previewBeforeGenerate,
                          icon: const Icon(Icons.visibility, color: Colors.blue),
                          label: const Text('Preview Before Generate',
                              style: TextStyle(fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w500)),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 240, 248, 254),
                            side: const BorderSide(color: Colors.blue, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Generated paper will be available for download in PDF and DOC formats',
                        style: TextStyle(fontSize: 14, color: Color.fromARGB(137, 46, 46, 46)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }

  Widget _buildSwitchTile({
  required String title,
  required String subtitle,
  required bool value,
  required Function(bool) onChanged,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0), // 20px left & right padding
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.greenColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.white,
          activeTrackColor: AppColors.greenbutton,       // Light grey when ON (right)
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey.shade400,
          // inactiveTrackColor: AppColors.greenbutton,  // Dark green when OFF (left)
          trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
          trackOutlineWidth: MaterialStateProperty.all(0),
        ),
      ],
    ),
  );
}

  Widget _buildTemplateOption(String label, IconData icon) {
  return Obx(() {
    final isSelected = controller.selectedTemplate.value == label;

    return GestureDetector(
      onTap: () {
        // Toggle: if already selected → unselect, else → select
        if (isSelected) {
          controller.selectTemplate(''); // or null, depending on your controller
        } else {
          controller.selectTemplate(label);
        }
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 11),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.greenbutton : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColors.greenbutton : Colors.grey.shade300,
            width: 1.5,
          ),
          
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 25,
              color: isSelected ? Colors.white : AppColors.greenbutton,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.greenbutton,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  });
}

  Widget _buildOrientationButton(
  String label,
  IconData icon,
  bool isSelected,
  VoidCallback onTap,
  double height,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange.shade600 : Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: isSelected ? Colors.orange.shade600 : Colors.grey.shade300,
          width: isSelected ? 1.5 : 1.5,
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Dynamically reduce font size based on available width
          double fontSize = 14;
          if (constraints.maxWidth < 140) fontSize = 13;
          if (constraints.maxWidth < 110) fontSize = 12;
          if (constraints.maxWidth < 90) fontSize = 11; // Safety for very small screens

          double iconSize = constraints.maxWidth > 120 ? 16 : 14;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black54,
                size: iconSize,
              ),
              const SizedBox(width: 4), // Reduced from 6 to 5
              Flexible( // Wrap text in Flexible to prevent overflow
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );
}

}


class DownloadOptionsModal extends StatelessWidget {
  const DownloadOptionsModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OnTestPaperController>();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const Text(
            'Download Options',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.greenColor,
            ),
          ),
          const SizedBox(height: 20),

          // 2x2 Grid with Proper Card Height
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1, // Perfect height for your design
            children: controller.downloadOptions.map((option) {
              return _buildDownloadCard(option);
            }).toList(),
          ),

          const SizedBox(height: 20),

          // Bottom Text
          const Center(
            child: Text(
              'All files will be downloaded to your device. Print on A4 paper for best results.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDownloadCard(DownloadOption option) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: option.backgroundColor,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(
        color: option.buttonColor,
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Title, Subtitle, Size - Same color as border (individual)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              option.title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: option.buttonColor.withOpacity(0.9),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              option.subtitle,
              style: TextStyle(
                fontSize: 13,
                color: option.buttonColor.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 1),
            Text(
              option.size,
              style: TextStyle(
                fontSize: 13,
                color: option.buttonColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Centered Button - Individual opacity
        Center(
          child: SizedBox(
            height: 36,
            width: 80,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.back();
                option.onTap();
              },
              icon: const Icon(Icons.download, size: 16),
              label: Text(
                option.buttonText,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: option.buttonColor.withOpacity(option.buttonOpacity), // Individual opacity
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}


class DownloadProgressModal extends StatelessWidget {
  final String fileName;
  final double progress; // 0.0 to 1.0
  final String downloadedSize;
  final String totalSize;
  final VoidCallback onCancel;

  const DownloadProgressModal({
    Key? key,
    required this.fileName,
    required this.progress,
    required this.downloadedSize,
    required this.totalSize,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Compact White Card (same as DownloadModal)
        Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Smaller Download Icon (green circle)
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9), // Light green background
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.download, // Changed to match your DownloadModal
                  color: AppColors.greenbutton, // Use your app's green
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),

              // Title - Green color
              Text(
                'Downloading...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.greenbutton,
                ),
              ),
              const SizedBox(height: 16),

              // Progress Bar - Thinner, green
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(AppColors.greenbutton),
                minHeight: 6,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 12),

              // File Name - Left aligned, very close to left edge
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    fileName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Progress Percentage - Centered
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.greenbutton,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),

              // Size Info - Centered
              Text(
                '$downloadedSize MB of $totalSize MB',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Cancel Button - Outside the card (same style)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.black87,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}