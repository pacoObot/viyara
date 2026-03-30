import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../shared/models/destination.dart';
import 'glass_container.dart';

/// Destination card matching the renderPlaces() output in home2.html
/// Premium card with image, rating badge, tag, price, and details button
class DestinationCard extends StatefulWidget {
  final Destination destination;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;
  final double? width;

  const DestinationCard({
    super.key,
    required this.destination,
    this.onTap,
    this.onFavoriteTap,
    this.width,
  });

  @override
  State<DestinationCard> createState() => _DestinationCardState();
}

class _DestinationCardState extends State<DestinationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pressController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.94).animate(
      CurvedAnimation(
        parent: _pressController,
        curve: const Cubic(0.175, 0.885, 0.32, 1.275),
      ),
    );
  }

  @override
  void dispose() {
    _pressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.destination;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: (_) => _pressController.forward(),
        onTapUp: (_) {
          _pressController.reverse();
          widget.onTap?.call();
        },
        onTapCancel: () => _pressController.reverse(),
        child: Container(
          width: widget.width,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppColors.slate100),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D1E3A8A),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Image Section ──
              ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: d.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.slate100,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.slate200,
                          child: const Icon(Icons.image_not_supported),
                        ),
                      ),
                    ),
                    // Rating badge
                    Positioned(
                      top: 16,
                      left: 16,
                      child: GlassContainer(
                        borderRadius: 16,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFF59E0B),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              d.rating,
                              style: AppTextStyles.small.copyWith(
                                color: AppColors.viyaraBlue,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Favorite button
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: widget.onFavoriteTap,
                        child: GlassContainer(
                          borderRadius: 16,
                          padding: const EdgeInsets.all(12),
                          child: Icon(
                            d.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: d.isFavorite ? Colors.red : Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                    // Tag badge
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: GlassContainer(
                        borderRadius: 16,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Text(
                          d.tag.toUpperCase(),
                          style: AppTextStyles.tag.copyWith(
                            color: AppColors.blue600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // ── Info Section ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(d.name, style: AppTextStyles.cardTitle),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.slate400,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          d.location,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.slate400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Price & Details row
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: AppColors.slate50),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'PREÇO / NOITE',
                                style: AppTextStyles.micro,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    d.price,
                                    style: AppTextStyles.price,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'MT',
                                    style: AppTextStyles.micro.copyWith(
                                      color: AppColors.slate400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.slate900,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              'Detalhes',
                              style: AppTextStyles.buttonSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
