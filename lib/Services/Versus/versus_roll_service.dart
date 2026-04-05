import 'dart:math';

import 'package:dnd_roller/Models/roll_result.dart';
import 'package:dnd_roller/Services/Versus/versus_result_data.dart';
import 'package:dnd_roller/Services/Versus/versus_roll_settings.dart';

import '../../Models/versus_result.dart';

class VersusRollService {
  final VersusRollSettings settings;

  VersusRollService({required this.settings});

  VersusResultData calculateVersus() {
    final rollsA = _getNumberRolls(settings.dicePerRollA);
    final rollsB = _getNumberRolls(settings.dicePerRollB);

    return _decideRounds(rollsA, rollsB);
  }

  List<List<RollResult>> _getNumberRolls(int dicePerRoll) {
    final List<List<RollResult>> result = [];

    for (int i = 0; i < settings.numberOfRolls; i++) {
      final List<RollResult> round = [];
      for (int j = 0; j < dicePerRoll; j++) {
        int rnd = Random().nextInt(settings.dieSides) + 1;
        final rollResult = RollResult(
            number: rnd,
            isSuccess: rnd >= settings.successfulThreshold,
            isCritical: rnd == settings.dieSides);
        round.add(rollResult);
      }
      result.add(List.of(round));
      round.clear();
    }
    return result;
  }

  VersusResult _getGameResult(List<VersusResult> results) {
    int sideA = 0;
    int sideB = 0;

    for (final r in results) {
      switch (r) {
        case VersusResult.sideA:
        case VersusResult.critA:
          sideA++;
          break;
        case VersusResult.sideB:
        case VersusResult.critB:
          sideB++;
          break;
        case VersusResult.tie:
          sideA++;
          sideB++;
          break;
      }
    }

    if (sideA == sideB) {
      return VersusResult.tie;
    }
    return sideA > sideB ? VersusResult.sideA : VersusResult.sideB;
  }

  VersusResultData _decideRounds(List<List<RollResult>> sideA, List<List<RollResult>> sideB) {
    final List<VersusResult> results = [];
    List<int> critsA = [];
    List<int> critsB = [];

    for (int i = 0; i < settings.numberOfRolls; i++) {
      final aSuccesses = sideA[i].where((element) => element.isSuccess);
      final bSuccesses = sideB[i].where((element) => element.isSuccess);
      final aCrits = aSuccesses.where((element) => element.isCritical).length;
      final bCrits = bSuccesses.where((element) => element.isCritical).length;

      critsA.add(aCrits);
      critsB.add(bCrits);

      if (aSuccesses.length == bSuccesses.length) {
        if (aCrits == bCrits) {
          results.add(VersusResult.tie);
        } else {
          aCrits > bCrits
              ? results.add(VersusResult.critA)
              : results.add(VersusResult.critB);
        }
      } else {
        if (aSuccesses.length > bSuccesses.length) {
          aCrits > 0 ? results.add(VersusResult.critA) : results.add(VersusResult.sideA);
        } else {
          bCrits > 0 ? results.add(VersusResult.critB) : results.add(VersusResult.sideB);
        }
      }
    }

    return VersusResultData(
        rollsA: sideA,
        rollsB: sideB,
        finalResult: _getGameResult(results),
        roundResults: results,
        roundCritsA: critsA,
        roundCritsB: critsB);
  }
}
