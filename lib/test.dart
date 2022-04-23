import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(width: 5, color: Colors.black)),
      child: Column(children: [
        Container(
          width: 300,
          height: 100,
          decoration: const BoxDecoration(color: Colors.blue),
        ),
        Column(
          children: [
            Container(
              width: 300,
              height: 200,
              decoration: const BoxDecoration(color: Colors.red),
            ),
          ],
        ),
        Expanded(
          child: Container(
            width: 300,
            height: 200,
            decoration: const BoxDecoration(color: Colors.yellow),
          ),
        )
      ]),
    );
  }
}
