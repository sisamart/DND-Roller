import 'package:dnd_roller/Partials/stats_column_widget.dart';
import 'package:dnd_roller/Services/row_stats.dart';
import 'package:flutter/material.dart';

class RollSummaryWidget extends StatelessWidget {
  const RollSummaryWidget({super.key, required this.stats});

  final List<RowStats> stats;

  @override
  Widget build(BuildContext context) {
    final successes = stats.where((element) => element.isSuccess);
    final fails = stats.where((element) => !element.isSuccess);
    final successfulCrits =
        successes.where((element) => element.crits > 0).length;
    final failedCrits = fails.where((element) => element.crits > 0).length;

    return SizedBox(
      width: 360,
      child: Card(
          color: Colors.white,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: StatsColumnWidget(
                        successes: successes.length,
                        fails: 0,
                        crits: successfulCrits,
                        isSuccess: true),
                  ),
                  VerticalDivider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
                    child: StatsColumnWidget(
                        successes: 0,
                        fails: fails.length,
                        crits: failedCrits,
                        isSuccess: false),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
