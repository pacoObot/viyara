import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Viyara Premium Design System — Decorations & Glassmorphism
class AppDecorations {
  AppDecorations._();

  // ─── Glassmorphism ─────────────────────────────────────────

  /// Light glass (home header, nav bar, search bar)
  static BoxDecoration glassLight = BoxDecoration(
    color: AppColors.glassBg,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: AppColors.glassBorder, width: 1),
  );

  /// Dark glass (login screens, onboarding cards)
  static BoxDecoration glassDark = BoxDecoration(
    color: AppColors.glassDark,
    borderRadius: BorderRadius.circular(40),
    border: Border.all(color: AppColors.glassDarkBorder, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x5E000000),
        blurRadius: 32,
        offset: Offset(0, 8),
      ),
    ],
  );

  /// Glass button (onboarding CTA)
  static BoxDecoration glassButton = BoxDecoration(
    color: const Color(0x26FFFFFF),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0x4DFFFFFF), width: 1),
  );

  // ─── Card Decorations ─────────────────────────────────────

  /// Premium card (place cards, booking widget)
  static BoxDecoration premiumCard = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(40),
    border: Border.all(color: AppColors.cardBorder, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x08001A5E),
        blurRadius: 25,
        offset: Offset(0, 4),
      ),
    ],
  );

  /// Shadow card (place card with stronger shadow)
  static BoxDecoration placeCard = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(40),
    border: Border.all(color: AppColors.slate100, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x0D1E3A8A),
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  );

  // ─── Navigation Bar ────────────────────────────────────────

  /// Bottom navigation bar glass
  static BoxDecoration bottomNavBar = BoxDecoration(
    color: AppColors.glassBg,
    borderRadius: BorderRadius.circular(32),
    border: Border.all(color: AppColors.glassBorder, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 40,
        offset: Offset(0, 10),
      ),
    ],
  );

  // ─── Cofre / Vault Gradient ────────────────────────────────

  /// Blue gradient vault card (profile)
  static BoxDecoration cofreGradient = BoxDecoration(
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [AppColors.cofreStart, AppColors.cofreEnd],
    ),
    borderRadius: BorderRadius.circular(40),
    boxShadow: const [
      BoxShadow(
        color: Color(0x402563EB),
        blurRadius: 40,
        offset: Offset(0, 20),
      ),
    ],
  );

  // ─── Input ─────────────────────────────────────────────────

  /// Glass input (login)
  static BoxDecoration glassInput = BoxDecoration(
    color: const Color(0x0DFFFFFF),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: const Color(0x1AFFFFFF), width: 1),
  );

  /// Focused glass input
  static BoxDecoration glassInputFocused = BoxDecoration(
    color: const Color(0x1AFFFFFF),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: AppColors.lightBlue, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x4D60A5FA),
        blurRadius: 15,
      ),
    ],
  );

  // ─── Search Bar ────────────────────────────────────────────

  static BoxDecoration searchBar = BoxDecoration(
    color: AppColors.glassBg,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: AppColors.glassBorder, width: 1),
    boxShadow: const [
      BoxShadow(
        color: Color(0x0D1E3A8A),
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  );

  // ─── Category Tile ─────────────────────────────────────────

  static BoxDecoration categoryTile = BoxDecoration(
    color: AppColors.glassBg,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: AppColors.glassBorder, width: 1),
  );

  static BoxDecoration categoryTileActive = BoxDecoration(
    color: AppColors.blue600,
    borderRadius: BorderRadius.circular(24),
  );

  // ─── Seasonal Section ──────────────────────────────────────

  static BoxDecoration seasonalSection = BoxDecoration(
    color: AppColors.viyaraBlue,
    borderRadius: BorderRadius.circular(48),
  );

  // ─── Image Overlay Gradients ───────────────────────────────

  static const LinearGradient heroOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x4D000000),
      Color(0x33000000),
      Color(0xCC000000),
    ],
    stops: [0.0, 0.3, 1.0],
  );

  static const LinearGradient detailsOverlay = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x4D000000),
      Color(0x00000000),
      Color(0xB3000000),
    ],
    stops: [0.0, 0.3, 1.0],
  );
}
