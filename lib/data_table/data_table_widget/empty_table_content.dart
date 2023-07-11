import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action.dart';
import 'package:ripapp_dashboard/data_table/data_table_widget/action_widget_list.dart';
import 'package:ripapp_dashboard/pages/internal_pages/page_header.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';
import 'package:ripapp_dashboard/widgets/texts.dart';

class EmptyTableContent extends StatelessWidget {

  final String emptyMessage;
  final String pageTitle;
  final List<ActionDefinition> actions;
  final bool showBackButton;

  const EmptyTableContent({Key? key,
    required this.emptyMessage,
    required this.pageTitle,
    required this.actions,
    required this.showBackButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 30, bottom: 30, left: 5, right: 5),
      child: Column(
        children: [

          PageHeader(
            showBackButton: showBackButton,
            pageTitle: pageTitle,
          ),

          ActionWidgetList(actions: actions),

          Center(
            child: Padding(
              padding: getPadding(top: 40),
              child: Texth2V2(
                  testo: emptyMessage,
                  weight: FontWeight.bold,
                  color: background
              ),
            ),
          )
        ],
      ),
    );
  }
}
