import 'package:flutter/cupertino.dart';

import '../../constants.dart';
import '../../d_n_d_roller_icons_icons.dart';
import '../labeled_input.dart';

class NumberOfRollsInput extends StatelessWidget {
  const NumberOfRollsInput({super.key, required this.rollNumberController});

  final TextEditingController rollNumberController;

  @override
  Widget build(BuildContext context) {
    return LabeledInput(
        label: "Number of rolls",
        textController: rollNumberController,
        icon: DNDRollerIcons.circle_of_circles,
        color: Constants.numberOfRollsColor);
  }
}
