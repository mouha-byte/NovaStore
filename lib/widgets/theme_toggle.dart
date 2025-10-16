import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/theme_service.dart';
import '../utils/app_theme.dart';

class ThemeToggle extends StatelessWidget {
  final bool showLabel;

  const ThemeToggle({
    super.key,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDark = themeService.isDarkMode || 
                   (themeService.isSystemMode && 
                    MediaQuery.of(context).platformBrightness == Brightness.dark);

    return InkWell(
      onTap: () => themeService.toggleTheme(),
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isDark 
              ? AppColorsDark.surface 
              : AppColorsLight.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isDark 
                ? AppColorsDark.border 
                : AppColorsLight.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: AppAnimations.normal,
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: animation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: Icon(
                isDark ? Icons.dark_mode : Icons.light_mode,
                key: ValueKey(isDark),
                color: isDark 
                    ? AppColorsDark.warning 
                    : AppColorsLight.warning,
                size: 20,
              ),
            ),
            if (showLabel) ...[
              const SizedBox(width: 8),
              Text(
                isDark ? 'Dark' : 'Light',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 3000.ms,
          color: (isDark ? AppColorsDark.primary : AppColorsLight.primary)
              .withOpacity(0.1),
        );
  }
}

// Modal Bottom Sheet pour choisir le theme mode
class ThemePickerSheet extends StatelessWidget {
  const ThemePickerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Title
          Text(
            'Choose Theme',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),

          // Light Mode
          _ThemeOption(
            icon: Icons.light_mode,
            title: 'Light Mode',
            subtitle: 'Best for daytime',
            isSelected: themeService.isLightMode,
            onTap: () {
              themeService.setThemeMode(ThemeMode.light);
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 12),

          // Dark Mode
          _ThemeOption(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            subtitle: 'Easy on the eyes',
            isSelected: themeService.isDarkMode,
            onTap: () {
              themeService.setThemeMode(ThemeMode.dark);
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 12),

          // System Mode
          _ThemeOption(
            icon: Icons.brightness_auto,
            title: 'System Default',
            subtitle: 'Follows device settings',
            isSelected: themeService.isSystemMode,
            onTap: () {
              themeService.setThemeMode(ThemeMode.system);
              Navigator.pop(context);
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).dividerColor,
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(AppRadius.md),
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                : Colors.transparent,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).iconTheme.color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_circle,
                  color: Theme.of(context).colorScheme.primary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Simple Icon Button version
class ThemeToggleIconButton extends StatelessWidget {
  const ThemeToggleIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.brightness_6),
      tooltip: 'Change Theme',
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          builder: (_) => const ThemePickerSheet(),
        );
      },
    );
  }
}
