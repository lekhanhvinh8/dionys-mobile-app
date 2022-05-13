import 'package:dionys/features/user/account/accountPage.dart';
import 'package:dionys/features/user/addresses/addressesPage.dart';
import 'package:flutter/material.dart';

class Card {
  Icon icon;
  String label;
  Widget? navigationTo;

  Card(this.icon, this.label, this.navigationTo);
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
        "Trang cá nhân",
        AccountPage(),
      ),
      Card(
          Icon(
            Icons.home_outlined,
            color: Colors.cyanAccent,
          ),
          "Địa chỉ của tôi",
          AddressesPage()),
      Card(
          Icon(
            Icons.access_time,
            color: Colors.green,
          ),
          "Đã xem gần đây",
          null),
      Card(Icon(Icons.star_rate, color: Colors.yellow), "Đánh giá của tôi",
          null),
      Card(
          Icon(
            Icons.assignment_outlined,
            color: Colors.blue,
          ),
          "Đơn hàng của tôi",
          null),
    ];

    return Container(
      child: Column(
          children: navigations
              .map((card) => InkWell(
                    onTap: () {
                      if (card.navigationTo != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => card.navigationTo as Widget));
                      }
                    },
                    child: Container(
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
                    ),
                  ))
              .toList()),
    );
  }
}
