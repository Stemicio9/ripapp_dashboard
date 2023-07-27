

class DataTablePaginatorData {
  final Function(int, String) changePageHandle;
  final int pageNumber;
  final int numPages;
  final String currentPageType;

  const DataTablePaginatorData({
    required this.changePageHandle,
    required this.pageNumber,
    required this.numPages,
    required this.currentPageType});
}