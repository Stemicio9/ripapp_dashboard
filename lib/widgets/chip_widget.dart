import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/constants/colors.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chip_text/chip_text.dart';
import 'package:ripapp_dashboard/utils/size_utils.dart';

class ChipWidget<T extends ChipText> extends StatelessWidget {

  final T chipLabel;
  final Function? onDeleted;

  const ChipWidget({Key? key, required this.chipLabel, this.onDeleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(top: 10,right: 2),
      child: Chip(
        label: Text(chipLabel.getChipText()),
        backgroundColor: background,
        labelStyle: const TextStyle(
          color: white
        ),
        deleteIcon: const Icon(Icons.cancel_rounded, color: white),
        onDeleted: onDeleted != null ? (){onDeleted!(chipLabel);} : null,

      ),
    );
  }
}
