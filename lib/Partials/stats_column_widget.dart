
import 'package:flutter/material.dart';

class StatsColumnWidget extends StatelessWidget {
  const StatsColumnWidget({super.key, required this.successes, required this.fails, required this.crits, required this.isSuccess});

  final int successes;
  final int fails;
  final bool isSuccess;
  final int crits;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${isSuccess ? successes.toString() : fails.toString()} ${isSuccess ? "Successes" : "Fails"}",
          style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "$crits Crits",
          style: TextStyle(
            color: crits > 0 ? Colors.deepPurple : Colors.deepPurple.withAlpha(100),
            fontWeight: crits > 0 ? FontWeight.bold : FontWeight.normal,
            fontSize: 18,
          ),
        )
      ],
    );
  }

}