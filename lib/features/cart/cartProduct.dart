import 'package:dionys/app/models/cartGroup.dart';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/cart/cartQuantitySelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
  CartItem cartItem;
  CartProduct({Key? key, required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    var cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(maxWidth * 0.01),
            child: Checkbox(
                value: cartItem.checked,
                onChanged: (value) {
                  if (value != null)
                    cartProvider.checkCartItem(cartItem.id, value);
                }),
          ),
          Container(
            width: maxWidth * 0.3,
            height: maxWidth * 0.3,
            padding: EdgeInsets.all(maxWidth * 0.04),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: (cartItem.avatarUrl == "")
                        ? AssetImage('products/tainghe.jpg') as ImageProvider
                        : NetworkImage(cartItem.avatarUrl),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(right: maxWidth * 0.02),
            margin: EdgeInsets.only(top: 7),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                child: Text(
                  cartItem.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontFamily: "RobotoMono"),
                ),
              ),
              if (cartItem.combinationName != null)
                Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Text(
                    "Phân loại: " + (cartItem.combinationName as String),
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Text(
                  Formator.formatMoney(cartItem.price) + "đ",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CartQuantitySelection(
                        itemId: cartItem.id,
                        counter: cartItem.amount,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          await cartProvider.removeCart(
                              cartItem.id, authProvider.token as String);
                        },
                      )
                    ],
                  )),
            ]),
          )),
        ],
      ),
    );
  }
}
