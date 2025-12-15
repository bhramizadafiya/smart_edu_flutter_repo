import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/createaccount_controller.dart';
import '../../../theme/design_system.dart';
import '../../../utils/custom_text_field.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double verticalPadding = size.height * 0.02;
    final double horizontalPadding = size.width * 0.08;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black87),
        systemOverlayStyle: Theme.of(context).appBarTheme.systemOverlayStyle,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF234C3C)),
          onPressed: () => Get.back(),
        ),
        title: const Text('Register', style: AppTextStyles.maintitle),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  'Create your account',
                  style: AppTextStyles.maintitle,
                ),
              ),
              const SizedBox(height: 30),

              // Full Name
              CustomTextField(
                label: "Full Name",
                hint: "Enter your full name",
                controller: controller.fullNameController,
                validator: controller.validateName,
              ),
              Obx(
                () => controller.nameError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.nameError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 15),

              // Email
              // _buildTextField(
              //   label: "Email",
              //   hint: "Enter your email",
              //   controller: controller.emailController,
              //   validator: controller.validateEmail,
              //   keyboardType: TextInputType.emailAddress,
              // ),
              CustomTextField(
                label: "Email",
                hint: "Enter your email",
                controller: controller.emailController,
                validator: controller.validateEmail,
                keyboardType: TextInputType.emailAddress,
              ),

              Obx(
                () => controller.emailError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.emailError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 15),

              // Password
              Obx(
                () => CustomTextField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: controller.passwordController,
                  validator: controller.validatePassword,
                  obscureText: controller.isPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),

              Obx(
                () => controller.passwordError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.passwordError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 15),

              // Confirm Password
              Obx(
                () => CustomTextField(
                  label: "Confirm Password",
                  hint: "Confirm your password",
                  controller: controller.confirmPasswordController,
                  validator: controller.validateConfirmPassword,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                ),
              ),

              Obx(
                () => controller.confirmPasswordError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.confirmPasswordError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 15),

              // Institute
              CustomTextField(
                label: "Institute",
                hint: "Enter your institute name",
                controller: controller.instituteController,
                validator: controller.validateInstitute,
              ),

              Obx(
                () => controller.instituteError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.instituteError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                label: "Designation",
                hint: "Enter your designation",
                controller: controller.designationController,
                validator: controller.validateDesignation,
              ),
              Obx(
                () => controller.designationError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.designationError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 15),

              // Terms Checkbox
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                      activeColor: Colors.green,
                      value: controller.isTermsAccepted.value,
                      onChanged: (value) =>
                          controller.isTermsAccepted.value = value!,
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                        children: [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms & Privacy Policy',
                            style: TextStyle(
                              color: AppColors.textcolor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Obx(
                () => controller.termsError.value.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 4, left: 4),
                        child: Text(
                          controller.termsError.value,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 20),

              // Send Code Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: AppTextStyles.button,
                  onPressed: controller.sendCode,
                  child: const Text(
                    "Send Code",
                    style: AppTextStyles.userbuttontext,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildTextField({
  //   required String label,
  //   required String hint,
  //   required TextEditingController controller,
  //   required String? Function(String?) validator,
  //   bool obscureText = false,
  //   TextInputType? keyboardType,
  //   Widget? suffixIcon,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         label,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.w600,
  //           color: Colors.black87,
  //         ),
  //       ),
  //       const SizedBox(height: 6),
  //       TextFormField(
  //         controller: controller,
  //         validator: validator,
  //         obscureText: obscureText,
  //         keyboardType: keyboardType,
  //         decoration: InputDecoration(
  //           hintText: hint,
  //           hintStyle: const TextStyle(color: Colors.grey),
  //           suffixIcon: suffixIcon,
  //           focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(8),
  //             borderSide: const BorderSide(
  //               color: AppColors.textcolor,
  //               width: 1.5,
  //             ),
  //           ),
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(8),
  //             borderSide: const BorderSide(color: Colors.grey, width: 0.5),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
