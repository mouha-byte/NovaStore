import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/deposit_model.dart';
import '../utils/app_theme.dart';
import '../widgets/modern_widgets.dart';
import 'package:intl/intl.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = authService.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Wallet')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet_outlined, size: 64, color: AppColors.textSecondary),
              SizedBox(height: AppSpacing.md),
              Text('Please login to access your wallet'),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, user.walletBalance),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildBalanceCard(context, user.walletBalance),
                _buildQuickActions(context),
                _buildTransactionHistory(context, user.id),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =========================
  // APP BAR
  // =========================
  Widget _buildAppBar(BuildContext context, double balance) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_balance_wallet,
                  size: 48,
                  color: Colors.white,
                ).animate().fadeIn().scale(),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'Wallet Balance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  '\$${balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1,
                  ),
                ).animate().fadeIn(delay: 200.ms).scale(),
              ],
            ),
          ),
        ),
        title: const Text('My Wallet'),
      ),
    );
  }

  // =========================
  // BALANCE CARD
  // =========================
  Widget _buildBalanceCard(BuildContext context, double balance) {
    return ResponsiveContainer(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary.withOpacity(0.1), AppColors.secondary.withOpacity(0.1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: AppRadius.circular24,
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${balance.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: AppShadows.md,
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 16, color: AppColors.info),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Use your balance to purchase products instantly',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn().slideY(),
    );
  }

  // =========================
  // QUICK ACTIONS
  // =========================
  Widget _buildQuickActions(BuildContext context) {
    return ResponsiveContainer(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Row(
        children: [
          Expanded(
            child: GradientButton(
              text: 'Add Funds',
              icon: Icons.add_circle_outline,
              onPressed: () => _showAddFundsDialog(context),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: AppRadius.circular12,
                border: Border.all(color: AppColors.border, width: 2),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // TODO: View history
                  },
                  borderRadius: AppRadius.circular12,
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history, color: AppColors.primary),
                        SizedBox(width: 8),
                        Text(
                          'History',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ).animate().fadeIn(delay: 200.ms).slideY(),
    );
  }

  // =========================
  // TRANSACTION HISTORY
  // =========================
  Widget _buildTransactionHistory(BuildContext context, String userId) {
    final firestoreService = Provider.of<FirestoreService>(context);

    return ResponsiveContainer(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ).animate().fadeIn(delay: 300.ms).slideX(),
          
          StreamBuilder<List<DepositModel>>(
            stream: firestoreService.getUserDeposits(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xl),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: AppRadius.circular16,
                  ),
                  child: const Center(
                    child: Column(
                      children: [
                        Icon(Icons.receipt_long_outlined, size: 48, color: AppColors.textSecondary),
                        SizedBox(height: AppSpacing.sm),
                        Text(
                          'No transactions yet',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final deposits = snapshot.data!;

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: deposits.length,
                itemBuilder: (context, index) {
                  final deposit = deposits[index];
                  return _buildTransactionItem(deposit);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(DepositModel deposit) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (deposit.status) {
      case 'approved':
        statusColor = AppColors.success;
        statusIcon = Icons.check_circle;
        statusText = 'Approved';
        break;
      case 'rejected':
        statusColor = AppColors.error;
        statusIcon = Icons.cancel;
        statusText = 'Rejected';
        break;
      default:
        statusColor = AppColors.warning;
        statusIcon = Icons.pending;
        statusText = 'Pending';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
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
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(statusIcon, color: statusColor, size: 24),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deposit',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy • HH:mm').format(deposit.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+\$${deposit.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.success,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: AppRadius.circular8,
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn().slideX();
  }

  // =========================
  // ADD FUNDS DIALOG
  // =========================
  void _showAddFundsDialog(BuildContext context) {
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: AppRadius.circular16),
        title: const Text('Add Funds'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Enter the amount you want to add to your wallet'),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount (\$)',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final amount = double.tryParse(amountController.text);
              if (amount == null || amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid amount'),
                    backgroundColor: AppColors.error,
                  ),
                );
                return;
              }

              Navigator.pop(dialogContext);
              await _processPayment(context, amount);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  Future<void> _processPayment(BuildContext context, double amount) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final firestoreService = Provider.of<FirestoreService>(context, listen: false);
    final user = authService.currentUser;

    if (user == null) return;

    try {
      // Create deposit request
      final deposit = DepositModel(
        id: '',
        userId: user.id,
        amount: amount,
        status: 'pending',
        createdAt: DateTime.now(),
      );
      
      await firestoreService.createDeposit(deposit);

      // Launch Payeer (simplified for MVP)
      final payeerUrl = _generatePayeerUrl(amount, user.id);
      if (await canLaunchUrl(Uri.parse(payeerUrl))) {
        await launchUrl(Uri.parse(payeerUrl), mode: LaunchMode.externalApplication);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Redirecting to payment gateway...'),
              backgroundColor: AppColors.info,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  String _generatePayeerUrl(double amount, String userId) {
    const merchantId = AppConstants.payeerMerchantId;
    return 'https://payeer.com/merchant/?m_shop=$merchantId&m_orderid=${DateTime.now().millisecondsSinceEpoch}&m_amount=${amount.toStringAsFixed(2)}&m_curr=USD&m_desc=Wallet+Deposit';
  }
}
