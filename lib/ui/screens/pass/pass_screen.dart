import 'package:flutter/material.dart';
import 'package:jis_kong/ui/screens/pass/view_model/pass_view_model.dart';
import 'package:jis_kong/ui/screens/pass/widget/pass_selection_list.dart';
import 'package:jis_kong/ui/screens/pass/widget/pass_status_header.dart';
import 'package:provider/provider.dart';

class PassScreen extends StatefulWidget {
  const PassScreen({super.key});

  @override
  State<PassScreen> createState() => _PassScreenState();
}

class _PassScreenState extends State<PassScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PassViewModel>().init("user_001");
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PassViewModel>();
    final user = viewModel.currentUser;
    final activePass = viewModel.activePassDetails;

    return Container(
      color: const Color(0xFFF9F9F9),
      child: SafeArea(
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
