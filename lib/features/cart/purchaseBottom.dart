import 'package:dionys/app/providers/cartProvider.dart';
import 'package:dionys/app/utils/formator.dart';
import 'package:dionys/features/checkout/checkoutPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PurchaseBottom extends StatelessWidget {
  const PurchaseBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final cartProvider = Provider.of<CartProvider>(context);
    double totalCosts = 0;

    for (var cartGroup in cartProvider.cartGroups) {
      for (var item in cartGroup.items) {
        if (item.checked) {
          totalCosts += (item.price * item.amount);
        }
      }
    }

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
                    value: cartProvider.isAllChecked(),
                    onChanged: (bool? value) {
                      if (value != null) {
                        cartProvider.checkAll(value);
                      }
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
                  padding: EdgeInsets.all(maxWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Tổng thanh toán"),
                      Text(
                        Formator.formatMoney(totalCosts) + "đ",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
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
                  child: Text(
                    "Mua hàng",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
