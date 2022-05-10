import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant.dart';
import 'package:food_app/pages/login_page.dart';
import 'package:food_app/services/auth.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  SignOutMethod(context) async {
    await signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.orangeAccent,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                ),
                margin: EdgeInsets.zero,
                accountName: Text(constant.name),
                accountEmail: Text(constant.email),
                currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg")),
              ),
            ),
            ListTile(
              leading: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.white,
              ),
              title: Text(
                "Sign Out",
                textScaleFactor: 1.1,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                SignOutMethod(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
