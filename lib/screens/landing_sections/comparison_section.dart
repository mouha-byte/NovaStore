import 'package:flutter/material.dart';
import 'landing_constants.dart';

class ComparisonSection extends StatelessWidget {
  const ComparisonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFF5F3FF),
            Colors.white,
            Color(0xFFEDE9FE),
          ],
        ),
      ),
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
              _buildComparisonTable(),
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
          colors: [LandingConstants.secondaryColor, LandingConstants.primaryColor],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.secondaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.compare_arrows, color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Text(
            LandingConstants.comparisonBadge,
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
      LandingConstants.comparisonTitle,
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
      LandingConstants.comparisonSubtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
        color: Colors.grey[600],
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildComparisonTable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        return isWide ? _buildWideTable() : _buildNarrowTable();
      },
    );
  }

  Widget _buildWideTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: LandingConstants.secondaryColor.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.secondaryColor.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          ...LandingConstants.comparisonFeatures
              .map((feature) => _buildComparisonRow(feature))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [LandingConstants.secondaryColor, LandingConstants.primaryColor],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22),
          topRight: Radius.circular(22),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              'Caractéristique',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Autres',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Basique',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Notre Produit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: LandingConstants.yellowAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Premium',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNarrowTable() {
    return Column(
      children: LandingConstants.comparisonFeatures
          .map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildMobileComparisonCard(feature),
              ))
          .toList(),
    );
  }

  Widget _buildComparisonRow(ComparisonFeature feature) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              feature.feature,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: feature.others
                  ? const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28)
                  : const Icon(Icons.cancel, color: Color(0xFFEF4444), size: 28),
            ),
          ),
          Expanded(
            child: Center(
              child: feature.ours
                  ? Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
                    )
                  : const Icon(Icons.cancel, color: Color(0xFFEF4444), size: 28),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileComparisonCard(ComparisonFeature feature) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: LandingConstants.secondaryColor.withOpacity(0.2), width: 2),
        boxShadow: [
          BoxShadow(
            color: LandingConstants.secondaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            feature.feature,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'Autres',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8),
                  feature.others
                      ? const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 32)
                      : const Icon(Icons.cancel, color: Color(0xFFEF4444), size: 32),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Notre Produit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: LandingConstants.secondaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  feature.ours
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.check_circle, color: Color(0xFF10B981), size: 32),
                        )
                      : const Icon(Icons.cancel, color: Color(0xFFEF4444), size: 32),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
