import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/premium_button.dart';

class HeroCarousel extends StatelessWidget {
  const HeroCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, // or larger for tablet/desktop
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(48),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 30,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(48),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            CachedNetworkImage(
              imageUrl:
                  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?q=80&w=2000&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
            
            // Gradient Overlay
            Container(decoration: const BoxDecoration(gradient: AppDecorations.heroOverlay)),

            // Content
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hot Topic Badge + Rating
                  Row(
                    children: [
                      GlassContainer(
                        borderRadius: 24,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Text(
                          'HOT TOPIC',
                          style: AppTextStyles.tag.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: List.generate(
                          5,
                          (index) => const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFFBBF24),
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Title
                  Text(
                    'Benguerra\nLuxury Retreat',
                    style: AppTextStyles.heroSerif.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Button & Social Proof
                  Row(
                    children: [
                      PremiumButton(
                        text: 'Reservar Agora',
                        backgroundColor: Colors.white,
                        textColor: AppColors.viyaraBlue,
                        isExpanded: false,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        borderRadius: 16,
                      ),
                      const SizedBox(width: 16),
                      // Avatars Stack
                      Expanded(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              height: 32,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 24,
                                    child: _buildAvatar('https://i.pravatar.cc/100?img=3'),
                                  ),
                                  Positioned(
                                    left: 12,
                                    child: _buildAvatar('https://i.pravatar.cc/100?img=2'),
                                  ),
                                  Positioned(
                                    left: 0,
                                    child: _buildAvatar('https://i.pravatar.cc/100?img=1'),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '+120 pessoas reservaram hoje',
                                style: AppTextStyles.small.copyWith(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 10,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}
