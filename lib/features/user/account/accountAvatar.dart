import 'package:flutter/material.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 3),
      height: maxWidth * 0.3,
      width: maxWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: maxWidth * 0.1,
            backgroundImage: NetworkImage(
                "https://res.cloudinary.com/docbzd7l8/image/upload/v1646806649/wiyyymmmehzyezqe4xqh.jpg"),
          ),
          Container(
            margin: EdgeInsets.only(top: maxWidth * 0.02),
            child: Text("Chỉnh sửa"),
          )
        ],
      ),
    );
  }
}
