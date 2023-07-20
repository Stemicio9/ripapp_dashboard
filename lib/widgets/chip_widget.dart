import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {

  final String chipLabel;

  const ChipWidget({Key? key, required this.chipLabel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(chipLabel),
    );
  }
}
