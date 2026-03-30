import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/models/user_profile.dart';
import 'auth_provider.dart';

/// Provider that watches the Supabase profile for the current user.
class UserProfileNotifier extends AsyncNotifier<UserProfile?> {
  @override
  FutureOr<UserProfile?> build() async {
    final authUser = ref.watch(authProvider).value;
    
    if (authUser == null) return null;

    final supabase = ref.watch(supabaseClientProvider);

    try {
      final response = await supabase
          .from('profiles')
          .select()
          .eq('id', authUser.id)
          .single();
      
      return UserProfile.fromJson(response);
    } catch (e) {
      // Return null or handle the error if the profile doesn't exist yet
      return null;
    }
  }

  Future<void> updateProfile({String? name, String? avatarUrl}) async {
    final authUser = ref.read(authProvider).value;
    if (authUser == null) return;

    final supabase = ref.read(supabaseClientProvider);

    await supabase.from('profiles').update({
      if (name != null) 'name': name,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', authUser.id);

    ref.invalidateSelf(); // Refresh the profile
  }
}

final userProfileProvider =
    AsyncNotifierProvider<UserProfileNotifier, UserProfile?>(() {
  return UserProfileNotifier();
});
