import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class Header extends StatelessWidget {
  final onTap;
  final deleteProfileOnTap;
  final String pageTitle;
  final bool isVisible;
  final bool showPageTitle;
  final bool iconVisible;
  final String buttonText;
  final bool showBackButton;
  final bool showDeleteProfile;
  final EdgeInsetsGeometry leftPadding;

  // final TextEditingController filterController;
  //final Function optionSelected;
  //final List<String> kOptions;

  Header(
      {
        required this.onTap,
        required this.deleteProfileOnTap,
        this.showPageTitle = true,
        this.pageTitle = '',
        this.isVisible = true,
        this.leftPadding = const EdgeInsets.only(left: 0),
        this.buttonText = '',
        this.iconVisible = true,
        this.showBackButton = false,
        this.showDeleteProfile = false
      //  required this.filterController,
       // this.kOptions = const [],
      //  required this.optionSelected
     });


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Visibility(
            visible: showBackButton,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: (){
                    //TODO fixare pop quando si ricarica la pagina da browser
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: background,
                    size: 35,
                  ),
                ),
              )
          ),
        ),


        Visibility(
          visible: showPageTitle,
          child: Padding(
            padding: leftPadding,
            child: Texth1V2(
              testo: pageTitle,
              color: background,
              weight: FontWeight.w700,
            ),
          ),
        ),


        Row(
          children: [
            Padding(
              padding: getPadding(top: 20),
              child: Row(
                children: [
               Visibility(
                 visible: isVisible,
                 child: Padding(
                        padding: getPadding(right: 5),
                        child: ActionButtonV2(
                          action: onTap,
                          text: buttonText,
                          fontSize: 14,
                          containerHeight: 35,
                        ),
                      ),
               ),

                  Visibility(
                    visible: showDeleteProfile,
                    child: Padding(
                      padding: getPadding(right: 5),
                      child: ActionButtonV2(
                        action: deleteProfileOnTap,
                        text: 'Elimina account',
                        fontSize: 14,
                        containerHeight: 35,
                        color: rossoopaco,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
