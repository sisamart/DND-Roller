class RowStats {
  final bool isSuccess;
  final int successes;
  final int fails;
  final int crits;

  RowStats(
      {required this.isSuccess,
      required this.successes,
      required this.fails,
      required this.crits});
}
