import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'id': 'all', 'icon': Icons.bolt, 'label': 'Tudo'},
      {'id': 'beach', 'icon': Icons.beach_access, 'label': 'Praias'},
      {'id': 'safari', 'icon': Icons.camera_alt_outlined, 'label': 'Safari'},
      {'id': 'food', 'icon': Icons.restaurant, 'label': 'Gastro'},
      {'id': 'villas', 'icon': Icons.home_filled, 'label': 'Villas'},
      {'id': 'water', 'icon': Icons.directions_boat_outlined, 'label': 'Náutica'},
      {'id': 'wellness', 'icon': Icons.spa_outlined, 'label': 'Spa'},
      {'id': 'events', 'icon': Icons.celebration_outlined, 'label': 'Eventos'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Explorar por Estilo', style: AppTextStyles.sectionTitle),
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return _CategoryItem(
                icon: cat['icon'] as IconData,
                label: cat['label'] as String,
                isActive: index == 0,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _CategoryItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: isActive ? AppColors.blue600 : const Color(0xCCFFFFFF), // Placeholder for AppColors.glassBg equivalent
              borderRadius: BorderRadius.circular(24),
              border: isActive
                  ? null
                  : Border.all(color: AppColors.glassBorder, width: 1),
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : AppColors.slate400,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.small.copyWith(
            color: isActive ? AppColors.blue600 : AppColors.slate500,
            fontSize: 11,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

 
