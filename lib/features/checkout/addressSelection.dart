import 'package:flutter/material.dart';

class AddressSelection extends StatelessWidget {
  const AddressSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Color.fromRGBO(255, 255, 255, 1),
      padding: EdgeInsets.all(maxWidth * 0.02),
      child: Row(children: [
        const Icon(
          Icons.location_on_outlined,
          color: Colors.red,
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(left: maxWidth * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Địa chỉ nhận hàng"),
              Text("Lê Văn A | 0789672050"),
              Text("28/45 Đường ABC"),
              Text("Phường A, Quận 5, TP Hồ Chí Minh")
            ],
          ),
        )),
        Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        )
      ]),
    );
  }
}
