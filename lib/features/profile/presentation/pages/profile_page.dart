import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('MEU PERFIL'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return const Center(child: Text('Perfil não encontrado'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100, bottom: 120),
            child: Column(
              children: [
                // Avatar Header
                _buildAvatarHeader(profile),
                const SizedBox(height: 40),
                
                // Yaras Vault (Cofre)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: YarasVaultCard(profile: profile),
                ),
                const SizedBox(height: 40),

                // Benefits Section
                _buildBenefitsSection(),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Erro ao carregar perfil: $e')),
      ),
    );
  }

  Widget _buildAvatarHeader(UserProfile profile) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
                  colors: [AppColors.blue100, AppColors.blue50],
                ),
                border: Border.all(color: Colors.white, width: 4),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 25,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Image.network(
                  profile.avatarUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 16),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          profile.name,
          style: AppTextStyles.heroSerif.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.blue50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'Status ${profile.status}'.toUpperCase(),
            style: AppTextStyles.micro.copyWith(color: AppColors.blue600),
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vantagens Disponíveis',
                style: AppTextStyles.cardTitle.copyWith(fontSize: 18),
              ),
              Text(
                'VER TODAS',
                style: AppTextStyles.micro.copyWith(color: AppColors.blue600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: AppDecorations.premiumCard,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.blue50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.directions_car, color: AppColors.blue600),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Transfer Privado', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w900)),
                        Text('Grátis para Membros Ouro', style: AppTextStyles.small),
                      ],
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('RESGATAR', style: AppTextStyles.micro),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
