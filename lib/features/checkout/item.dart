import 'package:dionys/app/utils/formator.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  const Item({Key? key}) : super(key: key);

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
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: ("" == "")
                              ? AssetImage('products/tainghe.jpg')
                                  as ImageProvider
                              : NetworkImage("21321"),
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
                      const Text(
                        "Tai Nghe Nhét Tai BYZ S389 (Đen Trắng) - Âm Thanh Chất Lượng",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "RobotoMono"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Formator.formatMoney(100000) + "đ",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text("x1")
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
