

import 'package:flutter/material.dart';
import 'package:ripapp_dashboard/entities/single_product_entity.dart';
import 'package:ripapp_dashboard/pages/internal_pages/agency_pages/widgets/single_product.dart';

class ProductsRow extends StatelessWidget {

  final List<SingleProductEntity> products;

  const ProductsRow({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Wrap(
        children: [
          ...products.map((e) => SingleProduct(singleProductEntity: e)).toList()
        ],
      );
  }
}
