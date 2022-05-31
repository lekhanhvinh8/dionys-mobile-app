import 'package:flutter/material.dart';

class HeaderWithLabel extends StatelessWidget {
  String label;
  HeaderWithLabel({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            child: Icon(Icons.arrow_back, color: Colors.grey),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text(
                label,
                style: TextStyle(fontSize: 20),
              ))
        ],
      ),
    );
  }
}
