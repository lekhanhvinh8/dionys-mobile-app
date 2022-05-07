import 'package:flutter/material.dart';

class NameDialog {
  static getDialog(context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 300,
        width: 300,
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Text("Cập nhật tên")],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: Color.fromRGBO(245, 245, 245, 1),
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Lê Khánh Vinh",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Lưu',
                      style: TextStyle(color: Colors.blue, fontSize: 18.0),
                    ))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
