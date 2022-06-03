import 'package:dionys/app/models/productCard.dart';
import 'package:dionys/features/productFilter/product.dart';
import 'package:flutter/material.dart';

class GridProducts extends StatelessWidget {
  List<ProductCard> products = [];
  GridProducts({
    Key? key,
    required this.products,
  }) : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: 0.55,
      children: [
        for (var product in products) Product(product: product),
      ],
    );
  }
}
