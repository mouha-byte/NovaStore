import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../utils/app_theme.dart';
import '../widgets/modern_widgets.dart';

class CheckoutScreen extends StatefulWidget {
  final ProductModel product;
  final ProductVariant? variant;

  const CheckoutScreen({
    super.key,
    required this.product,
    this.variant,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _zipController = TextEditingController();
  final _phoneController = TextEditingController();

  String _paymentMethod = 'wallet'; // 'wallet' or 'payeer'
  bool _isProcessing = false;

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  double get _productPrice => widget.variant?.price ?? widget.product.price;
  double get _shippingCost => 0.0; // Free shipping
  double get _totalPrice => _productPrice + _shippingCost;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        elevation: 0,
      ),
      body: ResponsiveContainer(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildOrderSummary(),
                  const SizedBox(height: AppSpacing.xl),
                  _buildShippingForm(),
                  const SizedBox(height: AppSpacing.xl),
                  _buildPaymentMethod(user),
                  const SizedBox(height: AppSpacing.xl),
                  _buildPriceBreakdown(),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildCheckoutButton(),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // =========================
  // ORDER SUMMARY
  // =========================
  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppRadius.circular16,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Product image
          ClipRRect(
            borderRadius: AppRadius.circular8,
            child: Image.network(
              widget.product.images.first,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: AppColors.border,
                  child: const Icon(Icons.image),
                );
              },
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          
          // Product info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.variant != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Variant: ${widget.variant!.title}',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  '\$${_productPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY();
  }

  // =========================
  // SHIPPING FORM
  // =========================
  Widget _buildShippingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn().slideX(),
        
        const SizedBox(height: AppSpacing.md),
        
        TextFormField(
          controller: _addressController,
          decoration: const InputDecoration(
            labelText: 'Street Address',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ).animate().fadeIn(delay: 100.ms).slideX(),
        
        const SizedBox(height: AppSpacing.md),
        
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 200.ms).slideX(),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: TextFormField(
                controller: _zipController,
                decoration: const InputDecoration(
                  labelText: 'ZIP Code',
                  prefixIcon: Icon(Icons.markunread_mailbox),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 300.ms).slideX(),
            ),
          ],
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            return null;
          },
        ).animate().fadeIn(delay: 400.ms).slideX(),
      ],
    );
  }

  // =========================
  // PAYMENT METHOD
  // =========================
  Widget _buildPaymentMethod(user) {
    final walletBalance = user?.walletBalance ?? 0.0;
    final hasEnoughBalance = walletBalance >= _totalPrice;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ).animate().fadeIn().slideX(),
        
        const SizedBox(height: AppSpacing.md),
        
        // Wallet option
        GestureDetector(
          onTap: user != null
              ? () => setState(() => _paymentMethod = 'wallet')
              : null,
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _paymentMethod == 'wallet' && hasEnoughBalance
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.white,
              borderRadius: AppRadius.circular12,
              border: Border.all(
                color: _paymentMethod == 'wallet' && hasEnoughBalance
                    ? AppColors.primary
                    : AppColors.border,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: 'wallet',
                  groupValue: _paymentMethod,
                  onChanged: user != null
                      ? (value) => setState(() => _paymentMethod = value!)
                      : null,
                  activeColor: AppColors.primary,
                ),
                const Icon(Icons.account_balance_wallet, size: 24, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wallet Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        user != null
                            ? '\$${walletBalance.toStringAsFixed(2)} available'
                            : 'Login to use wallet',
                        style: TextStyle(
                          fontSize: 14,
                          color: hasEnoughBalance
                              ? AppColors.success
                              : AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!hasEnoughBalance && user != null)
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/wallet'),
                    child: const Text('Add Funds'),
                  ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 100.ms).slideX(),
        
        const SizedBox(height: AppSpacing.md),
        
        // Payeer option
        GestureDetector(
          onTap: () => setState(() => _paymentMethod = 'payeer'),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: _paymentMethod == 'payeer'
                  ? AppColors.secondary.withOpacity(0.1)
                  : Colors.white,
              borderRadius: AppRadius.circular12,
              border: Border.all(
                color: _paymentMethod == 'payeer'
                    ? AppColors.secondary
                    : AppColors.border,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Radio<String>(
                  value: 'payeer',
                  groupValue: _paymentMethod,
                  onChanged: (value) => setState(() => _paymentMethod = value!),
                  activeColor: AppColors.secondary,
                ),
                const Icon(Icons.payment, size: 24, color: AppColors.secondary),
                const SizedBox(width: AppSpacing.sm),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pay with Payeer',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Secure payment gateway',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ).animate().fadeIn(delay: 200.ms).slideX(),
      ],
    );
  }

  // =========================
  // PRICE BREAKDOWN
  // =========================
  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: AppRadius.circular12,
      ),
      child: Column(
        children: [
          _buildPriceRow('Product Price', _productPrice),
          const Divider(),
          _buildPriceRow('Shipping', _shippingCost, isFree: true),
          const Divider(),
          _buildPriceRow('Total', _totalPrice, isTotal: true),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms).slideY();
  }

  Widget _buildPriceRow(String label, double amount, {bool isFree = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          Text(
            isFree ? 'FREE' : '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: isTotal ? 24 : 16,
              fontWeight: isTotal ? FontWeight.w900 : FontWeight.w600,
              color: isTotal ? AppColors.success : (isFree ? AppColors.success : AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // CHECKOUT BUTTON
  // =========================
  Widget _buildCheckoutButton() {
    return GradientButton(
      text: _isProcessing ? 'Processing...' : 'Place Order',
      icon: Icons.check_circle,
      isLoading: _isProcessing,
      onPressed: _processOrder,
      width: double.infinity,
      height: 56,
    ).animate().fadeIn(delay: 400.ms).scale();
  }

  // =========================
  // PROCESS ORDER
  // =========================
  Future<void> _processOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;

    // Check if user is logged in
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please login to place an order'),
          backgroundColor: AppColors.error,
        ),
      );
      Navigator.pushNamed(context, '/login');
      return;
    }

    // Check wallet balance if paying with wallet
    if (_paymentMethod == 'wallet' && user.walletBalance < _totalPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Insufficient wallet balance. Please add funds.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);

      if (_paymentMethod == 'wallet') {
        // Create order with wallet payment
        final order = OrderModel(
          id: '',
          userId: user.id,
          productId: widget.product.id,
          variantId: widget.variant?.variantId,
          totalPrice: _totalPrice,
          status: 'pending',
          shippingAddress: {
            'address': _addressController.text.trim(),
            'city': _cityController.text.trim(),
            'zip': _zipController.text.trim(),
            'phone': _phoneController.text.trim(),
          },
          createdAt: DateTime.now(),
        );
        
        final orderId = await firestoreService.createOrder(order);

        // Deduct from wallet
        await firestoreService.updateUserBalance(
          user.id,
          user.walletBalance - _totalPrice,
        );

        // Refresh user data
        await authService.refreshUserData();

        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            '/order-confirmation',
            arguments: orderId,
          );
        }
      } else {
        // Payeer payment
        final payeerUrl = _generatePayeerUrl();
        if (await canLaunchUrl(Uri.parse(payeerUrl))) {
          await launchUrl(Uri.parse(payeerUrl), mode: LaunchMode.externalApplication);
          
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Redirecting to Payeer...'),
                backgroundColor: AppColors.info,
              ),
            );
          }
        } else {
          throw Exception('Could not launch Payeer');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  String _generatePayeerUrl() {
    // TODO: Replace with your Payeer merchant details
    const merchantId = AppConstants.payeerMerchantId;
    final amount = _totalPrice.toStringAsFixed(2);
    final description = 'Order: ${widget.product.title}';
    
    return 'https://payeer.com/merchant/?m_shop=$merchantId&m_orderid=${DateTime.now().millisecondsSinceEpoch}&m_amount=$amount&m_curr=USD&m_desc=$description';
  }
}
