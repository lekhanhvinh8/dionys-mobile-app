import 'package:dionys/features/checkout/addressSelection.dart';
import 'package:dionys/features/checkout/itemArea.dart';
import 'package:dionys/features/header/header.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          flexibleSpace: Container(child: Header()),
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: Container(
            color: Colors.white,
            height: maxWidth * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(maxWidth * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Tổng thanh toán"),
                      Text("4.793.140đ",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.red)),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(maxWidth * 0.025),
                    color: Colors.red,
                    child: Center(
                      child: Text(
                        "Đặt hàng",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ))
              ],
            )),
        body: Container(
            color: const Color.fromRGBO(240, 240, 240, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(children: [
                AddressSelection(),
                ItemArea(),
              ]),
            )));
  }
}
