import 'package:dnd_roller/Versus/summary_info_label.dart';
import 'package:flutter/material.dart';

import '../Services/row_stats.dart';

class RoundSummaryCard extends StatelessWidget {
  const RoundSummaryCard({super.key, required this.stats});

  final RowStats stats;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          spacing: 6,
          children: [
            SummaryInfoLabel(text: "${stats.successes} successes", color: Colors.green),
            SummaryInfoLabel(text: "${stats.fails} fails", color: Colors.red),
            SummaryInfoLabel(text: "${stats.crits} crits", color: Colors.deepPurple),
          ],
        ),
      ),
    );
  }
}
