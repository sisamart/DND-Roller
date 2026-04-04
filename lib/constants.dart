
import 'dart:ui';

import 'package:flutter/material.dart';

import 'Services/roll_settings.dart';

class Constants {

  static RollSettings settings = RollSettings(
      dieSides: 10,
      dicePerRoll: 1,
      numberOfRolls: 1,
      successfulThreshold: 6,
      requiredSuccesses: 1);

  static const sideAWinMessage = "Side A wins!";
  static const sideBWinMessage = "Side B wins!";
  static const tieMessage = "It's a tie! Game master decides...";

  static const successThresholdColor = Color(0xFF00930F);
  static const numberOfRollsColor = Colors.orange;
  static const requiredSuccessesColor = Color(0xFF4B15C3);

}