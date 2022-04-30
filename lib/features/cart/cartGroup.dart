import 'package:dionys/features/cart/cartProduct.dart';
import 'package:flutter/material.dart';

class CartGroup extends StatelessWidget {
  const CartGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(maxWidth * 0.01),
                  child: Checkbox(value: true, onChanged: (value) {}),
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
                        child: Text("lighting01.vn"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 1),
            color: const Color.fromRGBO(255, 255, 255, 1),
            child: Column(
              children: [
                CartProduct(),
                CartProduct(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
