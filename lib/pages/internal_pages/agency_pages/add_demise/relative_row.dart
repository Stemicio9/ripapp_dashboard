

// TODO understand where to put this file

import 'package:ripapp_dashboard/constants/kinships.dart';

class RelativeRowNew {
  String value;
  Kinship kinship;
  int currentIndex;
  int relativeId;

  RelativeRowNew({this.value = "", this.kinship = Kinship.madre, this.currentIndex = 0, this.relativeId = 0});

  @override
  String toString() {
    return 'RelativeRowNew{value: $value, kinship: $kinship, currentIndex: $currentIndex,}';
  }
}