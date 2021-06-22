import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:midtermstiw2044myshop/screens/cartscreen.dart';
import 'package:midtermstiw2044myshop/screens/home_screen.dart';
import 'package:midtermstiw2044myshop/screens/login_screen.dart';
import 'package:midtermstiw2044myshop/screens/mydrawer.dart';
import 'package:midtermstiw2044myshop/screens/post_screen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabchildren;
  String title = "";

  double screenHeight, screenWidth;
  Material homeText(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(10.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(
                        color: new Color(color),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //screenHeight = MediaQuery.of(context).size.height;
    //screenWidth = MediaQuery.of(context).size.width;

    return
        //Scaffold(
        WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        drawer: MyDrawer(user: widget.user),
        body: Center(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Card(
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Icon(Icons.home, size: 25)),
                    //SizedBox(width: 20),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Home',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => HomeScreen(
                                          user: widget.user,
                                        )));
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded)),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Row(
                  children: [
                    Icon(Icons.shopping_cart, size: 25),
                    SizedBox(width: 20),
                    Text(
                      'My Cart',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(124, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => CartScreen(
                                          user: widget.user,
                                        )));
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded)),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Row(
                  children: [
                    Icon(Icons.list, size: 25),
                    SizedBox(width: 20),
                    Text(
                      'My Product',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(92, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) => PostScreen(
                                          user: widget.user,
                                        )));
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded)),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Row(
                  children: [
                    Icon(Icons.people, size: 25),
                    SizedBox(width: 20),
                    Text(
                      'My Profile',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(104, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (content) => ProfileScreen(
                            //               user: widget.user,
                            //             )));
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded)),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Row(
                  children: [
                    Icon(Icons.settings, size: 25),
                    SizedBox(width: 20),
                    Text(
                      'Settings',
                      style: TextStyle(fontSize: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                      child: IconButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (content) => TestScreen(
                            //               user: widget.user,
                            //             )));
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded)),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: new Text(
              'Do you want to back to login?',
              style: TextStyle(),
            ),
            content: new Text(
              'Are your sure?',
              style: TextStyle(),
            ),
            actions: <Widget>[
              MaterialButton(
                  onPressed: () {
                    //Navigator.pop(context);
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
        ) ??
        false;
  }
}
