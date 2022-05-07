import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/providers/addressProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBar extends StatelessWidget {
  const AddressBar({Key? key, required this.address}) : super(key: key);

  final Address address;

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final addressProvider = Provider.of<AddressProvider>(context);
    var currentAddress = addressProvider.currentAddress;

    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: maxWidth * 0.9 - 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(address.customerName),
                      if (address.isDefault)
                        Text(
                          " [Mặc Định]",
                          style: TextStyle(color: Colors.red),
                        )
                    ]),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        address.phoneNumber,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        address.detail,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        (address.provinceName as String) +
                            ", " +
                            (address.districtName as String) +
                            ", " +
                            (address.wardName as String),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: maxWidth * 0.1,
              child: Column(children: [
                IconButton(
                  onPressed: () {
                    addressProvider.removeAddress(address.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
