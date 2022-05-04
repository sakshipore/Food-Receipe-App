import 'package:flutter/material.dart';
import 'package:food_app/pages/google_signin.dart';
import 'package:food_app/pages/login_page.dart';
import 'package:food_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.loginRoute,
      routes: {
        MyRoutes.loginRoute: (context)=>LoginPage(),
        MyRoutes.googleRoute: (context)=>GoogleSignIn(),
      }
    );
  }
}
