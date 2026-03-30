import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Viyara Premium Design System — Typography
/// Plus Jakarta Sans (primary) + Playfair Display (serif accents)
class AppTextStyles {
  AppTextStyles._();

  // ─── Plus Jakarta Sans ─────────────────────────────────────

  /// Giant serif hero titles (used in details page, success)
  static TextStyle heroSerif = GoogleFonts.playfairDisplay(
    fontSize: 40,
    fontWeight: FontWeight.w900,
    color: AppColors.slate900,
    height: 1.1,
  );

  /// App title "Viyara ."
  static TextStyle appTitle = GoogleFonts.plusJakartaSans(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.viyaraBlue,
    letterSpacing: -1.5,
  );

  /// Section headers like "Explorar por Estilo"
  static TextStyle sectionTitle = GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.viyaraBlue,
  );

  /// Card titles / place names
  static TextStyle cardTitle = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.slate800,
    letterSpacing: -0.3,
  );

  /// Subtitle (medium emphasis)
  static TextStyle subtitle = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  /// Body text
  static TextStyle body = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  /// Body light (descriptions)
  static TextStyle bodyLight = GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w300,
    color: AppColors.slate500,
    height: 1.6,
  );

  /// Small text
  static TextStyle small = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  /// Micro labels (uppercase tracking)
  static TextStyle micro = GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w800,
    color: AppColors.slate400,
    letterSpacing: 2.5,
  );

  /// Price text
  static TextStyle price = GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w900,
    color: AppColors.accentBlue,
  );

  /// Price large (payment summary)
  static TextStyle priceLarge = GoogleFonts.plusJakartaSans(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    color: AppColors.viyaraBlue,
    height: 1.0,
  );

  /// Button text
  static TextStyle button = GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  /// Button text (small)
  static TextStyle buttonSmall = GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  /// Navigation label
  static TextStyle navLabel = GoogleFonts.plusJakartaSans(
    fontSize: 9,
    fontWeight: FontWeight.w800,
    letterSpacing: 2.0,
  );

  /// Tag / Badge text
  static TextStyle tag = GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w900,
    letterSpacing: 2.0,
  );

  /// Story username
  static TextStyle storyLabel = GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.slate600,
  );

  /// Yaras balance
  static TextStyle yarasBalance = GoogleFonts.plusJakartaSans(
    fontSize: 48,
    fontWeight: FontWeight.w900,
    color: Colors.white,
  );

  /// Onboarding hero text
  static TextStyle onboardingHero = GoogleFonts.plusJakartaSans(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.15,
  );

  /// Onboarding body text
  static TextStyle onboardingBody = GoogleFonts.plusJakartaSans(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
  );
}
