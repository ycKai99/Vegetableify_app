import 'cart_screen.dart';
import 'home_screen.dart';
import 'main_screen.dart';
import 'post_screen.dart';
import 'login_screen.dart';
import '/models/user.dart';
import '/models/payment.dart';
import 'recent_payment_screen.dart';
import 'package:flutter/material.dart';

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
              "assets/images/user.png",
            ),
          ),
          accountName: Text(''),
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => PostScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            title: Text("My Payment"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => HistoryScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              _logout();
            })
      ],
    ));
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Do you want to logout?',
          style: TextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => LoginScreen()));
              },
              child: Text(
                "Yes",
                style: TextStyle(),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: TextStyle(),
              )),
        ],
      ),
    );
  }
}//end my drawer
