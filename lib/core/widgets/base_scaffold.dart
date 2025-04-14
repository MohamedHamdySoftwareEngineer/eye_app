import 'package:eye/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class BaseScaffold extends StatelessWidget {
  final Widget child;

  const BaseScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: const CustomBottomBar(),
      body: Column(
        children: [
          // Include your custom app bar here instead of in the Scaffold's appBar property.
          // const CustomAppBar(),
          // Use Expanded to allow the child widget to fill the remaining space.
          Expanded(child: child),
        ],
      ),
    );
  }
}
