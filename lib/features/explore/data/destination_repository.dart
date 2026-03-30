import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../shared/models/destination.dart';

class DestinationRepository {
  final SupabaseClient _client;

  DestinationRepository(this._client);

  Future<List<Destination>> getDestinations() async {
    try {
      final response = await _client
          .from('destinations')
          .select()
          .order('created_at', ascending: false);
      
      return (response as List).map((json) => Destination.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Falha ao buscar destinos: $e');
    }
  }

  Future<void> toggleFavorite(String id, bool isFavorite) async {
    await _client
        .from('destinations')
        .update({'is_favorite': isFavorite})
        .eq('id', id);
  }
}
