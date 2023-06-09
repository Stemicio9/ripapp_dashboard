class AccountSearchEntity {
  int pageNumber;
  int pageElements;

  AccountSearchEntity({
    required this.pageNumber,
    required this.pageElements,
  });

  AccountSearchEntity.fromJson(Map<String, dynamic> json)
      : pageNumber = json['pageNumber'],
        pageElements = json['pageElements'];

  Map<String, dynamic> toJson() => {
    'pageNumber': pageNumber,
    'pageElements': pageElements,
  };
}