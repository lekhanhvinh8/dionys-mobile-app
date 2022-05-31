import 'package:dionys/app/models/orderItem.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:flutter/material.dart';

class OrderItemArea extends StatefulWidget {
  OrderItem orderItem;
  OrderItemArea({Key? key, required this.orderItem}) : super(key: key);

  @override
  State<OrderItemArea> createState() => _OrderItemAreaState();
}

class _OrderItemAreaState extends State<OrderItemArea> {
  @override
  Widget build(BuildContext context) {
    final orderItem = widget.orderItem;

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
                          image: (orderItem.itemAvatarUrl == "")
                              ? const AssetImage('products/tainghe.jpg')
                                  as ImageProvider
                              : NetworkImage(orderItem.itemAvatarUrl),
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
                        orderItem.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: "RobotoMono"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Formator.formatMoney(orderItem.price) + "đ",
                            style: TextStyle(color: Colors.red),
                          ),
                          Text("x" + orderItem.amount.toString())
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
