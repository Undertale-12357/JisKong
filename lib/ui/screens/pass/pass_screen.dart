import 'package:flutter/material.dart';
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
    );
  }
}
