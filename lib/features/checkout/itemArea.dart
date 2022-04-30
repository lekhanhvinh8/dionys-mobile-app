import 'package:dionys/features/checkout/itemGroup.dart';
import 'package:flutter/material.dart';

class ItemArea extends StatelessWidget {
  const ItemArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 7),
            child: ItemGroup(),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: ItemGroup(),
          ),
          Container(
            margin: EdgeInsets.only(top: 7),
            child: ItemGroup(),
          ),
        ],
      ),
    );
  }
}
