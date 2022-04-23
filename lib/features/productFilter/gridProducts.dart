import 'package:dionys/app/models/productCard.dart';
import 'package:dionys/features/productFilter/product.dart';
import 'package:flutter/material.dart';

class GridProducts extends StatelessWidget {
  List<ProductCard> products = [];
  ScrollController? _scrollController;
  GridProducts(
      {Key? key,
      required this.products,
      required ScrollController scrollController})
      : super(key: key) {
    _scrollController = scrollController;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      controller: _scrollController,
      primary: false,
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
