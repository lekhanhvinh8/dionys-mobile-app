import 'package:dionys/app/models/orderItem.dart';
import 'package:dionys/app/providers/purchaseProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/orderDetail/orderDetailPage.dart';
import 'package:dionys/features/purchase/orderItemArea.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class OrderGroupArea extends StatefulWidget {
  OrderGroup orderGroup;
  OrderGroupArea({Key? key, required this.orderGroup}) : super(key: key);

  @override
  State<OrderGroupArea> createState() => _OrderGroupAreaState();
}

class _OrderGroupAreaState extends State<OrderGroupArea> {
  @override
  Widget build(BuildContext context) {
    final orderGroup = widget.orderGroup;
    final purchaseProvider = Provider.of<PurchaseProvider>(context);

    final tab = purchaseProvider.tabs
        .firstWhereOrNull((tab) => tab.statusCode == orderGroup.orderStatus);

    if (tab == null) return Container();

    final step = tab.step;

    List<Widget> orderWidgets = orderGroup.items
        .map((orderItem) => OrderItemArea(orderItem: orderItem))
        .toList();

    List<Widget> orderWidgetWithSeporator = [];

    for (var orderWidget in orderWidgets) {
      orderWidgetWithSeporator.add(orderWidget);
      orderWidgetWithSeporator.add(Divider(thickness: 1));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(
                  Icons.store_outlined,
                  color: Colors.red,
                ),
                Container(
                    margin: EdgeInsets.only(left: 3),
                    child: Text(orderGroup.shopName))
              ]),
              Text(
                step == null ? "" : step,
                style: TextStyle(
                    color: Colors.redAccent.shade700,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: orderWidgetWithSeporator,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("T???ng: " +
                  Formator.formatMoney(
                      orderGroup.total + orderGroup.shippingCost) +
                  "??"),
            ],
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            OrderDetail(orderId: orderGroup.id),
                      ));
                    },
                    child: Container(
                      height: 30,
                      child: Center(
                        child: Text(
                          "Chi ti???t ????n h??ng",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ))
                ],
              ))
        ],
      ),
    );
  }
}
