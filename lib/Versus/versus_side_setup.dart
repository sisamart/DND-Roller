
import 'package:dnd_roller/Versus/side_single_setup.dart';
import 'package:flutter/material.dart';

class VersusSideSetup extends StatelessWidget {
  const VersusSideSetup({super.key, required this.dicePerRollControllerA, required this.dicePerRollControllerB});

  final TextEditingController dicePerRollControllerA;
  final TextEditingController dicePerRollControllerB;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SideSingleSetup(controller: dicePerRollControllerA, sideLetter: "A"),
        SideSingleSetup(controller: dicePerRollControllerB, sideLetter: "B"),
      ],
    );
  }

}