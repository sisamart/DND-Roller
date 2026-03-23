
import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/constants.dart';
import 'package:flutter/material.dart';

class WinnerAnnounceWidget extends StatelessWidget {
  const WinnerAnnounceWidget({super.key, required this.result});

  final VersusResult result;

  String _getMessage(VersusResult result) {
    switch (result) {
      case VersusResult.sideA:
        return Constants.sideAWinMessage;
      case VersusResult.sideB:
        return Constants.sideBWinMessage;
      case VersusResult.tie:
        return Constants.tieMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(_getMessage(result), style: TextStyle(fontSize: 24),),
      ),
    );
  }

}