import 'package:dionys/features/cart/cartGroup.dart';
import 'package:flutter/material.dart';

class ProductsSelection extends StatelessWidget {
  const ProductsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CartGroup(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CartGroup(),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: CartGroup(),
            )
          ],
        ),
      ),
    );
  }
}
