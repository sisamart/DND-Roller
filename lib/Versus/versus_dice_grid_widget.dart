import 'package:flutter/material.dart';

import '../Models/roll_result.dart';
import '../Partials/die_widget.dart';

class VersusDiceGridWidget extends StatelessWidget {
  const VersusDiceGridWidget({super.key, required this.rolls});
  final List<List<RollResult>> rolls;

  @override
  Widget build(BuildContext context) {
    if (rolls.isEmpty || rolls[0].isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor, width: 2),
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: rolls[0].map((roll) => DieWidget(result: roll)).toList(),
      ),
    );
  }
}
