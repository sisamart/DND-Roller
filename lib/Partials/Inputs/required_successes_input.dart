
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../labeled_input.dart';

class RequiredSuccessesInput extends StatelessWidget {
  const RequiredSuccessesInput(
      {super.key,
      required this.successRequiredController,
      required this.dicePerRollController});

  final TextEditingController successRequiredController;
  final TextEditingController dicePerRollController;

  @override
  Widget build(BuildContext context) {
    return LabeledInput(
      label: "Required successes",
      icon: Icons.done_all_rounded,
      color: Constants.requiredSuccessesColor,
      textController: successRequiredController,
      widget: TextButton(
        onPressed: () {
          final dicePerRollText = dicePerRollController.text;
          int? dicePerRoll = 0;
          if ((dicePerRoll = int.tryParse(dicePerRollText)) != null) {
            successRequiredController.text = (dicePerRoll! ~/ 2).toString();
          }
        },
        style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColor.withAlpha(55)),
        child: Text(
          "Half",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }
}
