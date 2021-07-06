import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/payment.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:midtermstiw2044myshop/screens/cart_screen.dart';
import 'package:midtermstiw2044myshop/screens/home_screen.dart';
import 'package:midtermstiw2044myshop/screens/main_screen.dart';

class MyDrawer extends StatefulWidget {
  final User user;
  final Payment payment;
  const MyDrawer({Key key, this.user, this.payment}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(widget.user.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.white
                    : Colors.greenAccent,
            backgroundImage: AssetImage(
              "assets/images/profilea.png",
            ),
          ),
          accountName: Text('chee kai'),
        ),
        ListTile(
            title: Text("Dashboard"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => MainScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            title: Text("Home"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => HomeScreen(user: widget.user)));
            }),
        ListTile(
            title: Text("My Cart"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => CartScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            title: Text("My Product"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (content) => PostScreen(
              //               user: widget.user,
              //             )));
            }),
        ListTile(
            title: Text("My Payment"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
            }),
        ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
            })
      ],
    ));
  }
}//end my drawer
