import 'package:dionys/features/header/header.dart';
import 'package:flutter/material.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        children: [
          Header(),
          Container(
            margin: EdgeInsets.only(top: maxWidth * 0.02),
            padding: EdgeInsets.all(maxWidth * 0.02),
            width: maxWidth,
            color: Colors.white,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://res.cloudinary.com/docbzd7l8/image/upload/v1646806649/wiyyymmmehzyezqe4xqh.jpg"),
                ),
                Container(
                  margin: EdgeInsets.only(top: maxWidth * 0.02),
                  child: Text("Vinhvinh07"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
