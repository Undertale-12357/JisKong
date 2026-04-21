import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:jis_kong/ui/screens/pass/widget/pass_selection_list.dart';
import 'package:jis_kong/ui/screens/pass/widget/pass_status_header.dart';
import 'package:jis_kong/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class PassScreen extends StatelessWidget {
  const PassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassViewModel>();
    final user = viewModel.currentUser;
    final activePass = viewModel.activePassDetails;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: JisKongTheme.primaryOrange,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            label: "My Rides",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: "Subscription",
          ),
        ],
      ),
      body: SafeArea(
        child: viewModel.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    PassStatusHeader(user: user, activePass: activePass),
                    const SizedBox(height: 24),
                    const PassSelectionList(),
                  ],
                ),
              ),
      ),
    );
  }
}
