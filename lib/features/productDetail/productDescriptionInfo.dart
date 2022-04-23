import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDescriptionInfo extends StatelessWidget {
  const ProductDescriptionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productDetailProvider = Provider.of<ProductDetailProvider>(context);
    var product = productDetailProvider.productDetail;

    return Container(
        child: product == null ? Text("") : Text(product.description));
  }
}
