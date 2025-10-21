import 'package:flutter/material.dart';

class LifestyleSection extends StatelessWidget {
  const LifestyleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      color: Colors.black,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEC4899), Color(0xFFF59E0B)],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFEC4899).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.photo_library, color: Colors.white, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'LIFESTYLE',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              const Text(
                'More Than a Product, It\'s a Lifestyle',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 46,
                  fontWeight: FontWeight.w900,
                  height: 1.2,
                  letterSpacing: -1,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 30),
              
              Text(
                'Join thousands who have transformed their daily routine.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey[400],
                  height: 1.6,
                  fontWeight: FontWeight.w400,
                ),
              ),
              
              const SizedBox(height: 80),
              
              // Lifestyle Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  return _buildMasonryGrid(constraints.maxWidth);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMasonryGrid(double maxWidth) {
    final isWide = maxWidth > 900;
    
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildLifestyleImage(
                  'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=600&h=800&fit=crop',
                  'Morning Routine',
                  400,
                ),
                const SizedBox(height: 20),
                _buildLifestyleImage(
                  'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=600&h=400&fit=crop',
                  'Work From Anywhere',
                  250,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _buildLifestyleImage(
                  'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600&h=400&fit=crop',
                  'Travel Ready',
                  250,
                ),
                const SizedBox(height: 20),
                _buildLifestyleImage(
                  'https://images.unsplash.com/photo-1556741533-6e6a62bd8b49?w=600&h=800&fit=crop',
                  'Perfect For Fitness',
                  400,
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _buildLifestyleImage(
                  'https://images.unsplash.com/photo-1552581234-26160f608093?w=600&h=800&fit=crop',
                  'Family Approved',
                  400,
                ),
                const SizedBox(height: 20),
                _buildLifestyleImage(
                  'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=600&h=400&fit=crop',
                  'Professional Use',
                  250,
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildLifestyleImage(
            'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?w=600&h=400&fit=crop',
            'Morning Routine',
            300,
          ),
          const SizedBox(height: 20),
          _buildLifestyleImage(
            'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=600&h=400&fit=crop',
            'Work From Anywhere',
            300,
          ),
          const SizedBox(height: 20),
          _buildLifestyleImage(
            'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600&h=400&fit=crop',
            'Travel Ready',
            300,
          ),
          const SizedBox(height: 20),
          _buildLifestyleImage(
            'https://images.unsplash.com/photo-1552581234-26160f608093?w=600&h=400&fit=crop',
            'Family Approved',
            300,
          ),
        ],
      );
    }
  }

  Widget _buildLifestyleImage(String imageUrl, String caption, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFEC4899).withOpacity(0.3),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(color: Colors.grey[800]);
                },
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                caption,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
