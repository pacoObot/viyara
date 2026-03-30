import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AmenitiesList extends StatelessWidget {
  const AmenitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final amenities = [
      {'icon': Icons.pool_outlined, 'name': 'Piscina Privada'},
      {'icon': Icons.spa_outlined, 'name': 'Spa Exclusivo'},
      {'icon': Icons.wifi_outlined, 'name': 'Internet Rapida'},
      {'icon': Icons.directions_car_outlined, 'name': 'Transfer VIP'},
      {'icon': Icons.local_bar_outlined, 'name': 'Mini Bar Premium'},
      {'icon': Icons.restaurant_menu_outlined, 'name': 'Chef 24h'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /*
        Text('Comodidades', style: AppTextStyles.sectionTitle),
        const SizedBox(height: 16),
        */
        GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: amenities.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3, // Wide rectangles
          ),
          itemBuilder: (context, index) {
            final amenity = amenities[index];
            return Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.blue50,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    amenity['icon'] as IconData,
                    color: AppColors.blue600,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    amenity['name'] as String,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.slate800,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
