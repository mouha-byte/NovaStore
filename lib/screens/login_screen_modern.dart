import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/auth_service.dart';
import '../utils/app_theme.dart';
import '../widgets/modern_widgets.dart';
import '../widgets/nova_store_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  
  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      if (_isLogin) {
        await authService.login(_emailController.text.trim(), _passwordController.text);
      } else {
        await authService.register(
          _emailController.text.trim(),
          _passwordController.text,
          name: _nameController.text.trim(),
        );
      }

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(context);

    return Scaffold(
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLogo(),
          const SizedBox(height: AppSpacing.xxl),
          _buildForm(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // Left side - Brand
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(isLarge: true),
                  const SizedBox(height: AppSpacing.xl),
                  const Text(
                    'Join thousands of happy customers',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Right side - Form
        Expanded(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(AppSpacing.xxl),
              child: _buildForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo({bool isLarge = false}) {
    return Column(
      children: [
        NovaStoreLogo(
          size: isLarge ? 120 : 80,
          showText: false,
        ).animate().fadeIn().scale(),
        SizedBox(height: isLarge ? AppSpacing.lg : AppSpacing.md),
        NovaStoreLogo(
          size: isLarge ? 60 : 40,
          showText: true,
          color: isLarge ? Colors.white : null,
        ).animate().fadeIn(delay: 200.ms),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _isLogin ? 'Welcome Back' : 'Create Account',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ).animate().fadeIn().slideX(),
          
          const SizedBox(height: AppSpacing.sm),
          
          Text(
            _isLogin
                ? 'Sign in to continue shopping'
                : 'Sign up to start your journey',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ).animate().fadeIn(delay: 100.ms),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Name field (only for register)
          if (!_isLogin) ...[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ).animate().fadeIn(delay: 200.ms).slideX(),
            const SizedBox(height: AppSpacing.md),
          ],
          
          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ).animate().fadeIn(delay: 300.ms).slideX(),
          
          const SizedBox(height: AppSpacing.md),
          
          // Password field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ).animate().fadeIn(delay: 400.ms).slideX(),
          
          const SizedBox(height: AppSpacing.xl),
          
          // Submit button
          GradientButton(
            text: _isLogin ? 'Sign In' : 'Sign Up',
            onPressed: _submit,
            isLoading: _isLoading,
            icon: _isLogin ? Icons.login : Icons.person_add,
          ).animate().fadeIn(delay: 500.ms).scale(),
          
          const SizedBox(height: AppSpacing.lg),
          
          // Or continue as guest
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text('Continue as Guest'),
          ).animate().fadeIn(delay: 600.ms),
          
          const SizedBox(height: AppSpacing.md),
          
          // Toggle login/register
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isLogin ? 'Don\'t have an account?' : 'Already have an account?',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _isLogin = !_isLogin);
                },
                child: Text(_isLogin ? 'Sign Up' : 'Sign In'),
              ),
            ],
          ).animate().fadeIn(delay: 700.ms),
        ],
      ),
    );
  }
}
