import 'package:flutter/material.dart';
import 'package:food_app/pages/home_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_app/constant.dart';
import 'package:food_app/localdb.dart';
import 'package:food_app/services/auth.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn> {
  signInMethod(context) async {
    await signInWithGoogle();
    constant.name = (await LocalDataSaver.getName())!;
    constant.email = (await LocalDataSaver.getEmail())!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
      child: Column(children: [
        SignInButton(Buttons.Google, onPressed: () async {
          await signInMethod(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        })
      ]),
    );
  }
}
