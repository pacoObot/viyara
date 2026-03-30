import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/models/destination.dart';
import '../../../../shared/widgets/destination_card.dart';
import '../../../../shared/widgets/shimmer_loading.dart';
import '../../providers/destination_provider.dart';

class NearbyPlaces extends ConsumerWidget {
  const NearbyPlaces({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final destinationsAsync = ref.watch(destinationProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.blue600,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text('Mais Próximos', style: AppTextStyles.sectionTitle),
                ],
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.blue600,
                  textStyle: AppTextStyles.small.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                child: const Row(
                  children: [
                    Text('Ver todos'),
                    Icon(Icons.chevron_right, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 380,
          child: destinationsAsync.when(
            data: (destinations) {
              final places = destinations.isNotEmpty 
                  ? destinations 
                  : Destination.sampleDestinations;
                  
              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: places.length,
                separatorBuilder: (_, index) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  return DestinationCard(
                    destination: places[index],
                    width: MediaQuery.of(context).size.width * 0.85,
                    onTap: () {},
                    onFavoriteTap: () {
                      ref.read(destinationProvider.notifier).toggleFavorite(
                        places[index].id, 
                        places[index].isFavorite
                      );
                    },
                  );
                },
              );
            },
            loading: () => ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              separatorBuilder: (_, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) => ShimmerLoading(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 380,
                borderRadius: 40,
              ),
            ),
            error: (err, stack) => Center(
              child: Text('Erro ao carregar destinos: $err'),
            ),
          ),
        ),
      ],
    );
  }
}
