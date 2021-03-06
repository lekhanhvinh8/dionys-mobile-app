import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/orderDetailProvider.dart';
import 'package:dionys/app/providers/purchaseProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/header/headerWithLabel.dart';
import 'package:dionys/features/orderDetail/orderItemArea.dart';
import 'package:dionys/features/ratings/ratingPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class OrderDetail extends StatefulWidget {
  String orderId;
  OrderDetail({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final orderDetailProvider =
        Provider.of<OrderDetailProvider>(context, listen: false);

    orderDetailProvider.reloadOrderDetail(
        widget.orderId, authProvider.token as String);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final purchaseProvider =
        Provider.of<PurchaseProvider>(context, listen: false);

    final orderDetailProvider = Provider.of<OrderDetailProvider>(context);

    final order = orderDetailProvider.orderDetail;

    final tab = purchaseProvider.tabs
        .firstWhereOrNull((tab) => tab.statusCode == order?.status);
    String? step;
    if (tab != null) {
      step = tab.step;
    }

    var formatedDate = "Undefine";

    try {
      if (order != null) {
        final date = DateTime.parse(order.orderDate);
        formatedDate = DateFormat.yMd().format(date);
      }
    } catch (error) {}

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HeaderWithLabel(label: "Chi ti???t ????n h??ng"),
      ),
      bottomNavigationBar: (order == null ||
              order.status != "SHIPPED" ||
              order.isRated)
          ? null
          : Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      if (order != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  RatingPage(orderId: order.id)),
                        );
                      }
                    },
                    child: Container(
                      height: 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "????nh gi??",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Icon(
                              Icons.star_outline_rounded,
                              color: Colors.yellow,
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ))
                ],
              )),
      body: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(Icons.grid_3x3_rounded),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(order != null ? order.id : ""),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(Icons.local_shipping_outlined),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(step != null ? step : ""),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Row(
                  children: [
                    Icon(Icons.access_time_outlined),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(formatedDate != null ? formatedDate : ""),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.paid_outlined),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text("Th??ng tin s???n ph???m"),
                        )
                      ],
                    ),
                    Divider(),
                    Container(
                      child: (order == null)
                          ? null
                          : Column(
                              children: [
                                ...order.items
                                    .map((item) =>
                                        OrderItemArea(orderItem: item))
                                    .toList(),
                              ],
                            ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("T???ng gi??: "),
                              Text(
                                Formator.formatMoney(
                                        order == null ? 0 : order.total) +
                                    "??",
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ph?? v???n chuy???n: "),
                                Text(Formator.formatMoney(
                                        order == null ? 0 : order.shipFee) +
                                    "??")
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("T???ng t??nh: "),
                                Text(
                                  Formator.formatMoney(order == null
                                          ? 0
                                          : order.total + order.shipFee) +
                                      "??",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
