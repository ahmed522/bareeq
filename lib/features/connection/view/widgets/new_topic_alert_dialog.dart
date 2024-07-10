import 'package:bareeq/global/colors/app_colors.dart';
import 'package:bareeq/global/functions/common_functions.dart';
import 'package:bareeq/global/widgets/alert_dialog.dart';
import 'package:bareeq/global/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class NewTopicAlertDialog extends StatelessWidget {
  const NewTopicAlertDialog({super.key, required this.subscribe});
  final void Function(String) subscribe;
  @override
  Widget build(BuildContext context) {
    
    TextEditingController topicTextController = TextEditingController(text: '/');
    return AlertDialog(
      
      elevation: 5,
            backgroundColor: (CommonFunctions.isLightMode(context))
                    ? Colors.white
                    : Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            scrollable: true,
            title: Text(
              'New topic',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: (CommonFunctions.isLightMode(context))
                    ? AppColors.darkThemeBackgroundColor
                    : Colors.white,
              ),
            ),
            content: 
                  TextField(
                     controller: topicTextController,
                     decoration: const InputDecoration(
                       labelText: 'topic',
                       border: OutlineInputBorder(),
                     ),
                   )
            ,
            actionsAlignment: MainAxisAlignment.end,
            actionsPadding: const EdgeInsets.only(right: 20, bottom: 30),
            actions: AppAlertDialog.getAlertDialogActions(
              {
                'Subscribe' : (){
                  _subscribeTopic(topicTextController.text.trim(),context);
                },
                'Cancel' : () => Navigator.pop(context),
              }
            ),
          );
  }
  _subscribeTopic(String input, BuildContext context){
    if(input == '' || input == '/' || !RegExp(r'^[a-zA-Z0-9/_-]+$').hasMatch(input)){
      AppSnackBar.showSnackBar(context, 'Invalid topic',Colors.red);
      return;
    }
    subscribe(input);
    Navigator.pop(context);
  }
}