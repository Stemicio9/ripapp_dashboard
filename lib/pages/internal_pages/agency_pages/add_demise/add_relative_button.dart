
import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';

class AddRelativeButton extends StatelessWidget {

  final String text = "Aggiungi parente";
  final Function() onPress;
  final bool isDetail;


  const AddRelativeButton({Key? key, required this.onPress, required this.isDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !isDetail,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: ActionButtonV2(
          action: (){onPress();},
          text: 'Aggiungi parente',
          maxHeight: 30,
          fontSize: 14,
          containerHeight: 30,
        ),
      ),
    );
  }
}
