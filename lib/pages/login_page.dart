import 'package:flutter/material.dart';
import 'package:food_app/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  String email = "";
  bool ButtonChange = false;
  final _formKey = GlobalKey<FormState>();

  movetoHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        ButtonChange = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, MyRoutes.homeRoute);
      setState(() {
        ButtonChange = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/food_app.jpg",
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter Username",
                                labelText: "Username"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Username cannot be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              name = value;
                              setState(() {});
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Enter Email", labelText: "Email"),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email cannot be empty";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              email = value;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Material(
                              color: Colors.orangeAccent,
                              borderRadius:
                                  BorderRadius.circular(ButtonChange ? 40 : 8),
                              child: InkWell(
                                  onTap: () => movetoHome(context),
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: 1),
                                    width: ButtonChange ? 40 : 150,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: ButtonChange
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : Text("Login",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15)),
                                  )))
                        ],
                      ))
                ],
              )),
        ));
  }
}
