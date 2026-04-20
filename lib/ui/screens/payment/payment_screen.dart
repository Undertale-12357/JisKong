import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/payment/success_screen.dart';
import 'package:provider/provider.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';

class PaymentSelectionScreen extends StatelessWidget {
  const PaymentSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  "${viewModel.pendingPassType?.name.toUpperCase()} PASS",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF8C00),
                  ),
                ),
                trailing: Text(
                  "\$${viewModel.pendingPrice}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Payment Method",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 15),

            _paymentTile("ABA Number", Icons.account_balance_wallet),
            _paymentTile("Debit/Credit Card", Icons.credit_card),

            const Spacer(),

            ElevatedButton(
              onPressed: () async {
                await viewModel.handlePurchaseFlow(
                  "user_001",
                  viewModel.pendingPassType!,
                  viewModel.pendingPrice,
                );

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SuccessScreen(),
                    ),
                  );
                }
              },
              child: viewModel.isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentTile(String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: Colors.grey),
        title: Text(title, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Icons.radio_button_off, color: Colors.grey),
      ),
    );
  }
}
