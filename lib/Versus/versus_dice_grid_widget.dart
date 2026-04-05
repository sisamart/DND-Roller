import 'package:dnd_roller/Models/versus_result.dart';
import 'package:dnd_roller/Versus/versus_row_result_widget.dart';
import 'package:flutter/material.dart';

import '../Models/roll_result.dart';
import '../Partials/die_widget.dart';

class VersusDiceGridWidget extends StatefulWidget {
  const VersusDiceGridWidget(
      {super.key, required this.rolls, required this.roundResults, required this.isSideA});

  final List<List<RollResult>> rolls;
  final List<VersusResult> roundResults;
  final bool isSideA;

  @override
  State<VersusDiceGridWidget> createState() => _VersusDiceGridWidgetState();
}

class _VersusDiceGridWidgetState extends State<VersusDiceGridWidget> {
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
                final round = entry.value;
                final index = entry.key;

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
                        VersusRowResultWidget(
                          result: widget.roundResults[index],
                          isSideA: widget.isSideA,
                        ),
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
