import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import 'glass_container.dart';

/// Persistent Yaras badge that shows the balance at the top-right of the app
/// Referenced in the gamification system requirement
class YarasBadge extends StatelessWidget {
  final int balance;
  final VoidCallback? onTap;

  const YarasBadge({
    super.key,
    required this.balance,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Mini Yara coin
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.goldStart,
                    AppColors.goldMid,
                    AppColors.goldEnd,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'Y',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF5C4033),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '$balance',
              style: AppTextStyles.small.copyWith(
                color: AppColors.viyaraBlue,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
