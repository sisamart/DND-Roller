
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

}