import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/providers/checkoutProvider.dart';
import 'package:dionys/features/checkout/itemGroup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemArea extends StatelessWidget {
  const ItemArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      child: Column(
        children: cartProvider.cartGroups
            .map((cartGroup) => Container(
                  margin: EdgeInsets.only(top: 7),
                  child: ItemGroup(
                    cartGroup: cartGroup,
                  ),
                ))
            .toList(),
      ),
    );
  }
}
