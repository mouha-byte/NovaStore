import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/app_theme.dart';

// =========================
// RESPONSIVE CONTAINER
// =========================
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: Breakpoints.getMaxWidth(context),
        ),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: child,
      ),
    );
  }
}

// =========================
// GRADIENT BUTTON
// =========================
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 56,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: AppRadius.circular12,
        boxShadow: AppShadows.md,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: AppRadius.circular12,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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

// =========================
// FEATURE CARD
// =========================
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.circular12,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: AppRadius.circular8,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideX();
  }
}

// =========================
// REVIEW CARD
// =========================
class ReviewCard extends StatelessWidget {
  final String name;
  final String rating;
  final String text;

  const ReviewCard({
    super.key,
    required this.name,
    required this.rating,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.circular16,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: List.generate(
                        int.parse(rating),
                        (index) => const Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            text,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// FAQ ITEM
// =========================
class FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const FAQItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              answer,
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// PRICE TAG
// =========================
class PriceTag extends StatelessWidget {
  final double price;
  final double? compareAtPrice;
  final int? discount;
  final double fontSize;

  const PriceTag({
    super.key,
    required this.price,
    this.compareAtPrice,
    this.discount,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (compareAtPrice != null && compareAtPrice! > price) ...[
          Text(
            '\$${compareAtPrice!.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: fontSize * 0.6,
              color: AppColors.textSecondary,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: AppColors.success,
          ),
        ),
        if (discount != null && discount! > 0) ...[
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.error,
              borderRadius: AppRadius.circular8,
            ),
            child: Text(
              '-$discount%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ],
    ).animate().fadeIn(delay: 100.ms).scale();
  }
}

// =========================
// COUNTDOWN TIMER
// =========================
class CountdownTimer extends StatefulWidget {
  final Duration duration;

  const CountdownTimer({
    super.key,
    this.duration = const Duration(hours: 24),
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Duration _remaining;

  @override
  void initState() {
    super.initState();
    _remaining = widget.duration;
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _remaining.inSeconds > 0) {
        setState(() {
          _remaining -= const Duration(seconds: 1);
        });
        _startTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final hours = _remaining.inHours;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: AppRadius.circular12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time, color: Colors.white, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(
            'Offer ends in: ${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().shimmer(delay: 1000.ms, duration: 2000.ms);
  }
}

// =========================
// SCARCITY BADGE
// =========================
class ScarcityBadge extends StatelessWidget {
  final int soldCount;
  final int? stock;

  const ScarcityBadge({
    super.key,
    required this.soldCount,
    this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.warning.withOpacity(0.1),
        borderRadius: AppRadius.circular8,
        border: Border.all(color: AppColors.warning),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: AppColors.warning, size: 16),
          const SizedBox(width: 4),
          Text(
            '$soldCount+ sold ${stock != null && stock! < 50 ? "• Only $stock left!" : ""}',
            style: const TextStyle(
              color: AppColors.warning,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().shake(delay: 500.ms);
  }
}

// =========================
// SHIMMER LOADING
// =========================
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: borderRadius ?? AppRadius.circular8,
      ),
    ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(duration: 1500.ms, color: Colors.white);
  }
}
