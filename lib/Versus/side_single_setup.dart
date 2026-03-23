
import 'package:flutter/material.dart';

import '../Partials/labeled_input.dart';

class SideSingleSetup extends StatelessWidget {
  const SideSingleSetup({super.key, required this.controller, required this.sideLetter});

  final TextEditingController controller;
  final String sideLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Side $sideLetter", style: TextStyle(fontSize: 32, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        LabeledInput(
            label: "Dice per roll",
            textController: controller),
      ],
    );
  }

}