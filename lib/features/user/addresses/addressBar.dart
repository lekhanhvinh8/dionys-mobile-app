import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/providers/addressProvider.dart';
import 'package:dionys/app/providers/authProvider.dart';
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

    var authProvider = Provider.of<AuthProvider>(context);

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
                      else
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontSize: 13),
                          ),
                          onPressed: () {
                            addressProvider.setDefaultAddress(
                                address.id, authProvider.token as String);
                          },
                          child: const Text('Đặt làm mặc định'),
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
                        (address.detail == null)
                            ? ""
                            : address.detail as String,
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
                    addressProvider.removeAddress(
                        address.id, authProvider.token as String);
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
