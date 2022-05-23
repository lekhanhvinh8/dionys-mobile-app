import 'package:dionys/app/models/cartGroup.dart' as cartGroupModel;
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/features/cart/cartProduct.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartGroup extends StatelessWidget {
  cartGroupModel.CartGroup cartGroup;
  CartGroup({Key? key, required this.cartGroup}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);

    return Container(
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(maxWidth * 0.01),
                  child: Checkbox(
                      value: cartProvider.isGroupChecked(cartGroup.shopId),
                      onChanged: (value) {
                        if (value != null) {
                          cartProvider.checkCartGroup(cartGroup.shopId, value);
                        }
                      }),
                ),
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 2),
                        child: Text(cartGroup.shopName),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            padding: EdgeInsets.only(bottom: 10),
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Column(
              children: cartGroup.items
                  .map((cartItem) => CartProduct(cartItem: cartItem))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
