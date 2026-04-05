class RollSettings {
  final int dieSides;
  final int dicePerRoll;
  final int numberOfRolls;
  final int successfulThreshold;
  final int requiredSuccesses;

  RollSettings(
      {required this.dieSides,
      required this.dicePerRoll,
      required this.numberOfRolls,
      required this.successfulThreshold,
      required this.requiredSuccesses});
}
