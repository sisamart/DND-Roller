import 'package:dnd_roller/Models/versus_result.dart';
import 'package:flutter/material.dart';

class VersusRowResultWidget extends StatelessWidget {
  const VersusRowResultWidget(
      {super.key, required this.result, required this.isSideA, });

  final VersusResult result;
  final bool isSideA;

  Color _getColor() {
    switch (result) {
      case VersusResult.sideA:
        return isSideA ? Colors.green : Colors.red;
      case VersusResult.sideB:
        return isSideA ? Colors.red : Colors.green;
      case VersusResult.critA:
        return isSideA ? Colors.deepPurple : Colors.red;
      case VersusResult.critB:
        return isSideA ? Colors.red : Colors.deepPurple;
      case VersusResult.tie:
        return Colors.blue;
    }
  }

  String _getText() {
    switch (result) {
      case VersusResult.sideA:
        return isSideA ? "Success" : "Fail";
      case VersusResult.sideB:
        return isSideA ? "Fail" : "Success";
      case VersusResult.critA:
        return isSideA ? "Success" : "Fail";
      case VersusResult.critB:
        return isSideA ? "Fail" : "Success";
      case VersusResult.tie:
        return "Tie";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColor(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          _getText(),
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
