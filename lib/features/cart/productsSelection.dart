import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/features/cart/cartGroup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsSelection extends StatelessWidget {
  const ProductsSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartGroups = cartProvider.cartGroups;

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Column(
          children: cartGroups
              .map(
                (cartGroup) => Container(
                  margin: EdgeInsets.only(top: 10),
                  child: CartGroup(
                    cartGroup: cartGroup,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
