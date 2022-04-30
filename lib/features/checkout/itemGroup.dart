import 'package:dionys/features/checkout/item.dart';
import 'package:flutter/material.dart';

class ItemGroup extends StatelessWidget {
  const ItemGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            padding: EdgeInsets.all(7),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 2),
                  child: Row(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        color: Colors.red,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text("lighting01.vn"),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            margin: EdgeInsets.only(top: 3),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  color: Color.fromRGBO(245, 245, 245, 1),
                  child: Item(),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  color: Color.fromRGBO(245, 245, 245, 1),
                  child: Item(),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(maxWidth * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Tổng số tiền: "),
                Text("4.793.140đ",
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Colors.red)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
