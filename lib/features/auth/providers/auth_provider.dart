import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Provider for the Supabase Client to enable dependency injection in tests
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// AuthNotifier managed via AsyncNotifier per Riverpod 3.x patterns.
/// Handles Supabase Auth session and social logins.
class AuthNotifier extends AsyncNotifier<User?> {
  @override
  FutureOr<User?> build() {
    return _supabase.auth.currentUser;
  }

  SupabaseClient get _supabase => ref.watch(supabaseClientProvider);

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Access singleton instance and authenticate()
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      
      // Starting from 7.2.0, authenticate() is used instead of signIn()
      final googleUser = await googleSignIn.authenticate();
      
      // googleUser.authentication is now a synchronous property
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) throw Exception('No Google ID Token found');

      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        // accessToken is optional and typically not returned by default in 7.x without extra scopes
      );

      return response.user;
    });
  }

  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // Using AppleIDAuthorizationScopes (plural) for 7.0.1+
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      if (idToken == null) throw Exception('No Apple Identity Token found');

      final AuthResponse response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.apple,
        idToken: idToken,
      );

      return response.user;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _supabase.auth.signOut();
      return null;
    });
  }

  /// Email/password auth flow for quick testing:
  /// 1) Try sign in
  /// 2) If credentials are invalid, try sign up automatically
  Future<void> signInOrSignUpWithEmail({
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty || password.isEmpty) {
      state = AsyncError(
        Exception('Email e palavra-passe são obrigatórios.'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      try {
        final signInResponse = await _supabase.auth.signInWithPassword(
          email: normalizedEmail,
          password: password,
        );

        final signedInUser = signInResponse.user ?? _supabase.auth.currentUser;
        if (signedInUser == null) {
          throw Exception('Não foi possível autenticar com email.');
        }
        return signedInUser;
      } on AuthException catch (e) {
        final message = e.message.toLowerCase();
        final canAutoSignUp = message.contains('invalid login credentials') ||
            message.contains('invalid_credentials') ||
            message.contains('user not found');

        if (!canAutoSignUp) rethrow;

        final signUpResponse = await _supabase.auth.signUp(
          email: normalizedEmail,
          password: password,
        );
        final createdUser = signUpResponse.user ?? _supabase.auth.currentUser;
        if (createdUser == null) {
          throw Exception(
            'Conta criada sem sessão ativa. Verifique se a confirmação de email está desativada no Supabase para testes.',
          );
        }
        return createdUser;
      }
    });
  }
}

/// Provider definition
final authProvider = AsyncNotifierProvider<AuthNotifier, User?>(() {
  return AuthNotifier();
});
