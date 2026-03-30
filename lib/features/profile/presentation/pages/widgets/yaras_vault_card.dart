import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_decorations.dart';
import '../../../../../shared/models/user_profile.dart';

class YarasVaultCard extends StatelessWidget {
  final UserProfile profile;

  const YarasVaultCard({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.cofreGradient,
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'O SEU COFRE',
                style: AppTextStyles.micro.copyWith(color: AppColors.blue200),
              ),
              const Icon(Icons.info_outline, color: AppColors.blue200, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                profile.yarasBalance.toString(),
                style: AppTextStyles.yarasBalance,
              ),
              const SizedBox(width: 8),
              Text(
                'Yaras',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.blue200,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Faltam ${profile.yarasToNextLevel} Yaras para o nível ${profile.nextLevelName}',
            style: AppTextStyles.small.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: (profile.progressPercent * 100).toInt(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Expanded(
                  flex: 100 - (profile.progressPercent * 100).toInt(),
                  child: const SizedBox(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(profile.status, style: AppTextStyles.micro.copyWith(color: AppColors.blue200)),
              Text(profile.nextLevelName, style: AppTextStyles.micro.copyWith(color: AppColors.blue200)),
            ],
          ),
        ],
      ),
    );
  }
}
