
import 'package:flutter/material.dart';

import '../../d_n_d_roller_icons_icons.dart';
import '../labeled_input.dart';

class DieSidesInput extends StatelessWidget {
  const DieSidesInput({super.key, required this.dieSideController});

  final TextEditingController dieSideController;

  @override
  Widget build(BuildContext context) {
    return LabeledInput(
        label: "Die sides", textController: dieSideController, icon: DNDRollerIcons.dice_d20, color: Colors.red);
  }

}