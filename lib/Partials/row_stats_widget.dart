import 'package:flutter/material.dart';

import '../Services/row_stats.dart';

class RowStatsWidget extends StatelessWidget {
  const RowStatsWidget({super.key, required this.stats});

  final RowStats stats;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(
              stats.isSuccess ? "Success" : "Fail",
              style: TextStyle(
                  color: stats.isSuccess ? Colors.green : Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "${stats.crits} Crits",
              style: TextStyle(
                color: stats.crits > 0 ? Colors.deepPurple : Colors.deepPurple.withAlpha(100),
                fontWeight: stats.crits > 0 ? FontWeight.bold : FontWeight.normal,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
