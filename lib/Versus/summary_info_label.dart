
import 'package:flutter/material.dart';

class SummaryInfoLabel extends StatelessWidget {
  const SummaryInfoLabel({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ));
  }
}
