import 'package:dnd_roller/Models/roll_result.dart';
import 'package:dnd_roller/Partials/die_widget.dart';
import 'package:dnd_roller/Partials/row_stats_widget.dart';
import 'package:flutter/material.dart';

import '../Services/Single/row_stats.dart';

class SingleDiceGridWidget extends StatefulWidget {
  const SingleDiceGridWidget(
      {super.key,
      required this.rolls,
      required this.stats});

  final List<List<RollResult>> rolls;
  final List<RowStats> stats;

  @override
  State<SingleDiceGridWidget> createState() => _SingleDiceGridWidgetState();
}

class _SingleDiceGridWidgetState extends State<SingleDiceGridWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scrollbar(
        controller: _scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              ...widget.rolls.asMap().entries.map((entry) {
                final rowIndex = entry.key;
                final round = entry.value;
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).primaryColor, width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        RowStatsWidget(stats: widget.stats[rowIndex]),
                        SizedBox(width: 6),
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: round
                                .map((roll) => Padding(
                              padding: const EdgeInsets.all(2),
                              child: DieWidget(result: roll),
                            ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 6,
              )
            ],
          ),
        ),
      ),
    );
  }
}
