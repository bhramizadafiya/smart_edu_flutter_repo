
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import '../controller/uploadresource_controller.dart';

class UploadResourceView extends GetView<UploadResourceController> {
  const UploadResourceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

    
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1), // +1 for divider
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () => Get.back(),
              ),
              title: Obx(() => Text(
                    controller.subjectName.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A4D3C),
                    ),
                  )),
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(Icons.more_vert, color: Colors.black87),
                ),
              ],
            ),

            
            Container(
              height: 0.8,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),

      body: Obx(() => ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 120),
            itemCount: controller.features.length,
            itemBuilder: (context, index) {
              final item = controller.features[index];
              final isLast = index == controller.features.length - 1;

              return Padding(
                padding: EdgeInsets.only(bottom: isLast ? 0 : 30),
                child: _buildFeatureCard(item, index),
              );
            },
          )),
    );
  }

  Widget _buildFeatureCard(FeatureItem item, int index) {
  return Column(
    children: [
   Container(
     decoration: BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.circular(18),
       border: Border.all(color: Colors.grey.shade300, width: 1.4),
     ),
     child: Stack(
       clipBehavior: Clip.none,
       children: [
         Padding(
           padding: const EdgeInsets.only(top: 62, left: 28, right: 28, bottom: 32),
           child: Column(
             children: [
               Text(
                 item.title,
                 textAlign: TextAlign.center,
                 style: const TextStyle(
                   fontSize: 22,
                   fontWeight: FontWeight.w900,
                   color: Color(0xFF0A3D33),
                 ),
               ),
               const SizedBox(height: 20),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: item.tags.map((tag) {
                   return Expanded(
                     child: Container(
                       margin: const EdgeInsets.symmetric(horizontal: 4),
                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                       decoration: BoxDecoration(
                         color: item.lightColor,
                         borderRadius: BorderRadius.circular(20),
                       ),
                       child: FittedBox(
                         fit: BoxFit.scaleDown,
                         child: Text(
                           tag,
                           textAlign: TextAlign.center,
                           style: TextStyle(
                             color: item.color,
                             fontSize: 11.5,
                             fontWeight: FontWeight.w600,
                             height: 1.2,
                           ),
                         ),
                       ),
                     ),
                   );
                 }).toList(),
               ),

               const SizedBox(height: 20),

               Text(
                 item.subtitle,
                 textAlign: TextAlign.center,
                 style: TextStyle(
                   fontSize: 15,
                   height: 1.6,
                   color: Colors.black.withOpacity(0.76),
                 ),
               ),
             ],
           ),
         ),

         // Beautiful Gradient Icon Circle
         Positioned(
           top: -35,
           left: 0,
           right: 0,
           child: Center(
             child: Container(
               width: 75,
               height: 75,
               decoration: BoxDecoration(
                 shape: BoxShape.circle,
                 gradient: LinearGradient(
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                   colors: item.gradientColors, // Uses your 3-color gradient
                 ),
                 
               ),
               child: Icon(
                 item.icon,
                 size: 36,
                 color: Colors.white,
               ),
             ),
           ),
         ),
       ],
     ),
   ),

   const SizedBox(height: 25),

   // Button stays the same (solid color)
   SizedBox(
     height: 50,
     width: 350,
     child: ElevatedButton.icon(
       onPressed: () => controller.onFeatureTap(index),
       icon: Icon(item.buttonIcon, size: 26, color: Colors.white),
       label: Text(
         item.buttonText,
         style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
       ),
       style: ElevatedButton.styleFrom(
         backgroundColor: item.color,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    
       ),
     ),
   ),

   const SizedBox(height: 50),
 ],
  );
}
}