import 'package:dionys/app/models/cartGroup.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  CartItem cartItem;
  Item({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Container(
            height: maxWidth * 0.25,
            child: Row(
              children: [
                Container(
                  width: maxWidth * 0.25,
                  height: maxWidth * 0.25,
                  padding: EdgeInsets.all(maxWidth * 0.025),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (cartItem.avatarUrl == "")
                              ? const AssetImage('products/tainghe.jpg')
                                  as ImageProvider
                              : NetworkImage(cartItem.avatarUrl),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(maxWidth * 0.025),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        cartItem.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "RobotoMono"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Formator.formatMoney(cartItem.price) + "đ",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text("x" + cartItem.amount.toString())
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
