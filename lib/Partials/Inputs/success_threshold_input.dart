
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../labeled_input.dart';

class SuccessThresholdInput extends StatelessWidget {
  const SuccessThresholdInput(
      {super.key,
      required this.thresholdController,
      required this.dieSideController});

  final TextEditingController thresholdController;
  final TextEditingController dieSideController;

  @override
  Widget build(BuildContext context) {
    return LabeledInput(
        label: "Success threshold",
        icon: Icons.done,
        color: Constants.successThresholdColor,
        textController: thresholdController,
        widget: TextButton(
          onPressed: () {
            final dieSidesText = dieSideController.text;
            int? dieSides = 0;
            if ((dieSides = int.tryParse(dieSidesText)) != null) {
              thresholdController.text = (dieSides! ~/ 2 + 1).toString();
            }
          },
          style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor.withAlpha(55)),
          child: Text(
            "Half",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ));
  }
}
