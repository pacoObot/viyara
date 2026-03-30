import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/destination_repository.dart';
import '../../auth/providers/auth_provider.dart';
import '../../../shared/models/destination.dart';

/// Provider for the repository
final destinationRepositoryProvider = Provider<DestinationRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return DestinationRepository(client);
});

/// AsyncNotifierProvider to manage the list of destinations
class DestinationNotifier extends AsyncNotifier<List<Destination>> {
  @override
  Future<List<Destination>> build() async {
    return ref.watch(destinationRepositoryProvider).getDestinations();
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    // Optimistic update
    final previousState = await future;
    state = AsyncData(
      previousState.map((d) => d.id == id ? d.copyWith(isFavorite: !isFavorite) : d).toList(),
    );

    try {
      await ref.read(destinationRepositoryProvider).toggleFavorite(id, !isFavorite);
    } catch (e) {
      // Revert if error
      state = AsyncData(previousState);
    }
  }
}

final destinationProvider =
    AsyncNotifierProvider<DestinationNotifier, List<Destination>>(() {
  return DestinationNotifier();
});
