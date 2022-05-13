import 'package:dionys/app/models/address.dart';
import 'package:dionys/app/providers/addressProvider.dart';
import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/features/user/addresses/addNewAddressBar.dart';
import 'package:dionys/features/user/addresses/addressBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final addressProvider =
          Provider.of<AddressProvider>(context, listen: false);

      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (authProvider.token != null)
        addressProvider.initializePage(authProvider.token as String);
    });
  }

  renderAddress(List<Address> addresses) {
    List<Widget> bars = addresses
        .map((address) => Container(
              margin: EdgeInsets.only(top: 10),
              child: AddressBar(address: address),
            ))
        .toList();

    bars.add(
        Container(margin: EdgeInsets.only(top: 10), child: AddNewAddressBar()));

    return bars;
  }

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;
    final addressProvider = Provider.of<AddressProvider>(context);
    var addresses = addressProvider.addresses;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70), // Set this height
            child: Container(
              color: Colors.white,
              height: 50,
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back, color: Colors.grey)),
                  Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Text(
                        "Địa chỉ của tôi",
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )),
        body: Container(
            color: const Color.fromRGBO(240, 240, 240, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: renderAddress(addresses)),
            )));
  }
}
