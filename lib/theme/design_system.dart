import 'package:flutter/material.dart';

/// 🎨 Centralized design system for the app
class AppColors {
  // Three-color gradient
  static const Color gradientStart = Color(0xFF66D1B2); // Light Mint Green
  static const Color gradientMiddle = Color(0xFF3BAA8F); // Medium Teal
  static const Color gradientEnd = Color(0xFF1C524A); // Deep Green Teal
  
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;

  static const Color textcolor = Color(0xFF234C3C);
  static const Color bluecolor = Color(0xFF2979FF);
  static const Color orangecolor = Color(0xFFFFA000);

  static const Color greenColor = Color(0xFF1B4332);
  static const Color lightGreen = Color(0xFFE8F3ED);
  static const Color borderColor = Color(0xFFE0E0E0);

  static const Color gradientStartBlue   = Color(0xFF2E88FF); // Bright dark-blue 
  static const Color gradientMiddleBlue  = Color(0xFF1B6BE0); // Rich mid-blue
  static const Color gradientEndBlue     = Color(0xFF0D47A1); // Very deep blue 

  static const Color greenbutton = Color.fromARGB(255, 12, 136, 105);

  static const Color gradientRedStart = Color(0xFFFF4D4D); // Light Mint Red
  static const Color gradientRedMiddle = Color(0xFFE53935); // Medium Red Teal
  static const Color gradientRedEnd = Color(0xFFC62828);  // Deep Red Teal


  static const Color gradientPurpleStart = Color(0xFF8E5AE8); // Light Mint purple
  static const Color gradientPurpleMiddle = Color(0xFF6A1B9A); // Medium pueple Teal
  static const Color gradientPurpleEnd = Color(0xFF4A148C);  // Deep Purple Teal

  static const Color gradientOrangeStart = Color(0xFFFFB74D); // Light Mint Orange
  static const Color gradientOrangeMiddle = Color(0xFFFB8C00); // Medium Orange Teal
  static const Color gradientOrangeEnd = Color(0xFFEF6C00);   // Deep Orange Teal

  static const Color gradientUgcStart = Color(0xFF9C27B0);
  static const Color gradientUgcMiddle = Color(0xFF7B1FA2);
  static const Color gradientUgcEnd = Color(0xFF4A148C);

  // GATE - Warm Orange Gradient
  static const Color gradientGateStart = Color(0xFFFFCC80);
  static const Color gradientGateMiddle = Color(0xFFFF8A65);
  static const Color gradientGateEnd = Color(0xFFEF6C00);


}


class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: 0.6,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    color: AppColors.textSecondary,
  );

  static const TextStyle tagline = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle version = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle maintitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Color(0xFF0E1621),
  );

  static const TextStyle mainsubtitle = TextStyle(
    fontSize: 14,
    color: Color(0xFF6C737F),
  );

  static const TextStyle labelfield = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: Color(0xFF424242),
  );

  static const TextStyle userbuttontext = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 16,
  );

  static final ButtonStyle button = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF234C3C),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 0,
  );

  static const TextStyle linktext = TextStyle(
    color: Color(0xFF234C3C),
    fontWeight: FontWeight.w600,
    fontSize: 14,
  );
}
