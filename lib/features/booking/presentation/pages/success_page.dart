import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/premium_button.dart';
import '../../../explore/presentation/pages/home_page.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Check/Gem Sequence
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.success.withValues(alpha: 0.1),
                  border: Border.all(color: AppColors.success, width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x3310B981),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(Icons.check_rounded, color: AppColors.success, size: 60),
                ),
              ),
              const SizedBox(height: 48),

              Text('Reserva Confirmada', style: AppTextStyles.heroSerif.copyWith(fontSize: 32)),
              const SizedBox(height: 16),
              Text(
                'Tudo pronto para a sua experiência exclusiva no Benguerra Retreat. Os detalhes foram enviados para o seu email.',
                style: AppTextStyles.bodyLight,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 48),

              // Gamification Reward Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.goldStart, AppColors.goldEnd],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33DAA520),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Text('Y', style: TextStyle(fontWeight: FontWeight.w900, color: AppColors.goldMid)),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('+500 Yaras', style: AppTextStyles.cardTitle.copyWith(color: AppColors.slate900)),
                          Text('Adicionadas ao seu cofre', style: AppTextStyles.small.copyWith(color: AppColors.slate800)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: PremiumButton(
                      text: 'Ver Comprovativo',
                      isOutlined: true,
                      textColor: AppColors.viyaraBlue,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: PremiumButton(
                      text: 'Voltar ao Explorar',
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
