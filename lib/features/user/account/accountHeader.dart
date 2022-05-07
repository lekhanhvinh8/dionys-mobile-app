import 'package:flutter/material.dart';

class AccountHeader extends StatelessWidget {
  const AccountHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: maxWidth * 0.05,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                child: Text("Sửa hồ sơ"),
              )
            ],
          ),
          Icon(
            Icons.done,
            size: maxWidth * 0.06,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
