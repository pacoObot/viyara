import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../../shared/models/user_profile.dart';

/// Provider that fetches the UserProfile from Supabase based on the current auth session
final profileProvider = StreamProvider<UserProfile?>((ref) {
  final authUser = ref.watch(authProvider).value;
  final supabase = ref.watch(supabaseClientProvider);

  if (authUser == null) {
    return Stream.value(null);
  }

  // Real-time stream of the user profile from Supabase
  return supabase
      .from('profiles')
      .stream(primaryKey: ['id'])
      .eq('id', authUser.id)
      .limit(1)
      .map((data) {
        if (data.isEmpty) return null;
        return UserProfile.fromJson(data.first);
      });
});
