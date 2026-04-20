import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jis_kong/model/pass/pass.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:provider/provider.dart';

class PassContent extends StatelessWidget {
  const PassContent({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PassViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F7),
      appBar: AppBar(
        title: const Text("Subscription", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (vm.hasActivePass) _buildActivePassCard(vm),
            const SizedBox(height: 20),
            _buildPassOption(
              title: "Day Pass",
              price: "\$7",
              subtitle: "Perfect for occasional riders",
              features: ["Unlimited 30-min rides", "All bike types included", "Valid for 24 hours"],
              onPressed: () => vm.createPass(PassType.day),
            ),
            _buildPassOption(
              title: "Monthly Pass",
              price: "\$200",
              subtitle: "Best for regular commuters",
              features: ["Unlimited 45-min rides", "All bike types included", "Priority bike reservations", "Cancel anytime"],
              isPopular: true,
              isCurrent: true,
            ),
            _buildPassOption(
              title: "Annual Pass",
              price: "\$2,150",
              subtitle: "Save 10% with annual plan",
              features: ["Unlimited 60-min rides", "All bike types included", "Priority bike reservations", "Guest passes (2 per month)", "Save \$250/year"],
              isBestValue: true,
              onPressed: () => vm.createPass(PassType.annual),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivePassCard(PassViewModel vm) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF22C55E), Color(0xFF16A34A)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 48),
          const SizedBox(height: 8),
          const Text("ACTIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
          const Text("Monthly Pass", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const Text("Renews on May 1, 2026", style: TextStyle(color: Colors.white70)),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Divider(color: Colors.white24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _statColumn("∞", "Rides"),
              _statColumn("45", "Min Each"),
              _statColumn("${vm.daysLeft}", "Days Left"),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.green),
              onPressed: () {},
              child: const Text("Manage Subscription"),
            ),
          )
        ],
      ),
    );
  }

  Widget _statColumn(String val, String label) => Column(
    children: [
      Text(val, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
    ],
  );

  Widget _buildPassOption({
    required String title, required String price, required String subtitle,
    required List<String> features, bool isPopular = false, bool isBestValue = false,
    bool isCurrent = false, VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular || isBestValue) _buildBadge(isPopular ? "POPULAR" : "BEST VALUE", isPopular ? Colors.orange : Colors.teal),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(price, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          const SizedBox(height: 12),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(children: [const Icon(Icons.check, size: 16, color: Colors.green), const SizedBox(width: 8), Text(f)]),
          )),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: isCurrent 
              ? ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade200, foregroundColor: Colors.black), onPressed: null, child: const Text("Current Plan"))
              : ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white), onPressed: onPressed, child: const Text("Select Pass")),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) => Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
    child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
  );
}