import 'package:dnd_roller/Models/roll_result.dart';
import 'package:dnd_roller/Models/versus_result.dart';

class VersusResultData {
  final List<List<RollResult>> rollsA;
  final List<List<RollResult>> rollsB;
  final List<VersusResult> roundResults;
  final List<int> roundCritsA;
  final List<int> roundCritsB;
  final VersusResult finalResult;

  VersusResultData(
      {required this.rollsA,
      required this.rollsB,
      required this.roundResults,
      required this.roundCritsA,
      required this.roundCritsB,
      required this.finalResult});
}
