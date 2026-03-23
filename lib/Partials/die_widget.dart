import 'package:dnd_roller/Models/roll_result.dart';
import 'package:flutter/material.dart';

class DieWidget extends StatelessWidget {
  const DieWidget({super.key, required this.result});

  final RollResult result;

  Color _getColor() {
    if (result.isSuccess) {
      if (result.isCritical) {
        return Colors.deepPurple;
      }
      return Colors.green;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 65,
      height: 65,
      child: Container(
        decoration: BoxDecoration(
          color: _getColor(),
          borderRadius: BorderRadius.circular(6),
        ),
        alignment: Alignment.center,
        child: Text(
          result.number.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
