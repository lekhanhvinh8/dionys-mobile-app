import 'package:flutter/material.dart';

class Card {
  Icon icon;
  String label;

  Card(this.icon, this.label);
}

class Navigations extends StatelessWidget {
  const Navigations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    var navigations = [
      Card(
          Icon(
            Icons.person,
            color: Colors.red,
          ),
          "Trang cá nhân"),
      Card(
          Icon(
            Icons.home_outlined,
            color: Colors.cyanAccent,
          ),
          "Địa chỉ của tôi"),
      Card(
          Icon(
            Icons.access_time,
            color: Colors.green,
          ),
          "Đã xem gần đây"),
      Card(Icon(Icons.star_rate, color: Colors.yellow), "Đánh giá của tôi"),
      Card(
          Icon(
            Icons.assignment_outlined,
            color: Colors.blue,
          ),
          "Đơn hàng của tôi"),
    ];

    return Container(
      child: Column(
          children: navigations
              .map((card) => Container(
                    height: maxWidth * 0.13,
                    margin: EdgeInsets.only(top: 2),
                    padding: EdgeInsets.all(maxWidth * 0.02),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            card.icon,
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(card.label),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: maxWidth * 0.04,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ))
              .toList()),
    );
  }
}
