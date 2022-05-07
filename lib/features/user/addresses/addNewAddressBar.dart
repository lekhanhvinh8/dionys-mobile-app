import 'package:dionys/features/user/addresses/newAddressPage.dart';
import 'package:flutter/material.dart';

class AddNewAddressBar extends StatelessWidget {
  const AddNewAddressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => NewAddressPage()));
      },
      child: Container(
        color: Colors.white,
        height: maxWidth * 0.13,
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "Thêm địa chỉ mới",
          ),
          Icon(
            Icons.add,
            color: Colors.grey,
          )
        ]),
      ),
    );
  }
}
