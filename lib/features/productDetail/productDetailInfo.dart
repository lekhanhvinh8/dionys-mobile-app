import 'package:dionys/features/productDetail/productDescription.dart';
import 'package:dionys/features/productDetail/productProperties.dart';
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chi tiết sản phẩm",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
          Container(
            child: ProductProperties(),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Divider(
              thickness: 1,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: ProductDescription(),
          )
        ],
      ),
    );
  }
}
