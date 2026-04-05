import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/Partials/Inputs/die_sides_input.dart';
import 'package:dnd_roller/Partials/Inputs/number_of_rolls_input.dart';
import 'package:dnd_roller/Partials/Inputs/success_threshold_input.dart';
import 'package:dnd_roller/Partials/roll_button.dart';
import 'package:dnd_roller/Services/Versus/versus_result_data.dart';
import 'package:dnd_roller/Services/Versus/versus_roll_service.dart';
import 'package:dnd_roller/Services/Versus/versus_roll_settings.dart';
import 'package:dnd_roller/Versus/versus_side_rolls.dart';
import 'package:dnd_roller/Versus/versus_side_setup.dart';
import 'package:dnd_roller/Versus/winner_announce_widget.dart';
import 'package:dnd_roller/constants.dart';
import 'package:flutter/material.dart';

import '../Models/roll_result.dart';

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
  final rollNumberController = TextEditingController(text: "1");

  final _formKey = GlobalKey<FormState>();

  final rollsANotifier = ValueNotifier<List<List<RollResult>>>([]);
  final rollsBNotifier = ValueNotifier<List<List<RollResult>>>([]);

  VersusResultData? resultData;

  VersusResult result = VersusResult.tie;
  VersusRollSettings settings = Constants.versusSettings;

  void _makeSettings() {
    settings = VersusRollSettings(
        int.parse(dieSideController.text),
        int.parse(dicePerRollControllerA.text),
        int.parse(dicePerRollControllerB.text),
        int.parse(rollNumberController.text),
        int.parse(thresholdController.text));
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
                    DieSidesInput(dieSideController: dieSideController),
                    NumberOfRollsInput(
                        rollNumberController: rollNumberController),
                    SuccessThresholdInput(
                        thresholdController: thresholdController,
                        dieSideController: dieSideController)
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
                final service = VersusRollService(settings: settings);
                resultData = service.calculateVersus();
                rollsANotifier.value = resultData!.rollsA;
                rollsBNotifier.value = resultData!.rollsB;
                result = resultData?.finalResult ?? VersusResult.tie;
                setState(() {});
              }
            })),
            SizedBox(
              height: 4,
            ),
            Divider(),
            if (rollsANotifier.value.isNotEmpty)
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: VersusSideRolls(
                        rollsNotifier: rollsANotifier,
                        settings: settings,
                        roundResults: resultData?.roundResults ?? [],
                        isSideA: true,
                      ),
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
                        settings: settings,
                        roundResults: resultData?.roundResults ?? [],
                        isSideA: false,
                      ),
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
