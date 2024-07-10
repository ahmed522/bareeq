import 'package:bareeq/features/connection/view/screens/connection_screen.dart';
import 'package:bareeq/global/themes/app_theme.dart';
import 'package:bareeq/global/widgets/app_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global/routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.light
              ? Brightness.dark
              : Brightness.light,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(const MainWidget());
    },
  );
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appLightTheme,
      darkTheme: AppTheme.appDarkTheme,
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (_) {
          return const AppErrorWidget();
        };
        return widget!;
      },
      themeMode: ThemeMode.system,
      onGenerateRoute: (settings) => AppRoutes.onGenerateRoutes(settings),
      routes: AppRoutes.routes,
      initialRoute: ConnectionScreen.route,
    );
  }
}
