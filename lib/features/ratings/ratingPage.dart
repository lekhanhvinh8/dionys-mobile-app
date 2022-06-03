import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/providers/orderDetailProvider.dart';
import 'package:dionys/app/providers/purchaseProvider.dart';
import 'package:dionys/app/services/orderService.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/header/headerWithLabel.dart';
import 'package:dionys/features/orderDetail/orderItemArea.dart';
import 'package:dionys/features/ratings/ratingItemArea.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class RatingPage extends StatefulWidget {
  String orderId;
  RatingPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      initializePage();
    });
  }

  void initializePage() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  void showSuccessToast(context) {
    final fToast = FToast();
    fToast.init(context);

    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: InkWell(
        onTap: () {
          fToast.removeCustomToast();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check),
            SizedBox(
              width: 12.0,
            ),
            Text("Đánh giá thành công"),
          ],
        ),
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final orderDetailProvider = Provider.of<OrderDetailProvider>(context);

    final ratings = orderDetailProvider.ratings;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: HeaderWithLabel(label: "Đánh giá đơn hàng"),
      ),
      bottomNavigationBar: Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: () async {
                  final isRatingSuccess =
                      await OrderService(authProvider.token as String)
                          .rate(ratings);
                  if (isRatingSuccess) {
                    Navigator.of(context).pop();
                    showSuccessToast(context);
                  }
                },
                child: Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đánh giá",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
              ...ratings
                  .map((rating) => RatingItemArea(ratingItem: rating))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
