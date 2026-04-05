
class VersusRollSettings {
  final int dieSides;
  final int dicePerRollA;
  final int dicePerRollB;
  final int numberOfRolls;
  final int successfulThreshold;

  VersusRollSettings(this.dieSides, this.dicePerRollA, this.dicePerRollB,
      this.numberOfRolls, this.successfulThreshold);
}