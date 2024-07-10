import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/features/connection/view/screens/connection_screen.dart';
import 'package:bareeq/features/teleop/controller/control_cubit.dart';
import 'package:bareeq/features/teleop/view/screens/control_screen.dart';
import 'package:bareeq/global/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    ConnectionScreen.route: (context) => BlocProvider<ConnectionScreenCubit>(
        create: (context) => ConnectionScreenCubit(),
        child: const ConnectionScreen()),
  };

  static onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case ControlScreen.route:
        ConnectionScreenCubit connectionCubit =
            settings.arguments as ConnectionScreenCubit;
        return SliderRight(
          page: BlocProvider<ControlCubit>(
            create: (context) => ControlCubit(connectionCubit),
            child: const ControlScreen(),
          ),
        );
    }
  }
}
