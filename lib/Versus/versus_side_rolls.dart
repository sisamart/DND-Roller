
import 'package:dnd_roller/Services/row_stats.dart';
import 'package:dnd_roller/Versus/round_summary_card.dart';
import 'package:dnd_roller/Versus/versus_dice_grid_widget.dart';
import 'package:flutter/material.dart';

import '../Models/roll_result.dart';

class VersusSideRolls extends StatelessWidget {
  const VersusSideRolls({super.key, required this.rollsNotifier, required this.stats, required this.letter});

  final ValueNotifier<List<List<RollResult>>> rollsNotifier;
  final RowStats stats;
  final String letter;

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
              Text("Side $letter", style: TextStyle(fontSize: 32, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
              Center(
                  child: IntrinsicWidth(child: RoundSummaryCard(stats: stats))),
              VersusDiceGridWidget(
                rolls: value,
              ),

            ],
          );
        }
        return Container();
      },
    );
  }

}