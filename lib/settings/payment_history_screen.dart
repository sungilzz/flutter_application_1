import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Mock payment data
    final List<Map<String, String>> mockTransactions = [
      {
        'date': '2025-06-15',
        'description': 'Premium Subscription (Monthly)',
        'amount': '\$9.99',
      },
      {
        'date': '2025-05-20',
        'description': 'Recipe Pack: Italian Delights',
        'amount': '\$4.99',
      },
      {
        'date': '2025-04-10',
        'description': 'Premium Subscription (Monthly)',
        'amount': '\$9.99',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Payment History', style: theme.textTheme.headlineMedium),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your past transactions:',
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24.0),
            Expanded(
              child: ListView.builder(
                itemCount: mockTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = mockTransactions[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.receipt_long,
                        color: theme.colorScheme.secondary,
                      ),
                      title: Text(
                        transaction['description']!,
                        style: theme.textTheme.bodyLarge,
                      ),
                      subtitle: Text(
                        transaction['date']!,
                        style: theme.textTheme.bodyMedium,
                      ),
                      trailing: Text(
                        transaction['amount']!,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
