import 'package:dnd_roller/Partials/Inputs/dice_per_roll_input.dart';
import 'package:flutter/material.dart';

class SideSingleSetup extends StatelessWidget {
  const SideSingleSetup(
      {super.key, required this.controller, required this.sideLetter});

  final TextEditingController controller;
  final String sideLetter;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Side $sideLetter",
            style: TextStyle(
                fontSize: 32,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        DicePerRollInput(dicePerRollController: controller)
      ],
    );
  }
}
