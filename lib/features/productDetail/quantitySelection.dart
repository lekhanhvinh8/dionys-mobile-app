import 'package:dionys/app/providers/productDetailProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantitySelection extends StatelessWidget {
  const QuantitySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    var productProvider = Provider.of<ProductDetailProvider>(context);
    var counter = productProvider.selectedQuantity;

    return Container(
      height: maxWidth * 0.07,
      child: Row(
        children: [
          Container(
            width: maxWidth * 0.07,
            decoration: BoxDecoration(
                color: Color(0xC4C4C4),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: Colors.grey,
                  width: 2,
                )),
            child: IconButton(
              icon: Icon(
                Icons.remove,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(2),
              iconSize: 15,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                productProvider.selectQuantity(counter - 1);
              },
            ),
          ),
          Container(
            width: maxWidth * 0.1,
            decoration: BoxDecoration(border: Border()),
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
            decoration: BoxDecoration(
                color: Color(0xC4C4C4),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.grey, width: 2)),
            child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              padding: EdgeInsets.all(2),
              iconSize: 15,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                productProvider.selectQuantity(counter + 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
