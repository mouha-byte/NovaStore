import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../models/order_model.dart';
import 'package:intl/intl.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String orderId;

  const OrderConfirmationScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final formatter = NumberFormat.currency(symbol: '\$');

    return Scaffold(
      appBar: AppBar(title: const Text('Commande confirmée')),
      body: FutureBuilder<OrderModel?>(
        future: firestoreService.getOrder(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Commande non trouvée'));
          }

          final order = snapshot.data!;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Commande confirmée !',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Numéro de commande:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(order.id),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Montant total:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            formatter.format(order.totalPrice),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      const Text('Adresse de livraison:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(order.shippingAddress['address'] ?? ''),
                      Text(
                          '${order.shippingAddress['zip']} ${order.shippingAddress['city']}'),
                      Text(order.shippingAddress['country'] ?? ''),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Statut:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          _getStatusChip(order.status),
                        ],
                      ),
                      if (order.trackingNumber != null) ...[
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Numéro de suivi:',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(order.trackingNumber!),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/orders',
                    (route) => route.settings.name == '/home',
                  );
                },
                child: const Text('Voir mes commandes'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
                },
                child: const Text('Retour à l\'accueil'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getStatusChip(String status) {
    Color color;
    String label;
    switch (status) {
      case 'delivered':
        color = Colors.green;
        label = 'Livré';
        break;
      case 'shipped':
        color = Colors.blue;
        label = 'Expédié';
        break;
      case 'purchased':
        color = Colors.orange;
        label = 'Acheté';
        break;
      default:
        color = Colors.grey;
        label = 'En attente';
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }
}
