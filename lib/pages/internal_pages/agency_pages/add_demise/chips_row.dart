import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/add_demise/chip_text/chip_text.dart';
import 'package:ripapp_dashboard/widgets/chip_widget.dart';

class ChipsRow<T extends ChipText> extends StatelessWidget {

  final List<T> chips;
  final Function? onDeleted;

  const ChipsRow({Key? key, required this.chips, this.onDeleted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...chips.map((e) => ChipWidget(chipLabel: e, onDeleted: onDeleted))
      ],
    );
  }
}
