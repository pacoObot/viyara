import 'package:flutter/material.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ImageGallery extends StatelessWidget {
  final String imageUrl;

  const ImageGallery({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 480,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66000000), // Darker at top for status bar
                  Colors.transparent,
                  Color(0x80000000), // Dark at bottom for title contrast
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),
          
          // Image Indicators overlay (simulating a gallery)
          Positioned(
            bottom: 32,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x66000000), // AppColors.glassBg alternative
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white24),
              ),
              child: Row(
                children: [
                  const Icon(Icons.photo_library_outlined, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text('1 / 15 Fotos', style: AppTextStyles.micro.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
