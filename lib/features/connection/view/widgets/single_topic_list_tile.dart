import 'package:bareeq/features/connection/controller/connection_screen_cubit.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:bareeq/global/widgets/alert_dialog.dart';
import 'package:flutter/material.dart';

class SingleTopicListTile extends StatelessWidget {
  const SingleTopicListTile({super.key, required this.topic});
  final String topic;

  @override
  Widget build(BuildContext context) {
    final cubit = ConnectionScreenCubit.get(context);
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 35, right: 5),
      title: Text(
        topic,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: CommonFunctions.isLightMode(context)
              ? Colors.black
              : Colors.white,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.remove_circle_outline_rounded,
          color: Colors.red,
        ),
        onPressed: () {
          AppAlertDialog.showAlertDialog(
              context,
              'Unsubscribe',
              'Are you sure you want to unsubscribe $topic topic?',
              AppAlertDialog.getAlertDialogActions({
                'Unsubscribe': () {
                  cubit.unSubscribe(topic);
                  Navigator.pop(context);
                },
                'Cancel': () => Navigator.pop(context),
              }));
        },
      ),
    );
  }
}
