import 'package:dnd_roller/Models/roll_result.dart';
import 'package:dnd_roller/Single/single_dice_grid_widget.dart';
import 'package:dnd_roller/Partials/labeled_input.dart';
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
                  LabeledInput(
                      label: "Die sides", textController: dieSideController),
                  LabeledInput(
                      label: "Dice per roll",
                      textController: dicePerRollController),
                  LabeledInput(
                      label: "Number of rolls",
                      textController: rollNumberController),
                  LabeledInput(
                      label: "Success threshold",
                      textController: thresholdController,
                      widget: TextButton(
                        onPressed: () {
                          final dieSidesText = dieSideController.text;
                          int? dieSides = 0;
                          if ((dieSides = int.tryParse(dieSidesText)) != null) {
                            thresholdController.text =
                                (dieSides! ~/ 2 + 1).toString();
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).primaryColor.withAlpha(55)),
                        child: Text(
                          "Half",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      )),
                  LabeledInput(
                    label: "Required successes",
                    textController: successRequiredController,
                    widget: TextButton(
                      onPressed: () {
                        final dicePerRollText = dicePerRollController.text;
                        int? dicePerRoll = 0;
                        if ((dicePerRoll = int.tryParse(dicePerRollText)) !=
                            null) {
                          successRequiredController.text =
                              (dicePerRoll! ~/ 2).toString();
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).primaryColor.withAlpha(55)),
                      child: Text(
                        "Half",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
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
