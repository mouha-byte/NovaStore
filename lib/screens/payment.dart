import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatefulWidget {
  final Map<String, dynamic>? orderData;

  const PaymentScreen({super.key, this.orderData});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final String apiKey = 'VB0SVSN-TCZMVMQ-H1RV5MZ-QKB3656';
  final String payoutAddress = '0xf3337a01dedad3fada7d9a527c58362f20758c42';
  final String successUrl = 'https://novaaimarket.com/success';
  final String cancelUrl = 'https://novaaimarket.com/fail';

  bool isLoading = false;
  String? paymentUrl;
  double _amount = 0;
  String? _paymentMethod;

  @override
  void initState() {
    super.initState();
    if (widget.orderData != null) {
      _amount = widget.orderData!['totalPrice'] ?? 0.0;
      _paymentMethod = widget.orderData!['paymentMethod'];
      print('DEBUG: Order data received: ${widget.orderData}');
      print('DEBUG: Amount set to: $_amount');
      print('DEBUG: Payment method: $_paymentMethod');
    }
  }

  Future<void> createInvoice({
    required double priceAmount,
    required String priceCurrency,
  }) async {
    print('DEBUG: createInvoice called with amount: $priceAmount, currency: $priceCurrency');
    setState(() => isLoading = true);

    final url = Uri.parse('https://api.nowpayments.io/v1/invoice');
    final headers = {
      'x-api-key': apiKey,
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      "price_amount": priceAmount,
      "price_currency": priceCurrency.toLowerCase(),
    });

    try {
      print('DEBUG: Sending request to NOWPayments...');
      final response = await http.post(url, headers: headers, body: body);
      print('DEBUG: Response status: ${response.statusCode}');
      print('DEBUG: Response body: ${response.body}');
      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          paymentUrl = data['invoice_url'];
          isLoading = false;
        });
        print('DEBUG: Payment URL: $paymentUrl');
        _launchPayment();
      } else {
        print('DEBUG: API Error - ${data['message'] ?? 'Unknown'}');
        _showError('Error: ${data['message'] ?? 'Unknown'}');
      }
    } catch (e) {
      print('DEBUG: Exception caught: $e');
      _showError('Network error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _launchPayment() async {
    if (paymentUrl != null && await canLaunch(paymentUrl!)) {
      await launch(paymentUrl!);
    } else {
      _showError('Could not open payment page');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.orderData != null) ...[
              const Text(
                'Order Summary',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildOrderDetail('Total Amount:', '\$${_amount.toStringAsFixed(2)}'),
              _buildOrderDetail('Payment Method:', _paymentMethod ?? 'N/A'),
              const Divider(height: 40),
            ],
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: 1==1
                    ? () {
                        print('DEBUG: Button pressed! Amount: $_amount, Loading: $isLoading');
                        createInvoice(
                          priceAmount: 27.99,
                          priceCurrency: 'usd',
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Pay with Card or Crypto USDT, BTC +200 …',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green.shade700),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Pay with your credit/debit card or choose from 200+ options. Fast, secure, and convenient.',
                      style: TextStyle(
                        color: Colors.green.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
