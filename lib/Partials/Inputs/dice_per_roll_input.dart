
import 'package:flutter/material.dart';

import '../../d_n_d_roller_icons_icons.dart';
import '../labeled_input.dart';

class DicePerRollInput extends StatelessWidget {
  const DicePerRollInput({super.key, required this.dicePerRollController});

  final TextEditingController dicePerRollController;

  @override
  Widget build(BuildContext context) {
    return LabeledInput(
        label: "Dice per roll",
        textController: dicePerRollController, icon: DNDRollerIcons.dice, color: Colors.blue);
  }

}