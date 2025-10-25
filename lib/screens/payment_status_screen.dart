import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentStatusScreen extends StatefulWidget {
  const PaymentStatusScreen({super.key});

  @override
  State<PaymentStatusScreen> createState() => _PaymentStatusScreenState();
}

class _PaymentStatusScreenState extends State<PaymentStatusScreen> {
  bool _isProcessing = true;
  String _statusMessage = 'Processing your payment...';
  Map<String, dynamic>? _paymentData;

  @override
  void initState() {
    super.initState();
    _processPaymentStatus();
  }

  Future<void> _processPaymentStatus() async {
    try {
      // Get payment parameters from URL (in web app)
      // For now, simulate processing
      await Future.delayed(const Duration(seconds: 2));

      // Here you would:
      // 1. Verify payment with Payeer API
      // 2. Update order status in Firestore
      // 3. Mark order as paid
      // 4. Send confirmation email

      setState(() {
        _isProcessing = false;
        _statusMessage = 'Payment verification complete';
        _paymentData = {
          'orderId': 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
          'amount': '99.99',
          'currency': 'USD',
          'status': 'success',
          'timestamp': DateTime.now(),
        };
      });

      // Update Firestore order
      await _updateOrderStatus();

      // Redirect to success page after verification
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/payment-success');
        }
      });
    } catch (e) {
      setState(() {
        _isProcessing = false;
        _statusMessage = 'Payment verification failed';
      });

      // Redirect to failed page
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/payment-failed');
        }
      });
    }
  }

  Future<void> _updateOrderStatus() async {
    try {
      if (_paymentData != null) {
        // Update order in Firestore
        await FirebaseFirestore.instance
            .collection('orders')
            .doc(_paymentData!['orderId'])
            .set({
          'status': 'paid',
          'paymentStatus': 'completed',
          'paidAt': FieldValue.serverTimestamp(),
          'paymentMethod': 'payeer',
          'amount': _paymentData!['amount'],
          'currency': _paymentData!['currency'],
        }, SetOptions(merge: true));

        print('Order ${_paymentData!['orderId']} marked as paid');
      }
    } catch (e) {
      print('Error updating order status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Loading or Status Icon
                if (_isProcessing)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B5CF6).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF8B5CF6),
                        ),
                        strokeWidth: 4,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF10B981).withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.verified_rounded,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),

                const SizedBox(height: 40),

                // Status Message
                Text(
                  _statusMessage,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                if (_isProcessing)
                  Text(
                    'Please wait while we verify your payment with Payeer...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  )
                else if (_paymentData != null)
                  Column(
                    children: [
                      Text(
                        'Your payment has been verified successfully.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            _buildDetailRow(
                              'Order ID',
                              _paymentData!['orderId'],
                            ),
                            const Divider(height: 24),
                            _buildDetailRow(
                              'Amount',
                              '\$${_paymentData!['amount']}',
                            ),
                            const Divider(height: 24),
                            _buildDetailRow(
                              'Status',
                              'Paid',
                              valueColor: const Color(0xFF10B981),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 40),

                // Progress Indicators
                if (_isProcessing)
                  Column(
                    children: [
                      _buildProgressStep('Verifying payment', true),
                      _buildProgressStep('Updating order status', false),
                      _buildProgressStep('Sending confirmation', false),
                    ],
                  ),

                if (!_isProcessing)
                  const Text(
                    'Redirecting you shortly...',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8B5CF6),
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

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: valueColor ?? Colors.grey[800],
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressStep(String text, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive
                  ? const Color(0xFF8B5CF6)
                  : Colors.grey[300],
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isActive ? Colors.grey[800] : Colors.grey[400],
              fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
