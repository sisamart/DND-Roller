import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/Versus/round_summary_card.dart';
import 'package:dnd_roller/Versus/versus_dice_grid_widget.dart';
import 'package:flutter/material.dart';

import '../Models/roll_result.dart';
import '../Services/Versus/versus_roll_settings.dart';

class VersusSideRolls extends StatelessWidget {
  const VersusSideRolls(
      {super.key,
      required this.rollsNotifier,
      required this.settings,
      required this.roundResults,
      required this.isSideA});

  final ValueNotifier<List<List<RollResult>>> rollsNotifier;
  final List<VersusResult> roundResults;
  final VersusRollSettings settings;
  final bool isSideA;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: rollsNotifier,
      builder: (context, value, child) {
        if (rollsNotifier.value.isNotEmpty) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Side ${isSideA ? "A" : "B"}",
                  style: TextStyle(
                      fontSize: 32,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold)),
              Center(
                  child: IntrinsicWidth(
                      child: RoundSummaryCard(
                stats: roundResults,
                isSideA: isSideA,
              ))),
              VersusDiceGridWidget(
                rolls: rollsNotifier.value,
                roundResults: roundResults,
                isSideA: isSideA,
              )
            ],
          );
        }
        return Container();
      },
    );
  }
}
