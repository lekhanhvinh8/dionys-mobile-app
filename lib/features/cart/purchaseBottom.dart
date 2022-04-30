import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/checkout/checkoutPage.dart';
import 'package:flutter/material.dart';

class PurchaseBottom extends StatelessWidget {
  const PurchaseBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      width: maxWidth,
      height: maxWidth * 0.15,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(maxWidth * 0.01),
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: true,
                    onChanged: (bool? value) {
                      print(value);
                    },
                  ),
                  Text("Tất cả"),
                ],
              )),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  padding: EdgeInsets.all(maxWidth * 0.01),
                  child: Row(
                    children: [
                      Text("Tổng thanh toán: "),
                      Text(
                        Formator.formatMoney(100000) + "đ",
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  )),
            ],
          )),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutPage()),
              );
            },
            child: Container(
                padding: EdgeInsets.all(maxWidth * 0.05),
                color: Colors.redAccent,
                child: Center(
                  child: Text("Mua hàng"),
                )),
          )
        ],
      ),
    );
  }
}
