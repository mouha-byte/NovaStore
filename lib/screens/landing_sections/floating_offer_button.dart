import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'landing_constants.dart';

/// Bouton flottant pour l'offre limitée
/// Positionné en bas à gauche de la page
class FloatingOfferButton extends StatefulWidget {
  final Duration timeRemaining;
  final VoidCallback onTap;

  const FloatingOfferButton({
    super.key,
    required this.timeRemaining,
    required this.onTap,
  });

  @override
  State<FloatingOfferButton> createState() => _FloatingOfferButtonState();
}

class _FloatingOfferButtonState extends State<FloatingOfferButton> {
  bool _isVisible = true;
  bool _isDismissed = false;
  Timer? _toggleTimer;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    _isDismissed = prefs.getBool('offer_button_dismissed') ?? false;
    if (!mounted) return;
    setState(() {
      _isVisible = !_isDismissed;
    });
    if (!_isDismissed) {
      _startToggleTimer();
    }
  }

  void _startToggleTimer() {
    _toggleTimer?.cancel();
    _toggleTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted || _isDismissed) return;
      setState(() {
        _isVisible = !_isVisible;
      });
    });
  }

  Future<void> _dismissForever() async {
    _toggleTimer?.cancel();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('offer_button_dismissed', true);
    if (!mounted) return;
    setState(() {
      _isDismissed = true;
      _isVisible = false;
    });
  }

  String _formatTime(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _toggleTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Masquer sur mobile
    if (MediaQuery.of(context).size.width < 768) {
      return const SizedBox.shrink();
    }

    if (_isDismissed || !_isVisible) {
      return const SizedBox.shrink();
    }

    return Positioned(
      left: 20,
      bottom: 20,
      child: Material(
        color: Colors.transparent,
        elevation: 8,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 220),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  LandingConstants.redProblem.withOpacity(0.95),
                  const Color(0xFFDC2626).withOpacity(0.95),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: LandingConstants.redProblem.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Bouton de suppression
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '50% RÉDUCTION',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    InkWell(
                      onTap: _dismissForever,
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Countdown
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.white,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatTime(widget.timeRemaining),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                // CTA
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Get It',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: LandingConstants.redProblem,
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
