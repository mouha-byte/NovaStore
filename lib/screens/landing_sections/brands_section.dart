import 'package:flutter/material.dart';

class BrandsSection extends StatefulWidget {
  const BrandsSection({super.key});

  @override
  State<BrandsSection> createState() => _BrandsSectionState();
}

class _BrandsSectionState extends State<BrandsSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ScrollController _scrollController;

  final List<Map<String, dynamic>> _brands = [
    {'name': 'TechCrunch', 'logo': '🚀'},
    {'name': 'Forbes', 'logo': '📰'},
    {'name': 'Wired', 'logo': '⚡'},
    {'name': 'The Verge', 'logo': '🔷'},
    {'name': 'Mashable', 'logo': '🌐'},
    {'name': 'Engadget', 'logo': '📱'},
    {'name': 'CNET', 'logo': '💻'},
    {'name': 'Fast Company', 'logo': '⚡'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );
    
    _controller.addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = maxScroll * _controller.value;
        _scrollController.jumpTo(currentScroll);
      }
    });
    
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[50]!,
            Colors.white,
            Colors.grey[50]!,
          ],
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              const Text(
                'Featured In',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                  letterSpacing: 2,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // Brand Carousel
              SizedBox(
                height: 100,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: _brands.length * 2, // Duplicate for infinite scroll
                  itemBuilder: (context, index) {
                    final brand = _brands[index % _brands.length];
                    return _buildBrandCard(brand['logo']!, brand['name']!);
                  },
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Stats
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 800;
                  return Wrap(
                    alignment: WrapAlignment.center,
                    spacing: isWide ? 60 : 20,
                    runSpacing: 30,
                    children: [
                      _buildBrandStat('50K+', 'Happy Customers'),
                      _buildBrandStat('4.9★', 'Average Rating'),
                      _buildBrandStat('98%', 'Satisfaction Rate'),
                      _buildBrandStat('24/7', 'Support Available'),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandCard(String logo, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            logo,
            style: const TextStyle(fontSize: 32),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Color(0xFF8B5CF6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
