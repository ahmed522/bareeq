import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/features/connection/view/widgets/single_topic_list_tile.dart';
import 'package:bareeq/global/widgets/alert_dialog.dart';
import 'package:bareeq/global/widgets/screen_title.dart';
import 'package:flutter/material.dart';

class SubscribedTopicsList extends StatelessWidget {
  const SubscribedTopicsList({super.key, required this.subscribedTopics});
  final List<String> subscribedTopics;
  @override
  Widget build(BuildContext context) {
    final cubit = ConnectionScreenCubit.get(context);
    return Column(
      children:[ 
        Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const ScreenTitle(title: 'Subscribed Topics',fontSize: 20,topPadding: 0,),
              IconButton(
                onPressed: (){
                  AppAlertDialog.showAlertDialog(
            context,
            'Unsubscribe All topics',
            'Are you sure you want to unsubscribe all topics?',
            AppAlertDialog.getAlertDialogActions(
              {
                'Unsubscribe':(){
                  cubit.unSubscribeAllTopics();
                  Navigator.pop(context);
                },
                'Cancel':()=>Navigator.pop(context),
              }
            )
          );
                }, 
                icon: const Icon(Icons.remove_circle_rounded,
                          color: Colors.red,))
            ],
          ),
        ),
        ...List<SingleTopicListTile>.generate(
          subscribedTopics.length,
          (index)=>SingleTopicListTile(topic: subscribedTopics[index])
        ),
        const SizedBox(height: 30,)
      ],
    );
  }
}