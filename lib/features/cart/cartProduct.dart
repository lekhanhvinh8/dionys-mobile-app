import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/cart/cartQuantitySelection.dart';
import 'package:flutter/material.dart';

class CartProduct extends StatelessWidget {
  const CartProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      height: maxWidth * 0.3,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(maxWidth * 0.01),
            child: Checkbox(value: true, onChanged: (value) {}),
          ),
          Container(
            width: maxWidth * 0.3,
            padding: EdgeInsets.all(maxWidth * 0.04),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ("" == "")
                        ? AssetImage('products/tainghe.jpg') as ImageProvider
                        : NetworkImage("21321"),
                    fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(right: maxWidth * 0.02),
            margin: EdgeInsets.only(top: maxWidth * 0.05),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tai Nghe Nhét Tai BYZ S389 (Đen Trắng) - Âm Thanh Chất Lượng",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontFamily: "RobotoMono"),
                  ),
                  Text(
                    Formator.formatMoney(100000) + "đ",
                    style: TextStyle(color: Colors.red),
                  ),
                  CartQuantitySelection(),
                ]),
          )),
        ],
      ),
    );
  }
}
