import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../../../shared/widgets/bottom_nav_bar.dart';
import '../widgets/stories_section.dart';
import '../widgets/hero_carousel.dart';
import '../widgets/categories_grid.dart';
import '../widgets/nearby_places.dart';
import '../widgets/seasonal_picks.dart';
import 'map_explorer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 50 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 120), // Top Header spacing
                const StoriesSection(),
                const SizedBox(height: 24),
                const HeroCarousel(),
                const SizedBox(height: 48),
                const CategoriesGrid(),
                const SizedBox(height: 48),
                const NearbyPlaces(),
                const SizedBox(height: 48),
                const SeasonalPicks(),
                const SizedBox(height: 120), // Bottom Nav spacing
              ],
            ),
          ),
          
          // Sticky Top Header (Animates to Glassmorphism on scroll)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: _isScrolled
                  ? AppDecorations.glassLight.copyWith(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    )
                  : const BoxDecoration(),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MOZAMBIQUE',
                                style: AppTextStyles.micro.copyWith(
                                  color: AppColors.blue500,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Viyara ',
                                    style: AppTextStyles.appTitle,
                                  ),
                                  Text(
                                    '.',
                                    style: AppTextStyles.appTitle.copyWith(
                                      color: AppColors.blue400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              _buildIconButton(
                                icon: Icons.notifications_none_rounded,
                                hasBadge: true,
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppColors.viyaraBlue,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    'https://api.dicebear.com/7.x/avataaars/svg?seed=Felix',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Search Bar Row
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 56,
                              decoration: AppDecorations.searchBar,
                              child: Row(
                                children: [
                                  const SizedBox(width: 16),
                                  const Icon(Icons.search, color: AppColors.blue500),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: 'Pesquisar vilas, ilhas...',
                                        hintStyle: AppTextStyles.body.copyWith(
                                          color: AppColors.blue300,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        contentPadding: EdgeInsets.zero,
                                        filled: false,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildIconButton(
                            icon: Icons.map_outlined,
                            hasBadge: false,
                            size: 56,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const MapExplorerPage()),
                            ),
                          ),
                          const SizedBox(width: 12),
                          _buildIconButton(
                            icon: Icons.tune_rounded,
                            hasBadge: false,
                            size: 56,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Custom Bottom Navigation Bar
          PremiumBottomNavBar(
            currentIndex: _currentTab,
            onTap: (index) {
              setState(() {
                _currentTab = index;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    bool hasBadge = false,
    double size = 48,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color(0xCCFFFFFF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, color: AppColors.viyaraBlue),
            if (hasBadge)
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

 
