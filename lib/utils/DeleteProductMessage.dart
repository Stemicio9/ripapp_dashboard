import 'package:ripapp_dashboard/models/product_entity.dart';

class DeleteProductMessage {
  String? message;
  ProductEntity? productDeleted;

  DeleteProductMessage({required this.productDeleted, required this.message});

  factory DeleteProductMessage.fromJson(Map<String, dynamic> json) => DeleteProductMessage(
    productDeleted: json["productDeleted"] != null ? ProductEntity.fromJson(json["productDeleted"]) : null,
    message: json["message"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "productDeleted": productDeleted?.toJson() ?? null,
    "message": message,
  };

  @override
  String toString() {
    return 'DeleteProductMessage{productDeleted: $productDeleted, message: $message}';
  }
}
