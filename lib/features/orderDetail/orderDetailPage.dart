import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/orderDetailProvider.dart';
import 'package:dionys/features/header/headerWithLabel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HeaderWithLabel(label: "Chi tiết đơn hàng"),
      ),
      body: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          children: [Text(widget.orderId)],
        ),
      ),
    );
  }
}
