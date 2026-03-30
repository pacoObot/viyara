import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/glass_container.dart';
import '../../../../shared/widgets/premium_button.dart';
import 'widgets/login_form.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Disable manual swipe
            onPageChanged: (idx) {
              setState(() {
                _currentPage = idx;
              });
            },
            children: [
              _buildStep1(),
              _buildStep2(),
              _buildStep3(),
              const LoginForm(),
            ],
          ),
          
          // Progress Indicators (Hide on login screen)
          if (_currentPage < 3)
            Positioned(
              top: MediaQuery.of(context).padding.top + 24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      color: index <= _currentPage
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  );
                }),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStep1() {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image with Pan effect via scaling slightly
        Image.network(
          'https://images.unsplash.com/photo-1544198365-f5d60b6d8190?auto=format&fit=crop&q=90&w=1920',
          fit: BoxFit.cover,
        ),
        // Overlays
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x33000000),
                Color(0x66000000),
                Color(0xE6000000),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore o\nInexplorado',
                style: AppTextStyles.onboardingHero,
              ),
              const SizedBox(height: 24),
              Text(
                'Descubra refúgios secretos e experiências de luxo desenhadas exclusivamente para si.',
                style: AppTextStyles.onboardingBody,
              ),
              const SizedBox(height: 48),
              PremiumButton(
                text: 'Continuar Viagem',
                icon: Icons.arrow_forward_rounded,
                isOutlined: true,
                textColor: Colors.white,
                onPressed: _nextPage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=90&w=1920',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.darkBg,
                Colors.transparent,
                Color(0x4D000000),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlassContainer(
                borderRadius: 40,
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sem Complicações,\nApenas Momentos',
                      style: AppTextStyles.onboardingHero.copyWith(
                        fontSize: 32,
                        wordSpacing: -2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'De jatos privados a vilas exclusivas. Gerimos cada detalhe da sua estadia em segundos.',
                      style: AppTextStyles.onboardingBody.copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              PremiumButton(
                text: 'Próximo Passo',
                isOutlined: true,
                textColor: Colors.white,
                onPressed: _nextPage,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkBg,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Lights
          Positioned(
            top: 200,
            left: MediaQuery.of(context).size.width * 0.25,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0x332563EB),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0x332563EB), blurRadius: 100),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            right: 0,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Color(0x1A059669),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Color(0x1A059669), blurRadius: 100),
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Floating Yara Element
                Container(
                  width: 256,
                  height: 256,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(48),
                    border: Border.all(color: Colors.white24),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0x333B82F6), Color(0x3310B981)],
                    ),
                  ),
                  transform: Matrix4.rotationZ(0.2), // rotate roughly 12 degrees
                  child: Center(
                    child: Transform.rotate(
                      angle: -0.2,
                      child: const Text(
                        'Y',
                        style: TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 64),
                Text(
                  'Viaje e Ganhe Yaras',
                  style: AppTextStyles.onboardingHero.copyWith(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Text(
                  'Transforme as suas aventuras em recompensas exclusivas. Yaras são o passaporte para o seu próximo privilégio.',
                  style: AppTextStyles.onboardingBody.copyWith(
                    color: AppColors.slate400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                PremiumButton(
                  text: 'Entrar no Universo Viyara',
                  backgroundColor: AppColors.blue600,
                  textColor: Colors.white,
                  onPressed: _nextPage,
                  hasShadow: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
