import 'package:dionys/features/user/navigations.dart';
import 'package:dionys/features/user/purchaseArea.dart';
import 'package:dionys/features/user/userHeader.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          UserHeader(),
          Container(
            margin: EdgeInsets.only(top: maxWidth * 0.02),
            child: PurchaseArea(),
          ),
          Container(
            margin: EdgeInsets.only(top: maxWidth * 0.02),
            child: Navigations(),
          )
        ],
      ),
    ));
  }
}
