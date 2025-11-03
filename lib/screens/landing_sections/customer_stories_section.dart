import 'package:flutter/material.dart';
import 'landing_constants.dart';

class CustomerStoriesSection extends StatelessWidget {
  const CustomerStoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      color: Colors.white,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              _buildBadge(),
              const SizedBox(height: 40),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildSubtitle(),
              const SizedBox(height: 80),
              _buildStories(),
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
        gradient: const LinearGradient(
          colors: [Color(0xFF06B6D4), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF06B6D4).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_stories, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            LandingConstants.storiesBadge,
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
      LandingConstants.storiesTitle,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 46,
        fontWeight: FontWeight.w900,
        height: 1.2,
        letterSpacing: -1,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Text(
      LandingConstants.storiesSubtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[600],
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildStories() {
    return Column(
      children: LandingConstants.customerStories.asMap().entries.map((entry) {
        final index = entry.key;
        final story = entry.value;
        return Column(
          children: [
            if (index > 0) const SizedBox(height: 40),
            _buildStoryCard(
              story.title,
              story.subtitle,
              story.story,
              story.imageUrl,
              Color(story.accentColorValue),
              story.imageOnLeft,
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStoryCard(
    String title,
    String subtitle,
    String story,
    String imageUrl,
    Color accentColor,
    bool imageOnLeft,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accentColor.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          
          if (isWide) {
            final imageWidget = Expanded(
              flex: 2,
              child: ClipRRect(
                borderRadius: imageOnLeft 
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(22),
                        bottomRight: Radius.circular(22),
                      ),
                child: Image.network(
                  imageUrl,
                  height: 350,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 350,
                      color: Colors.grey[300],
                    );
                  },
                ),
              ),
            );
            
            final contentWidget = Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: accentColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      story,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        height: 1.8,
                      ),
                    ),
                  ],
                ),
              ),
            );
            
            return Row(
              children: imageOnLeft 
                  ? [imageWidget, contentWidget]
                  : [contentWidget, imageWidget],
            );
          } else {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(22),
                    topRight: Radius.circular(22),
                  ),
                  child: Image.network(
                    imageUrl,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        color: Colors.grey[300],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: accentColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        story,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[700],
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
