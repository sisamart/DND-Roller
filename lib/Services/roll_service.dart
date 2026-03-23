import 'dart:math';

import 'package:dnd_roller/Models/roll_result.dart';
import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/Services/roll_settings.dart';
import 'package:dnd_roller/Services/row_stats.dart';

class RollService {
  final RollSettings settings;

  RollService({required this.settings});

  List<List<RollResult>> getRolls() {
    final List<List<RollResult>> result = [];
    for (int i = 0; i < settings.numberOfRolls; i++) {
      final List<RollResult> round = [];
      for (int j = 0; j < settings.dicePerRoll; j++) {
        int rnd = Random().nextInt(settings.dieSides) + 1;
        final roll = RollResult(
            number: rnd,
            isSuccess: rnd >= settings.successfulThreshold,
            isCritical: rnd == settings.dieSides);
        round.add(roll);
      }
      result.add(List.of(round));
      round.clear();
    }
    return result;
  }

  List<RowStats> calculateSummary(List<List<RollResult>> rolls) {
    final List<RowStats> stats = [];
    for (final round in rolls) {
      int successes = 0;
      int fails = 0;
      int crits = 0;
      for (final roll in round) {
        if (roll.isSuccess) {
          successes++;
        } else {
          fails++;
        }
        if (roll.isCritical) {
          crits++;
        }
      }

      stats.add(RowStats(
          isSuccess: successes >= settings.requiredSuccesses,
          successes: successes,
          fails: fails,
          crits: crits));
    }
    return stats;
  }

  VersusResult decideWinner(RowStats statsA, RowStats statsB) {
    if (statsA.successes == statsB.successes) {
      if (statsA.crits == statsB.crits) {
        return VersusResult.tie;
      }
      return statsA.crits > statsB.crits
          ? VersusResult.sideA
          : VersusResult.sideB;
    }
    return statsA.successes > statsB.successes
        ? VersusResult.sideA
        : VersusResult.sideB;
  }
}
