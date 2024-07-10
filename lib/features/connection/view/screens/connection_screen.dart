import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/features/connection/controller/connection_screen_states.dart';
import 'package:bareeq/features/connection/view/widgets/action_buttons.dart';
import 'package:bareeq/features/connection/view/widgets/subscribed_topics_list.dart';
import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/constants/app_assets.dart';
import 'package:bareeq/global/constants/strings.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:bareeq/global/widgets/containered_text.dart';
import 'package:bareeq/global/widgets/screen_title.dart';
import 'package:bareeq/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class ConnectionScreen extends StatelessWidget {
  const ConnectionScreen({super.key});
  static const String route = '/connectionScreen';
  @override
  Widget build(BuildContext context) {
    final cubit = ConnectionScreenCubit.get(context);
    return BlocConsumer<ConnectionScreenCubit, ConnectionScreenStates>(
      listener: (context, state) {
        if (state is ConnectedState) {
          AppSnackBar.showSnackBar(
              context, 'Connected to broker', Colors.green);
        } else if (state is NotConnectedState) {
          AppSnackBar.showSnackBar(context, 'Disconnected', Colors.red);
        } else if (state is SubscribedState) {
          AppSnackBar.showSnackBar(
              context, 'Subscribed Successfully', Colors.green);
        }
      },
      builder: (context, state) {
        return Scaffold(
            floatingActionButton: ((state is ConnectedState) ||
                    (state is SubscribedState))
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (!cubit.subscribedToAllNeededTopics)
                        FloatingActionButton(
                          onPressed: () => cubit.addNeededTopics(),
                          backgroundColor: Colors.deepOrange,
                          tooltip: 'Subscribe to all needed topics',
                          elevation: 1,
                          child: SizedBox(
                            child: Image.asset(
                              AppAssets.connectImageAsset,
                              color: Colors.white,
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ),
                      if (!cubit.subscribedToAllNeededTopics)
                        const SizedBox(
                          width: 5,
                        ),
                      FloatingActionButton.extended(
                        onPressed: () => cubit.addNewTopic(context),
                        backgroundColor: AppColors.primaryColor,
                        tooltip: 'Subscribe to topic',
                        elevation: 1,
                        label: const Text(
                          'New topic',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )
                : null,
            body: SingleChildScrollView(
                child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 60),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ScreenTitle(
                        title: AppStrings.appName,
                        fontSize: 30,
                        titleColor: (CommonFunctions.isLightMode(context))
                            ? AppColors.darkThemeBackgroundColor
                            : Colors.white,
                        bottomPadding: 0,
                        topPadding: 0,
                      ),
                      const ActionButtons(),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Lottie.asset(
                      ((state is ConnectedState) || (state is SubscribedState))
                          ? AppAssets.readyAnimationAsset
                          : (state is ConnectingState)
                              ? AppAssets.connectingAnimationAsset
                              : AppAssets.hiAnimationAsset),
                  const SizedBox(height: 30),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      enabled: (state is NotConnectedState) ||
                          (state is ConnectionInitState),
                      controller: cubit.brokerTextController,
                      decoration: const InputDecoration(
                        labelText: 'Broker ip',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      enabled: (state is NotConnectedState) ||
                          (state is ConnectionInitState),
                      controller: cubit.portTextController,
                      decoration: const InputDecoration(
                        labelText: 'Port',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (((state is ConnectedState) ||
                          (state is SubscribedState))) {
                        cubit.disconnect();
                      } else if (state is ConnectingState) {
                        cubit.stop();
                      } else {
                        cubit.connect(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 3,
                        backgroundColor: ((state is ConnectedState) ||
                                (state is SubscribedState) ||
                                (state is ConnectingState))
                            ? Colors.red
                            : null),
                    child: Text(((state is ConnectedState) ||
                            (state is SubscribedState))
                        ? 'Disconnect'
                        : (state is ConnectingState)
                            ? 'Stop'
                            : 'Connect'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is ConnectedState)
                    const ContaineredText(
                        text: 'No subscribed topics',
                        color: AppColors.primaryColor,
                        fontSize: 15)
                  else if (state is SubscribedState)
                    SubscribedTopicsList(
                        subscribedTopics: cubit.subscribedTopics),
                ],
              ),
            )));
      },
    );
  }
}
