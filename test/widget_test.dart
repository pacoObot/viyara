import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:viyara/features/splash/presentation/pages/splash_page.dart';
import 'package:viyara/features/auth/providers/auth_provider.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockGoTrueClient extends Mock implements GoTrueClient {}

void main() {
  late MockSupabaseClient mockSupabase;
  late MockGoTrueClient mockAuth;

  setUp(() {
    mockSupabase = MockSupabaseClient();
    mockAuth = MockGoTrueClient();
    when(() => mockSupabase.auth).thenReturn(mockAuth);
  });

  testWidgets('SplashPage smoke test - should show Logo and Viyara text', (tester) async {
    when(() => mockAuth.currentUser).thenReturn(null);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          supabaseClientProvider.overrideWithValue(mockSupabase),
        ],
        child: const MaterialApp(
          home: SplashPage(),
        ),
      ),
    );

    // Initial state should show the logo text 'V'
    expect(find.text('V'), findsOneWidget);
    expect(find.text('VIYARA'), findsOneWidget);
    
    // Pump animation and future.delayed in _checkAuthSession
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('PREMIUM RETREATS'), findsOneWidget);

    // Wait for the auth check timer (2.5 seconds) to finish to avoid "Timer still pending" error
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
