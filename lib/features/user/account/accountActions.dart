import 'package:dionys/features/user/account/nameDialog.dart';
import 'package:flutter/material.dart';

class AccountAction {
  String label;
  String data;
  Function action = () {};
  AccountAction(this.label, this.data, this.action);
}

class AccountActions extends StatelessWidget {
  const AccountActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var actions = [
      AccountAction("Tên", "Lê Khánh Vinh", () {
        showDialog(
            context: context,
            builder: (BuildContext context) => NameDialog.getDialog(context));
      }),
      AccountAction("Email", "vinhvinh07@gmail.com", () {}),
      AccountAction("Bio", "", () {}),
      AccountAction("Giới tính", "Nam", () {}),
      AccountAction("Số điện thoại", "0768654758", () {}),
      AccountAction("Thay đổi mật khẩu", "", () {}),
    ];

    var maxWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 7),
      child: Column(
          children: actions
              .map(
                (action) => InkWell(
                    onTap: () {
                      action.action();
                    },
                    child: Container(
                      height: maxWidth * 0.13,
                      color: Colors.white,
                      margin: EdgeInsets.only(bottom: 2),
                      padding: EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(action.label),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(action.data),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: maxWidth * 0.04,
                                  color: Colors.grey,
                                )
                              ],
                            )
                          ]),
                    )),
              )
              .toList()),
    );
  }
}
