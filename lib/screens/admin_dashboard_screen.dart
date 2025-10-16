import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/firestore_service.dart';
import '../models/product_model.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_product_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Statistiques', icon: Icon(Icons.analytics, size: 20)),
                Tab(text: 'Commandes', icon: Icon(Icons.shopping_cart, size: 20)),
                Tab(text: 'Produits', icon: Icon(Icons.inventory, size: 20)),
                Tab(text: 'Utilisateurs', icon: Icon(Icons.people, size: 20)),
                Tab(text: 'Dépôts', icon: Icon(Icons.account_balance_wallet, size: 20)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _StatisticsTab(),
                  _OrdersTab(),
                  _ProductsTab(),
                  _UsersTab(),
                  _DepositsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// ONGLET STATISTIQUES
// =========================
class _StatisticsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final formatter = NumberFormat.currency(symbol: '\$');

    return StreamBuilder(
      stream: firestoreService.getAllOrders(),
      builder: (context, ordersSnapshot) {
        return StreamBuilder(
          stream: firestoreService.getAllDeposits(),
          builder: (context, depositsSnapshot) {
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, usersSnapshot) {
                return StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('products').snapshots(),
                  builder: (context, productsSnapshot) {
                    if (!ordersSnapshot.hasData ||
                        !depositsSnapshot.hasData ||
                        !usersSnapshot.hasData ||
                        !productsSnapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final orders = ordersSnapshot.data ?? [];
                    final deposits = depositsSnapshot.data ?? [];
                    final usersCount = usersSnapshot.data!.docs.length;
                    final productsCount = productsSnapshot.data!.docs.length;

                    // Calculs
                    final totalOrders = orders.length;
                    final totalRevenue = orders.fold(0.0, (sum, order) => sum + order.totalPrice);
                    final pendingOrders = orders.where((o) => o.status == 'pending').length;
                    final deliveredOrders = orders.where((o) => o.status == 'delivered').length;
                    final totalDeposits = deposits.fold(0.0, (sum, d) => sum + d.amount);
                    final approvedDeposits = deposits.where((d) => d.status == 'approved').length;

                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Text(
                          'Vue d\'ensemble',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        // Statistiques principales
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 1.5,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: [
                            _StatCard(
                              title: 'Commandes',
                              value: '$totalOrders',
                              icon: Icons.shopping_cart,
                              color: Colors.blue,
                            ),
                            _StatCard(
                              title: 'Revenus',
                              value: formatter.format(totalRevenue),
                              icon: Icons.attach_money,
                              color: Colors.green,
                            ),
                            _StatCard(
                              title: 'Utilisateurs',
                              value: '$usersCount',
                              icon: Icons.people,
                              color: Colors.orange,
                            ),
                            _StatCard(
                              title: 'Produits',
                              value: '$productsCount',
                              icon: Icons.inventory,
                              color: Colors.purple,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        // Détails commandes
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Détails Commandes',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Divider(),
                                _InfoRow('En attente', '$pendingOrders', Colors.orange),
                                _InfoRow('Livrées', '$deliveredOrders', Colors.green),
                                _InfoRow('Total', '$totalOrders', Colors.blue),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Détails dépôts
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Détails Dépôts',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                const Divider(),
                                _InfoRow('Approuvés', '$approvedDeposits', Colors.green),
                                _InfoRow('Total dépôts', formatter.format(totalDeposits), Colors.blue),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _InfoRow(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// =========================
// ONGLET COMMANDES
// =========================
class _OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final formatter = NumberFormat.currency(symbol: '\$');

    return StreamBuilder(
      stream: firestoreService.getAllOrders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('Aucune commande'),
              ],
            ),
          );
        }

        final orders = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: Icon(
                  Icons.shopping_bag,
                  color: _getOrderStatusColor(order.status),
                ),
                title: Text('Commande #${order.id.substring(0, 8)}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatter.format(order.totalPrice)),
                    Text(
                      DateFormat('dd/MM/yyyy HH:mm').format(order.createdAt),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                trailing: _getStatusChip(order.status),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User ID: ${order.userId}'),
                        Text('Product ID: ${order.productId}'),
                        if (order.variantId != null) Text('Variant: ${order.variantId}'),
                        const SizedBox(height: 8),
                        const Text('Adresse:', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(order.shippingAddress['address'] ?? ''),
                        Text('${order.shippingAddress['zip']} ${order.shippingAddress['city']}'),
                        const SizedBox(height: 8),
                        if (order.trackingNumber != null) Text('Tracking: ${order.trackingNumber}'),
                        const SizedBox(height: 16),
                        const Text('Actions:', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () => _acceptOrder(context, order.id),
                              icon: const Icon(Icons.check, size: 16),
                              label: const Text('Accepter'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _rejectOrder(context, order.id),
                              icon: const Icon(Icons.close, size: 16),
                              label: const Text('Refuser'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _updateOrderStatusWithTracking(context, order.id),
                              icon: const Icon(Icons.local_shipping, size: 16),
                              label: const Text('Expédié'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => _updateOrderStatus(context, order.id, 'delivered'),
                              icon: const Icon(Icons.done_all, size: 16),
                              label: const Text('Livré'),
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Color _getOrderStatusColor(String status) {
    switch (status) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'purchased':
      case 'accepted':
        return Colors.orange;
      case 'refunded':
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
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
      case 'accepted':
        color = Colors.orange;
        label = status == 'accepted' ? 'Accepté' : 'Acheté';
        break;
      case 'rejected':
        color = Colors.red;
        label = 'Refusé';
        break;
      default:
        color = Colors.grey;
        label = 'En attente';
    }

    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold),
    );
  }

  Future<void> _acceptOrder(BuildContext context, String orderId) async {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    await firestoreService.updateOrderStatus(orderId, 'accepted');
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Commande acceptée'), backgroundColor: Colors.green),
      );
    }
  }

  Future<void> _rejectOrder(BuildContext context, String orderId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Refuser la commande?'),
        content: const Text('Cette action ne peut pas être annulée.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Refuser'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final firestoreService = Provider.of<FirestoreService>(context, listen: false);
      await firestoreService.updateOrderStatus(orderId, 'rejected');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ Commande refusée'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _updateOrderStatus(BuildContext context, String orderId, String status) async {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    await firestoreService.updateOrderStatus(orderId, status);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Statut mis à jour')),
      );
    }
  }

  Future<void> _updateOrderStatusWithTracking(BuildContext context, String orderId) async {
    final trackingController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Numéro de suivi'),
        content: TextField(
          controller: trackingController,
          decoration: const InputDecoration(
            labelText: 'Tracking number',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _updateOrderStatus(context, orderId, 'shipped');
              if (trackingController.text.isNotEmpty) {
                Provider.of<FirestoreService>(context, listen: false).updateOrderStatus(
                  orderId,
                  'shipped',
                  trackingNumber: trackingController.text,
                );
              }
            },
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }
}

// =========================
// ONGLET PRODUITS
// =========================
class _ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final formatter = NumberFormat.currency(symbol: '\$');

    return StreamBuilder<List<ProductModel>>(
      stream: firestoreService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inventory_outlined, size: 64, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('Aucun produit'),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Ajouter un produit
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fonctionnalité à venir')),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Ajouter un produit'),
                ),
              ],
            ),
          );
        }

        final products = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: product.images.isNotEmpty
                    ? Image.network(
                        product.images.first,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image, size: 50);
                        },
                      )
                    : const Icon(Icons.image, size: 50),
                title: Text(product.title),
                subtitle: Text(formatter.format(product.price)),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editProduct(context, product),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Prix: ${formatter.format(product.price)}'),
                        Text('Prix comparaison: ${formatter.format(product.compareAtPrice)}'),
                        Text('Réduction: ${product.discountPercentage}%'),
                        Text('Vendus: ${product.soldCount}'),
                        Text('Variantes: ${product.variants.length}'),
                        const SizedBox(height: 8),
                        Text('Description:', style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(product.description),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () => _deleteProduct(context, product.id),
                              icon: const Icon(Icons.delete, color: Colors.red),
                              label: const Text('Supprimer', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _editProduct(BuildContext context, ProductModel product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(product: product),
      ),
    );

    // Si l'édition a réussi, afficher un message
    if (result == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Produit mis à jour avec succès!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _deleteProduct(BuildContext context, String productId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le produit?'),
        content: const Text('Cette action est irréversible.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Produit supprimé')),
        );
      }
    }
  }
}

// =========================
// ONGLET UTILISATEURS
// =========================
class _UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: '\$');

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('Aucun utilisateur'));
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final userData = users[index].data() as Map<String, dynamic>;
            final userId = users[index].id;
            final email = userData['email'] ?? '';
            final name = userData['name'] ?? 'Sans nom';
            final walletBalance = (userData['walletBalance'] ?? 0).toDouble();
            final isAdmin = userData['isAdmin'] ?? false;

            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: isAdmin ? Colors.orange : Colors.blue,
                  child: Icon(
                    isAdmin ? Icons.admin_panel_settings : Icons.person,
                    color: Colors.white,
                  ),
                ),
                title: Text(name),
                subtitle: Text(email),
                trailing: Text(
                  formatter.format(walletBalance),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _InfoRow('ID', userId.substring(0, 12) + '...', Colors.grey),
                        _InfoRow('Email', email, Colors.blue),
                        _InfoRow('Nom', name, Colors.black),
                        _InfoRow('Solde', formatter.format(walletBalance), Colors.green),
                        _InfoRow('Admin', isAdmin ? 'Oui' : 'Non', isAdmin ? Colors.orange : Colors.grey),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (!isAdmin)
                              TextButton.icon(
                                onPressed: () => _makeAdmin(context, userId),
                                icon: const Icon(Icons.admin_panel_settings),
                                label: const Text('Promouvoir Admin'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _makeAdmin(BuildContext context, String userId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Promouvoir en Admin?'),
        content: const Text('Cet utilisateur aura tous les droits administrateur.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({'isAdmin': true});
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Utilisateur promu admin')),
        );
      }
    }
  }
}

// =========================
// ONGLET DÉPÔTS
// =========================
class _DepositsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    final formatter = NumberFormat.currency(symbol: '\$');

    return StreamBuilder(
      stream: firestoreService.getAllDeposits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Aucun dépôt'));
        }

        final deposits = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: deposits.length,
          itemBuilder: (context, index) {
            final deposit = deposits[index];

            return Card(
              child: ListTile(
                leading: Icon(
                  Icons.account_balance_wallet,
                  color: _getDepositStatusColor(deposit.status),
                ),
                title: Text(formatter.format(deposit.amount)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User: ${deposit.userId.substring(0, 8)}...'),
                    Text(DateFormat('dd/MM/yyyy HH:mm').format(deposit.createdAt)),
                  ],
                ),
                trailing: deposit.status == 'pending'
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check, color: Colors.green),
                            onPressed: () => _approveDeposit(
                              context,
                              deposit.id,
                              deposit.userId,
                              deposit.amount,
                            ),
                            tooltip: 'Approuver',
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, color: Colors.red),
                            onPressed: () => _rejectDeposit(context, deposit.id),
                            tooltip: 'Rejeter',
                          ),
                        ],
                      )
                    : _getDepositStatusChip(deposit.status),
              ),
            );
          },
        );
      },
    );
  }

  Color _getDepositStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Widget _getDepositStatusChip(String status) {
    Color color;
    String label;
    switch (status) {
      case 'approved':
        color = Colors.green;
        label = 'Approuvé';
        break;
      case 'rejected':
        color = Colors.red;
        label = 'Rejeté';
        break;
      default:
        color = Colors.orange;
        label = 'En attente';
    }

    return Chip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
    );
  }

  Future<void> _approveDeposit(
    BuildContext context,
    String depositId,
    String userId,
    double amount,
  ) async {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);

    // Mettre à jour le statut du dépôt
    await firestoreService.updateDepositStatus(depositId, 'approved');

    // Récupérer l'utilisateur et mettre à jour son solde
    final user = await firestoreService.getUser(userId);
    if (user != null) {
      await firestoreService.updateUserBalance(
        userId,
        user.walletBalance + amount,
      );
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Dépôt approuvé'), backgroundColor: Colors.green),
      );
    }
  }

  Future<void> _rejectDeposit(BuildContext context, String depositId) async {
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    await firestoreService.updateDepositStatus(depositId, 'rejected');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Dépôt rejeté'), backgroundColor: Colors.red),
      );
    }
  }
}
