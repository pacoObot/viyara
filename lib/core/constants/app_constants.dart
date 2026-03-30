import 'package:flutter/material.dart';

/// Viyara App Constants
class AppConstants {
  AppConstants._();

  // ─── Supabase ──────────────────────────────────────────────
  static const String supabaseUrl = 'https://yeobnwvqcqlaonsyuvpg.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inllb2Jud3ZxY3FsYW9uc3l1dnBnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQ4NTkxNTcsImV4cCI6MjA5MDQzNTE1N30.TL3116PBDLjyZA88mfng3C1rkxygjv4IHmX5WYW1XRg';

  // ─── Sizes ─────────────────────────────────────────────────
  static const double radiusSm = 16.0;
  static const double radiusMd = 24.0;
  static const double radiusLg = 32.0;
  static const double radiusXl = 40.0;
  static const double radiusXxl = 48.0;

  static const double navBarHeight = 80.0;
  static const double navBarMargin = 32.0;

  static const double cardPadding = 24.0;
  static const double pagePadding = 16.0;
  static const double pagePaddingLg = 48.0;

  // ─── Animation Durations ───────────────────────────────────
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration reveal = Duration(milliseconds: 600);

  // ─── Curves ────────────────────────────────────────────────
  static const Cubic premiumCurve = Cubic(0.175, 0.885, 0.32, 1.275);
  static const Cubic revealCurve = Cubic(0.16, 1, 0.3, 1);

  // ─── Yaras System ──────────────────────────────────────────
  static const int initialYaras = 200;
  static const double yarasDiscountPercent = 0.10;
  static const int yarasPerBooking = 500;
}
