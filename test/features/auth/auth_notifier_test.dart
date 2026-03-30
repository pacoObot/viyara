import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:viyara/features/auth/providers/auth_provider.dart';

// Mocks
class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockGoTrueClient extends Mock implements GoTrueClient {}
class MockUser extends Mock implements User {}

void main() {
  late MockSupabaseClient mockSupabase;
  late MockGoTrueClient mockAuth;

  setUp(() {
    mockSupabase = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    when(() => mockSupabase.auth).thenReturn(mockAuth);
  });

  group('AuthNotifier Tests', () {
    test('Initial state should be AsyncData with currentUser', () async {
      final mockUser = MockUser();
      when(() => mockAuth.currentUser).thenReturn(mockUser);

      final container = ProviderContainer(
        overrides: [
          supabaseClientProvider.overrideWithValue(mockSupabase),
        ],
      );

      final state = await container.read(authProvider.future);
      expect(state, mockUser);
      verify(() => mockAuth.currentUser).called(1);
    });

    test('Initial state should be null if no user is signed in', () async {
      when(() => mockAuth.currentUser).thenReturn(null);

      final container = ProviderContainer(
        overrides: [
          supabaseClientProvider.overrideWithValue(mockSupabase),
        ],
      );

      final state = await container.read(authProvider.future);
      expect(state, null);
    });

    test('signOut should call Supabase signOut and clear state', () async {
      when(() => mockAuth.currentUser).thenReturn(null);
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      final container = ProviderContainer(
        overrides: [
          supabaseClientProvider.overrideWithValue(mockSupabase),
        ],
      );

      // Trigger signOut
      await container.read(authProvider.notifier).signOut();
      
      final state = await container.read(authProvider.future);
      expect(state, null);
      verify(() => mockAuth.signOut()).called(1);
    });
  });
}
