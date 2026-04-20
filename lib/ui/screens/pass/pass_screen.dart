import 'package:flutter/material.dart';
<<<<<<< HEAD
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
                    PassStatusHeader(user: user),
                    const SizedBox(height: 24),
                    const PassSelectionList(),
                  ],
                ),
              ),
      ),
=======
import 'view_model/pass_view_model.dart';
import 'widget/pass_content.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  late PassViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PassViewModel();

    _viewModel.addListener(_update);
  }

  void _update() => setState(() {});

  @override
  void dispose() {
    _viewModel.removeListener(_update);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EB),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pedal_bike_outlined),
            label: 'My Rides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_num_outlined),
            label: 'Subscription',
          ),
        ],
      ),
      body: SafeArea(child: PassContent(viewModel: _viewModel)),
>>>>>>> d56e23e35c6cb0aa15a4bdb81852732fea1b684c
    );
  }
}
