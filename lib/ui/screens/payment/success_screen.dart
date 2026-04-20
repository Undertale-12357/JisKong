import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
final String price;
  final String passName;

  const SuccessScreen({super.key, required this.price, required this.passName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                  ),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/en/thumb/8/8c/ABA_Bank_logo.svg/1200px-ABA_Bank_logo.svg.png',
                    height: 60,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Paying ABA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Text("Banking Name: Toun Phylong", style: TextStyle(color: Colors.grey)),
              const Text("+855 99294142", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              const Text("Enter Amount", style: TextStyle(color: Colors.grey, fontSize: 14)),
              Text("$price \$", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              
              const SizedBox(height: 40),
              
              const Icon(Icons.check_circle, color: Color(0xFFE8F5E9), size: 80),
              const SizedBox(height: 10),
              const Text(
                "Transferred Successfully",
                style: TextStyle(color: Color(0xFF22C55E), fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 30),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _detailRow("Amount Paid:", "$price \$"),
                    _detailRow("To:", passName),
                    _detailRow("Transaction ID:", "ILS973"),
                    _detailRow("Date & Time:", "2nd March 2026, 12:45 PM"),
                  ],
                ),
              ),

              const Spacer(),

              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                icon: const Icon(Icons.download),
                label: const Text("Download Receipt"),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}