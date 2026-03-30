import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {'user': 'Maputo Luxury', 'img': 'https://i.pravatar.cc/150?u=1', 'color': AppColors.blue500},
      {'user': 'Bazaruto Dive', 'img': 'https://i.pravatar.cc/150?u=2', 'color': AppColors.storyPink},
      {'user': 'Ponta Vibes', 'img': 'https://i.pravatar.cc/150?u=3', 'color': AppColors.storyAmber},
      {'user': 'Elite Concierge', 'img': 'https://i.pravatar.cc/150?u=4', 'color': AppColors.storyGreen},
      {'user': 'Inhambane Sky', 'img': 'https://i.pravatar.cc/150?u=5', 'color': AppColors.storyPurple},
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length + 1,
        separatorBuilder: (_, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildAddStory();
          }
          final story = stories[index - 1];
          return _buildStoryItem(
            user: story['user'] as String,
            img: story['img'] as String,
            color: story['color'] as Color,
          );
        },
      ),
    );
  }

  Widget _buildAddStory() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.blue300,
              width: 2,
              style: BorderStyle.none,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.blue300,
                width: 2,
              ),
              color: AppColors.surface,
              boxShadow: const [
                BoxShadow(color: Color(0x0D000000), blurRadius: 4),
              ],
            ),
            child: const Icon(Icons.add, color: AppColors.blue500, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text('Teu Story', style: AppTextStyles.storyLabel),
      ],
    );
  }

  Widget _buildStoryItem({
    required String user,
    required String img,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(img, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 72,
          child: Text(
            user,
            style: AppTextStyles.storyLabel,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
