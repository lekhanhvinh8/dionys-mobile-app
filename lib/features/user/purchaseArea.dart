import 'package:flutter/material.dart';

class PurchaseArea extends StatelessWidget {
  const PurchaseArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return Container(
      child: Column(children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(maxWidth * 0.02),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                Icon(
                  Icons.assignment,
                  color: Colors.blue,
                ),
                Container(
                  margin: EdgeInsets.only(left: 7),
                  child: Text("Đơn mua"),
                )
              ],
            ),
            Row(
              children: [
                Text(
                  "Xem đơn hàng của tôi",
                  style:
                      TextStyle(color: Colors.grey, fontSize: maxWidth * 0.04),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: maxWidth * 0.04,
                  color: Colors.grey,
                )
              ],
            )
          ]),
        ),
        Container(
          margin: EdgeInsets.only(top: 3),
          color: Colors.white,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              height: maxWidth * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.settings_backup_restore_rounded,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    "Chờ xác nhận",
                    style: TextStyle(
                        color: Colors.grey, fontSize: maxWidth * 0.03),
                  )
                ],
              ),
            ),
            Container(
              height: maxWidth * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.card_giftcard_outlined,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    "Chờ lấy hàng",
                    style: TextStyle(
                        color: Colors.grey, fontSize: maxWidth * 0.03),
                  )
                ],
              ),
            ),
            Container(
              height: maxWidth * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    "Đang giao",
                    style: TextStyle(
                        color: Colors.grey, fontSize: maxWidth * 0.03),
                  )
                ],
              ),
            ),
            Container(
              height: maxWidth * 0.18,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.star_rate_outlined,
                    color: Colors.grey.shade700,
                  ),
                  Text(
                    "Đánh giá",
                    style: TextStyle(
                        color: Colors.grey, fontSize: maxWidth * 0.03),
                  )
                ],
              ),
            ),
          ]),
        )
      ]),
    );
  }
}
