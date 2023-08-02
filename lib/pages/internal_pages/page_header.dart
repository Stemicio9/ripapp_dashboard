import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class PageHeader extends StatelessWidget{
  final bool showBackButton;
  final String pageTitle;
  final Function()? onTap;

  const PageHeader({super.key, this.showBackButton = false, required this.pageTitle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(bottom: 30),
      child: Row(
        children: [
          Visibility(
              visible: showBackButton,
              child: Padding(
                padding: getPadding(right: 5),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: (){onTap!();},
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: background,
                      size: 35,
                    ),
                  ),
                ),
              )
          ),

          Texth1V2(
            testo: pageTitle,
            color: background,
            weight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
  
}