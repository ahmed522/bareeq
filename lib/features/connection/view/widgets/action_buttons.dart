import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/features/connection/controller/connection_screen_states.dart';
import 'package:bareeq/features/teleop/view/screens/control_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = ConnectionScreenCubit.get(context);
    return BlocBuilder<ConnectionScreenCubit, ConnectionScreenStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: ((state is SubscribedState) &&
                    cubit.subscribedToAllNeededTopics),
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      ControlScreen.route,
                      arguments: cubit,
                    );
                  },
                  icon: const Icon(
                    Icons.games_outlined,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        color: Colors.black54,
                        spreadRadius: 0.8,
                        blurRadius: 2,
                        offset: Offset(0, 0.8),
                      ),
                    ],
                  ),
                  iconSize: 30,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.deepOrange.shade500,
                    elevation: 2,
                    shape: const CircleBorder(),
                    splashFactory: InkRipple.splashFactory,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
