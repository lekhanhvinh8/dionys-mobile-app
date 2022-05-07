import 'package:dionys/features/user/account/accountActions.dart';
import 'package:dionys/features/user/account/accountAvatar.dart';
import 'package:dionys/features/user/account/accountHeader.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          children: [
            AccountHeader(),
            AccountAvatar(),
            AccountActions(),
          ],
        ),
      ),
    );
  }
}
