class RelativeEntity {
  String? id;
  String? relativeName;
  String? relativePhone;

  RelativeEntity({
    this.id,
    this.relativePhone,
    this.relativeName,
  });

  //toString
  @override
  String toString() {
    return 'UserEntity{id: $id, relativePhone: $relativePhone, relativename: $relativeName';
  }

  factory RelativeEntity.fromJson(Map<String, dynamic> json) {
    print("SONO NEL FORM DELLE RELATIVE");
    print(json);
    return
   RelativeEntity(
    id: json["id"] ?? "",
    relativePhone: json["relativePhone"] ?? "",
    relativeName: json["relativeName"] ?? "",
  );}

  RelativeEntity copyWith({
    String? id,
    String? relativePhone,
    String? relativeName,
  }) {
    return RelativeEntity(
      id: id ?? this.id,
      relativeName: relativeName ?? this.relativeName,
      relativePhone: relativePhone ?? this.relativePhone,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "relativePhone": relativePhone,
    "relativeName": relativeName,
  };

  factory RelativeEntity.emptyRelative() => RelativeEntity();


}
