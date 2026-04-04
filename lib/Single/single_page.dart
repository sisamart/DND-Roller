import 'package:dnd_roller/Models/roll_result.dart';
import 'package:dnd_roller/Partials/Inputs/dice_per_roll_input.dart';
import 'package:dnd_roller/Partials/Inputs/die_sides_input.dart';
import 'package:dnd_roller/Partials/Inputs/number_of_rolls_input.dart';
import 'package:dnd_roller/Partials/Inputs/required_successes_input.dart';
import 'package:dnd_roller/Partials/Inputs/success_threshold_input.dart';
import 'package:dnd_roller/Single/single_dice_grid_widget.dart';
import 'package:dnd_roller/Partials/roll_button.dart';
import 'package:dnd_roller/Partials/roll_summary_widget.dart';
import 'package:dnd_roller/Services/roll_service.dart';
import 'package:dnd_roller/Services/roll_settings.dart';
import 'package:dnd_roller/Services/row_stats.dart';
import 'package:flutter/material.dart';

class SinglePage extends StatelessWidget {
  SinglePage({super.key});

  final dieSideController = TextEditingController(text: "10");
  final dicePerRollController = TextEditingController(text: "1");
  final rollNumberController = TextEditingController(text: "1");
  final thresholdController = TextEditingController(text: "6");
  final successRequiredController = TextEditingController(text: "1");

  final _formKey = GlobalKey<FormState>();
  List<RowStats> stats = [];
  final rollsNotifier = ValueNotifier<List<List<RollResult>>>([]);
  RollSettings settings = RollSettings(
      dieSides: 10,
      dicePerRoll: 1,
      numberOfRolls: 1,
      successfulThreshold: 6,
      requiredSuccesses: 1);

  RollSettings _makeSettings() {
    return RollSettings(
        dieSides: int.parse(dieSideController.text),
        dicePerRoll: int.parse(dicePerRollController.text),
        numberOfRolls: int.parse(rollNumberController.text),
        successfulThreshold: int.parse(thresholdController.text),
        requiredSuccesses: int.parse(successRequiredController.text));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 10),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  DieSidesInput(
                    dieSideController: dieSideController,
                  ),
                  DicePerRollInput(
                      dicePerRollController: dicePerRollController),
                  NumberOfRollsInput(
                      rollNumberController: rollNumberController),
                  SuccessThresholdInput(
                      thresholdController: thresholdController,
                      dieSideController: dieSideController),
                  RequiredSuccessesInput(
                      successRequiredController: successRequiredController,
                      dicePerRollController: dicePerRollController)
                ],
              ),
            ),
          ),
        ),
        Center(child: RollButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              settings = _makeSettings();
              final service = RollService(settings: settings);
              final rolls = service.getRolls();
              stats = service.calculateSummary(rolls);
              rollsNotifier.value = rolls;
            }
          },
        )),
        SizedBox(
          height: 4,
        ),
        Divider(),
        SizedBox(
          height: 4,
        ),
        ValueListenableBuilder(
          valueListenable: rollsNotifier,
          builder: (context, value, child) {
            if (rollsNotifier.value.isNotEmpty) {
              return Column(
                children: [
                  RollSummaryWidget(stats: stats),
                  SizedBox(height: 6),
                  DiceGridWidget(
                    rolls: value,
                    settings: settings,
                    stats: stats,
                  ),
                ],
              );
            }
            return Container();
          },
        )
      ],
    );
  }
}
