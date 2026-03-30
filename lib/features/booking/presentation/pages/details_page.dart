import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/destination.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/premium_button.dart';
import 'widgets/image_gallery.dart';
import 'widgets/amenities_list.dart';

class DetailsPage extends StatelessWidget {
  final Destination destination;

  const DetailsPage({
    super.key,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassContainer(
            borderRadius: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassContainer(
              borderRadius: 16,
              child: IconButton(
                icon: Icon(
                  destination.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: destination.isFavorite ? AppColors.error : Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassContainer(
              borderRadius: 16,
              child: IconButton(
                icon: const Icon(Icons.share_outlined, color: Colors.white),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageGallery(imageUrl: destination.imageUrl),
                
                // Title and Location
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.blue50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              destination.tag.toUpperCase(),
                              style: AppTextStyles.micro.copyWith(color: AppColors.blue600),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.star_rounded, color: Color(0xFFFBBF24), size: 20),
                              const SizedBox(width: 4),
                              Text(
                                destination.rating,
                                style: AppTextStyles.subtitle.copyWith(color: AppColors.slate800),
                              ),
                              Text(
                                ' (128 avaliações)',
                                style: AppTextStyles.small.copyWith(color: AppColors.slate400),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        destination.name,
                        style: AppTextStyles.heroSerif.copyWith(fontSize: 32),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: AppColors.blue500, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            destination.location,
                            style: AppTextStyles.body.copyWith(color: AppColors.slate600),
                          ),
                          const SizedBox(width: 8),
                          Text('•', style: AppTextStyles.body.copyWith(color: AppColors.slate400)),
                          const SizedBox(width: 8),
                          Text(
                            'Ver no mapa',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.blue600,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Highlight Feature
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.viyaraBlue,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0x33FFFFFF),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(Icons.workspace_premium, color: AppColors.goldMid),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Viyara Signature',
                                    style: AppTextStyles.body.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  Text(
                                    'Mordomo 24h & Chef Privado incluídos',
                                    style: AppTextStyles.small.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                      
                      // Amenities (Abstracted)
                      const AmenitiesList(),
                      
                      const SizedBox(height: 32),
                      
                      // Description
                      Text('Sobre o Refúgio', style: AppTextStyles.sectionTitle),
                      const SizedBox(height: 16),
                      Text(
                        'Esta majestosa propriedade no topo da falésia é o reflexo do luxo isolado. Perfeita para quem procura total privacidade numa das paisagens costeiras mais exuberantes do momento.',
                        style: AppTextStyles.bodyLight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Bottom Booking Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 40,
                    offset: Offset(0, -10),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Preço base', style: AppTextStyles.micro),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(destination.price, style: AppTextStyles.price),
                            Text(' MT', style: AppTextStyles.small),
                          ],
                        ),
                        Text('/noite', style: AppTextStyles.small),
                      ],
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: PremiumButton(
                        text: 'Configurar Reserva',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
