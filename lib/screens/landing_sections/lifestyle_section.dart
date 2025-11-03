import 'package:flutter/material.dart';
import 'landing_constants.dart';

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
              _buildBadge(),
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildSubtitle(),
              const SizedBox(height: 80),
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

  Widget _buildBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [LandingConstants.pinkAccent, LandingConstants.yellowAccent],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.pinkAccent.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.photo_library, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            LandingConstants.lifestyleBadge,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      LandingConstants.lifestyleTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -1,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      LandingConstants.lifestyleSubtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[400],
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildMasonryGrid(double maxWidth) {
    final isWide = maxWidth > 900;
    final images = LandingConstants.lifestyleImages;
    
    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                _buildLifestyleImage(images[0].imageUrl, images[0].caption, images[0].height),
                const SizedBox(height: 20),
                _buildLifestyleImage(images[1].imageUrl, images[1].caption, images[1].height),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _buildLifestyleImage(images[2].imageUrl, images[2].caption, images[2].height),
                const SizedBox(height: 20),
                _buildLifestyleImage(images[3].imageUrl, images[3].caption, images[3].height),
              ],
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              children: [
                _buildLifestyleImage(images[4].imageUrl, images[4].caption, images[4].height),
                const SizedBox(height: 20),
                _buildLifestyleImage(images[5].imageUrl, images[5].caption, images[5].height),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: images
            .take(4)
            .map((img) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildLifestyleImage(img.imageUrl, img.caption, 300),
                ))
            .toList(),
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
            color: LandingConstants.pinkAccent.withOpacity(0.3),
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
