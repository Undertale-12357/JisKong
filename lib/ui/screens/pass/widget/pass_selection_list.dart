import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:jis_kong/ui/screens/payment/payment_screen.dart';
import 'package:provider/provider.dart';
import 'package:jis_kong/model/pass/pass.dart';
import 'package:jis_kong/ui/theme/theme.dart';

class PassSelectionList extends StatelessWidget {
  const PassSelectionList({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassViewModel>();
    final activePassId = viewModel.currentUser?.activePassId;
    final activeType = viewModel.activePassDetails?.type;

    void _navigateToPayment(BuildContext context, PassType type, double price) {
      context.read<PassViewModel>().setPendingPurchase(type, price);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const PaymentSelectionScreen()),
      );
    }

    return Column(
      children: [
        _buildPassCard(
          context,
          title: "Day Pass",
          price: "\$7",
          period: "per day",
          ridesPerDay: "2 Rides per day",
          ebikeAccess: "Standard Bikes Only",
          isSelected: activeType == PassType.day,
          onTap: () => _navigateToPayment(context, PassType.day, 7.0),
        ),
        _buildPassCard(
          context,
          title: "Monthly Pass",
          price: "\$200",
          period: "per month",
          ridesPerDay: "10 Rides per day",
          ebikeAccess: "Includes 2 Electric Rides/day",
          isPopular: true,
          isSelected: activeType == PassType.monthly,
          onTap: () => _navigateToPayment(context, PassType.monthly, 200.0),
        ),
        _buildPassCard(
          context,
          title: "Annual Pass",
          price: "\$2,150",
          period: "per year",
          ridesPerDay: "Unlimited Rides",
          ebikeAccess: "Unlimited Electric Bikes",
          badge: "BEST VALUE",
          isSelected: activeType == PassType.annual,
          onTap: () => _navigateToPayment(context, PassType.annual, 2150.0),
        ),
      ],
    );
  }

  Widget _buildPassCard(
    BuildContext context, {
    required String title,
    required String price,
    required String period,
    required String ridesPerDay,
    required String ebikeAccess,
    required VoidCallback onTap,
    bool isPopular = false,
    bool isSelected = false,
    String? badge,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width:
          MediaQuery.of(context).size.width * 0.9, // Centered via width control
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: isSelected
            ? Border.all(color: JisKongTheme.primaryOrange, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          if (isPopular || badge != null)
            Positioned(
              top: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isPopular
                      ? JisKongTheme.primaryOrange
                      : const Color(0xFF00C48C),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  isPopular ? "POPULAR" : badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: JisKongTheme.primaryOrange,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      period,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Benefit List
                _benefitRow(Icons.directions_bike, ridesPerDay),
                const SizedBox(height: 10),
                _benefitRow(Icons.bolt, ebikeAccess),

                const SizedBox(height: 30),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: isSelected ? null : onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isSelected
                          ? Colors.grey.shade200
                          : JisKongTheme.primaryOrange,
                      elevation: isSelected ? 0 : 4,
                    ),
                    child: Text(isSelected ? "Current Plan" : "Select Pass"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitRow(IconData icon, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF00C48C)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 15, color: Colors.black87)),
      ],
    );
  }
}
