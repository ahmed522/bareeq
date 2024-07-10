import 'package:flutter/material.dart';

import 'single_choice_indicator.dart';

class ChoiceIndicator extends StatelessWidget {
  const ChoiceIndicator({
    super.key,
    required this.items,
    required this.currentChoice,
    this.choicesPadding = 5.0,
    this.choiceSize = 10.0,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  final int items;
  final int currentChoice;
  final double choicesPadding;
  final double choiceSize;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: List.generate(
        items,
        (index) => SingleChoiceIndicator(
          currentChoice: currentChoice,
          index: index,
          size: choiceSize,
          padding: choicesPadding,
        ),
      ),
    );
  }
}
