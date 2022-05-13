import 'package:dionys/app/providers/authProvider.dart';
import 'package:dionys/app/services/authService.dart';
import 'package:dionys/features/home/homepage.dart';
import 'package:dionys/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  Map<String, String?> errors = {
    "email": null,
    "password": null,
  };

  void click() {}
  bool validate() {
    if (email == "") {
      setState(() {
        errors["email"] = "Email không được để trống";
      });
    } else {
      setState(
        () {
          errors["email"] = null;
        },
      );
    }

    if (password == "") {
      setState(() {
        errors["password"] = "Mật khẩu không được để trống";
      });
    } else {
      setState(
        () {
          errors["password"] = null;
        },
      );
    }

    for (var field in errors.values) {
      if (errors[field] != null) return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.purpleAccent,
                Colors.amber,
                Colors.blue,
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 200,
                width: 300,
                child: LottieBuilder.asset("assets/lottie/login2.json"),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                width: 325,
                height: 470,
                margin: EdgeInsets.only(bottom: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Hello",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Vui lòng đăng nhập vào tài khoản của bạn",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 260,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                            errorText: errors["email"],
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 260,
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            errorText: errors["password"],
                            suffix: Icon(
                              FontAwesomeIcons.eyeSlash,
                              color: Colors.red,
                            ),
                            labelText: "Mật khẩu",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                            child: const Text(
                              "",
                              style: TextStyle(color: Colors.deepOrange),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (validate()) {
                          await authProvider.login(email, password);
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => const Home()),
                        // );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color(0xFF8A2387),
                                  Color(0xFFE94057),
                                  Color(0xFFF27121),
                                ])),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   height: 17,
                    // ),
                    // const Text(
                    //   "Or Login using Social Media Account",
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     IconButton(
                    //         onPressed: click,
                    //         icon: const Icon(FontAwesomeIcons.facebook,
                    //             color: Colors.blue)),
                    //     IconButton(
                    //         onPressed: click,
                    //         icon: const Icon(
                    //           FontAwesomeIcons.google,
                    //           color: Colors.redAccent,
                    //         )),
                    //     IconButton(
                    //         onPressed: click,
                    //         icon: const Icon(
                    //           FontAwesomeIcons.twitter,
                    //           color: Colors.orangeAccent,
                    //         )),
                    //     IconButton(
                    //         onPressed: click,
                    //         icon: const Icon(
                    //           FontAwesomeIcons.linkedinIn,
                    //           color: Colors.green,
                    //         ))
                    //   ],
                    // )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
