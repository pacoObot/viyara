import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'core/constants/app_constants.dart';
import 'features/splash/presentation/pages/splash_page.dart';



Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    
    debugPrint('Iniciando Supabase...');
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
    );

    debugPrint('Iniciando Google Sign In...');
    try {
      // In version 7.x+, check for platform support before initializing
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        await GoogleSignIn.instance.initialize();
      } else {
        debugPrint('Google Sign In não é suportado nesta plataforma.');
      }
    } catch (e) {
      debugPrint('Aviso: Falha ao inicializar Google Sign In: $e');
      // Não interrompemos o app se apenas o Google Sign In falhar
    }

    debugPrint('Rodando App...');
    runApp(
      const ProviderScope(
        child: ViyaraApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint('ERRO CRÍTICO NA INICIALIZAÇÃO: $e');
    debugPrint(stack.toString());
    
    // Roda um app mínimo de erro se o principal falhar
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'Erro ao iniciar Viyara:\n$e',
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    ));
  }
}


class ViyaraApp extends StatelessWidget {
  const ViyaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Viyara Premium',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', ''),
        Locale('en', ''),
      ],
      home: const SplashPage(),
    );
  }
}
