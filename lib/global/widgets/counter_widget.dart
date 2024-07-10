
import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:flutter/material.dart';

import 'circle_button.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    super.key,
    required this.increase,
    required this.decrease,
    required this.count,
  });
  final void Function() increase;
  final void Function() decrease;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleButton(
            onPressed: () => increase(),
            backgroundColor: (CommonFunctions.isLightMode(context))
                ? AppColors.primaryColor
                : AppColors.darkThemeBackgroundColor,
            child: const Icon(Icons.add),
          ),
          Text(
            count.toString(),
            style: TextStyle(
              color: (CommonFunctions.isLightMode(context))
                  ? AppColors.darkThemeBackgroundColor
                  : Colors.white,
              fontSize: 18,
            ),
          ),
          CircleButton(
            onPressed: () => decrease(),
            backgroundColor: (CommonFunctions.isLightMode(context))
                ? AppColors.primaryColor
                : AppColors.darkThemeBackgroundColor,
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
