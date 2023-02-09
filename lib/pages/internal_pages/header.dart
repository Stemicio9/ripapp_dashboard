import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/action_button.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class Header extends StatelessWidget {
  final onTap;
  final String pageTitle;
  final bool isVisible;
  final bool iconVisible;
  final String buttonText;
 // final TextEditingController filterController;
  //final Function optionSelected;
  //final List<String> kOptions;

  Header(
      {required this.onTap,
        required this.pageTitle,
        this.isVisible = true,
        this.buttonText = '',
        this.iconVisible = true,
      //  required this.filterController,
       // this.kOptions = const [],
      //  required this.optionSelected
     });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Texth1V2(
          testo: pageTitle,
          color: background,
          weight: FontWeight.w700,
        ),
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
           /*   Container(
                width: 300,
                height: 34,
                child: W1NAutocomplete(
                  customFilter: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return kOptions;
                    }
                    return kOptions.where((String option) =>
                        option.contains(textEditingValue.text.toLowerCase()));
                  },
                  contentPaddingTop: 20,
                  filterController: filterController,
                  optionSelected: optionSelected,
                  hintText: getCurrentLanguageValue(SEARCH)!,
                  suffixIcon: ImageConstant.imgSearch,
                  isSuffixIcon: true,
                  paddingLeft: 0,
                ),
              ) */
            ],
          ),
        ),
      ],
    );
  }
}
