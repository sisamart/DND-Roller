import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/Partials/roll_button.dart';
import 'package:dnd_roller/Versus/versus_side_rolls.dart';
import 'package:dnd_roller/Versus/versus_side_setup.dart';
import 'package:dnd_roller/Versus/winner_announce_widget.dart';
import 'package:dnd_roller/constants.dart';
import 'package:flutter/material.dart';

import '../Models/roll_result.dart';
import '../Partials/labeled_input.dart';
import '../Services/roll_service.dart';
import '../Services/roll_settings.dart';
import '../Services/row_stats.dart';

class VersusPage extends StatefulWidget {
  const VersusPage({super.key});

  @override
  State<VersusPage> createState() => _VersusPageState();
}

class _VersusPageState extends State<VersusPage> {
  final dieSideController = TextEditingController(text: "10");
  final thresholdController = TextEditingController(text: "6");
  final dicePerRollControllerA = TextEditingController(text: "1");
  final dicePerRollControllerB = TextEditingController(text: "1");

  final _formKey = GlobalKey<FormState>();

  final rollsANotifier = ValueNotifier<List<List<RollResult>>>([]);
  final rollsBNotifier = ValueNotifier<List<List<RollResult>>>([]);

  List<RowStats> statsA = [];
  List<RowStats> statsB = [];

  VersusResult result = VersusResult.tie;
  RollSettings settingsA = Constants.settings;
  RollSettings settingsB = Constants.settings;

  void _makeSettings() {
    settingsA = RollSettings(
        dieSides: int.parse(dieSideController.text),
        dicePerRoll: int.parse(dicePerRollControllerA.text),
        numberOfRolls: 1,
        successfulThreshold: int.parse(thresholdController.text),
        requiredSuccesses: 1);
    settingsB = RollSettings(
        dieSides: int.parse(dieSideController.text),
        dicePerRoll: int.parse(dicePerRollControllerB.text),
        numberOfRolls: 1,
        successfulThreshold: int.parse(thresholdController.text),
        requiredSuccesses: 1);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    LabeledInput(
                        label: "Die sides", textController: dieSideController),
                    LabeledInput(
                        label: "Success threshold",
                        textController: thresholdController,
                        widget: TextButton(
                          onPressed: () {
                            final dieSidesText = dieSideController.text;
                            int? dieSides = 0;
                            if ((dieSides = int.tryParse(dieSidesText)) !=
                                null) {
                              thresholdController.text =
                                  (dieSides! ~/ 2 + 1).toString();
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).primaryColor.withAlpha(55)),
                          child: Text(
                            "Half",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Divider(),
            VersusSideSetup(
                dicePerRollControllerA: dicePerRollControllerA,
                dicePerRollControllerB: dicePerRollControllerB),
            SizedBox(
              height: 4,
            ),
            Center(child: RollButton(onPressed: () {
              if (_formKey.currentState!.validate()) {
                _makeSettings();
                final serviceA = RollService(settings: settingsA);
                final serviceB = RollService(settings: settingsB);
                final rollsA = serviceA.getRolls();
                final rollsB = serviceB.getRolls();
                statsA = serviceA.calculateSummary(rollsA);
                statsB = serviceB.calculateSummary(rollsB);
                result = serviceA.decideWinner(statsA[0], statsB[0]);
                rollsANotifier.value = rollsA;
                rollsBNotifier.value = rollsB;
                setState(() {});
              }
            })),
            SizedBox(
              height: 4,
            ),
            Divider(),
            if (statsA.isNotEmpty)
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: VersusSideRolls(
                          rollsNotifier: rollsANotifier,
                          stats: statsA[0],
                          letter: "A"),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: WinnerAnnounceWidget(result: result),
                      ),
                    ),
                    Expanded(
                      child: VersusSideRolls(
                          rollsNotifier: rollsBNotifier,
                          stats: statsB[0],
                          letter: "B"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ]);
  }
}
