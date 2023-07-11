

abstract class TableRowElement{
  List<String> getHeaders();
  List<RowElement> rowElements();
}


class RowElement {
  final bool isText;
  final bool isImage;
  // TODO change to dynamic or a specific interface to make it more generic
  final String element;

  RowElement({required this.isText, required this.isImage, required this.element});


}