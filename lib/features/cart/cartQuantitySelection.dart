import 'package:dionys/app/providers/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartQuantitySelection extends StatelessWidget {
  const CartQuantitySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = 1;
    var maxWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Container(
      height: maxWidth * 0.07,
      child: Row(
        children: [
          Container(
            width: maxWidth * 0.07,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: IconButton(
              icon: Icon(
                Icons.remove,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(2),
              iconSize: 15,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                //cartProvider.changeItemAmount(cart, itemId, newAmount)
              },
            ),
          ),
          Container(
            width: maxWidth * 0.13,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey))),
            child: Center(
              child: Text(
                '$counter',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            width: maxWidth * 0.07,
            decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(2),
              iconSize: 15,
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
