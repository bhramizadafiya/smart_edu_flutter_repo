import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/design_system.dart';

class CustomDrawer extends StatelessWidget {
  final String name;
  final String role;
  final String email;
  final VoidCallback? onEditProfile;
  final VoidCallback? onLogout;

  const CustomDrawer({
    super.key,
    this.name = 'John Doe',
    this.role = 'Student',
    this.email = 'john.doe@email.com',
    this.onEditProfile,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    // responsive width
    final width = MediaQuery.of(context).size.width;
    final drawerWidth = (width >= 1024)
        ? 360.0
        : (width >= 600 ? 320.0 : 300.0);

    return Drawer(
      width: drawerWidth,
      child: SafeArea(
        child: Column(
          children: [
            // top area with gradient and avatar overlap
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 160, // a bit taller
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gradientStart,
                        AppColors.gradientMiddle,
                        AppColors.gradientEnd,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SingleChildScrollView(
                    // <── Add this
                    padding: const EdgeInsets.only(
                      top: 28,
                      left: 16,
                      right: 16,
                      bottom: 24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 36),
                        Text(
                          name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          role,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          email,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // overlapping circular avatar at top center
                Positioned(
                  top: -30,
                  left: (drawerWidth / 2) - 36,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: AppColors.gradientStart,
                      child: Text(
                        _initials(name),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                // edit icon centered below name (small)
                Positioned(
                  right: 14,
                  bottom: 8,
                  child: InkWell(
                    onTap:
                        onEditProfile ??
                        () => Get.snackbar(
                          'Edit',
                          'Edit profile tapped',
                          snackPosition: SnackPosition.BOTTOM,
                        ),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // small separation
            Container(height: 8, color: Colors.grey.shade100),

            // Menu items
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    _drawerListTile(
                      icon: Icons.person_outline,
                      title: 'Profile',
                      subtitle: 'Manage your account',
                      onTap: () => Get.toNamed('/profile'),
                    ),
                    const SizedBox(height: 6),
                    // Section label: Support
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Support',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    _drawerListTile(
                      icon: Icons.description_outlined,
                      title: 'Terms & Conditions',
                      onTap: () => Get.toNamed('/terms'),
                    ),
                    _drawerListTile(
                      icon: Icons.info_outline,
                      title: 'About Us',
                      onTap: () => Get.toNamed('/about'),
                    ),
                    _drawerListTile(
                      icon: Icons.mail_outline,
                      title: 'Contact Us',
                      onTap: () => Get.toNamed('/contact'),
                    ),
                    _drawerListTile(
                      icon: Icons.help_outline,
                      title: 'Help & FAQ',
                      onTap: () => Get.toNamed('/faq'),
                    ),

                    const SizedBox(height: 28),
                    // Footer text
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'YB Nexus Education',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Version 2.1.0',
                            style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
            ),

            // Logout button at bottom
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed:
                      onLogout ??
                      () {
                        // default behavior: show confirmation then pop to login
                        Get.defaultDialog(
                          title: 'Logout',
                          middleText: 'Are you sure you want to logout?',
                          textConfirm: 'Yes',
                          textCancel: 'No',
                          onConfirm: () {
                            Get.back(); // close dialog
                            Get.offAllNamed('/login');
                          },
                        );
                      },
                  icon: const Icon(Icons.logout, color: Color(0xFFDF4B4B)),
                  label: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFFDF4B4B),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFFDF4B4B),
                      width: 1.2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _initials(String name) {
    final parts = name.split(' ');
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Widget _drawerListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.gradientMiddle.withOpacity(0.1),
        child: Icon(icon, color: AppColors.textcolor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }
}
