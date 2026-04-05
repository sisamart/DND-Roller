import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/Versus/summary_info_label.dart';
import 'package:dnd_roller/Versus/summary_result.dart';
import 'package:flutter/material.dart';

class RoundSummaryCard extends StatelessWidget {
  const RoundSummaryCard({super.key, required this.stats, required this.isSideA});

  final List<VersusResult> stats;
  final bool isSideA;

  SummaryResult _getSummary() {
    int successes = 0;
    int fails = 0;
    int crits = 0;
    int ties = 0;

    for (final stat in stats) {
      switch (stat) {
        case VersusResult.sideA:
          isSideA ? successes++ : fails++;
          break;
        case VersusResult.sideB:
          isSideA ? fails++ : successes++;
          break;
        case VersusResult.tie:
          ties++;
          break;
        case VersusResult.critA:
          if (isSideA) {
            successes++;
            crits++;
          } else {
            fails++;
          }
          break;
        case VersusResult.critB:
          if (isSideA) {
            fails++;
          } else {
            successes++;
            crits++;
          }
      }
    }

    return SummaryResult(successes: successes, fails: fails, crits: crits, ties: ties);
  }

  @override
  Widget build(BuildContext context) {
    final result = _getSummary();

    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          spacing: 6,
          children: [
            SummaryInfoLabel(text: "${result.successes} successes", color: Colors.green),
            SummaryInfoLabel(text: "${result.fails} fails", color: Colors.red),
            SummaryInfoLabel(text: "${result.crits} crits", color: Colors.deepPurple),
            SummaryInfoLabel(text: "${result.ties} ties", color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
