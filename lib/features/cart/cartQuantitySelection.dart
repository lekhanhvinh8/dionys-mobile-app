import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/services/cartService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartQuantitySelection extends StatelessWidget {
  final int itemId;
  final int counter;
  const CartQuantitySelection(
      {Key? key, required this.itemId, required this.counter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Container(
      height: maxWidth * 0.07,
      child: Row(
        children: [
          Container(
            width: maxWidth * 0.07,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            child: IconButton(
              icon: Icon(
                Icons.remove,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(2),
              iconSize: 15,
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                cartProvider.changeItemAmount(
                    itemId, counter - 1, authProvider.token as String);
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
              child: TextField(
                controller: TextEditingController(text: counter.toString()),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: InputDecoration.collapsed(hintText: ''),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                onSubmitted: (value) async {
                  if (int.tryParse(value) != null) {
                    cartProvider.changeItemAmount(
                        itemId, int.parse(value), authProvider.token as String);
                  } else {
                    cartProvider.changeItemAmount(
                        itemId, counter, authProvider.token as String);
                  }
                },
              ),
            ),
          ),
          Container(
            width: maxWidth * 0.07,
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey, width: 1)),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(2),
              iconSize: 15,
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                cartProvider.changeItemAmount(
                    itemId, counter + 1, authProvider.token as String);
              },
            ),
          ),
        ],
      ),
    );
  }
}
