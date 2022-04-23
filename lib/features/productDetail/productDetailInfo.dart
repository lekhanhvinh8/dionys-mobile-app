import 'package:dionys/features/productDetail/productDescriptionInfo.dart';
import 'package:flutter/material.dart';

class ProductDetailInfo extends StatelessWidget {
  const ProductDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: Column(
        children: [
          ProductDescriptionInfo(),
        ],
      ),
    );
  }
}
