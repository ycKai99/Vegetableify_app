import 'mydrawer.dart';
import 'home_screen.dart';
import 'post_screen.dart';
import 'cart_screen.dart';
import '/models/user.dart';
import 'login_screen.dart';
import '/models/payment.dart';
import 'recent_payment_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  MainScreen({Key key, this.user, this.payment}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabchildren;
  String title = "";
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
        ),
        drawer: MyDrawer(user: widget.user, payment: widget.payment),
        body: Center(
            child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Card(
                elevation: 3,
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Icon(Icons.home, size: 25)),
                    Container(
                        height: screenHeight / 5,
                        child: VerticalDivider(color: Colors.grey)),
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
                elevation: 3,
                child: Row(
                  children: [
                    Expanded(
                        flex: 2, child: Icon(Icons.shopping_cart, size: 25)),
                    Container(
                        height: screenHeight / 5,
                        child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'My Cart',
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
                elevation: 3,
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Icon(Icons.list, size: 25)),
                    Container(
                        height: screenHeight / 5,
                        child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'My Product',
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
                elevation: 3,
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Icon(Icons.history, size: 25)),
                    Container(
                        height: screenHeight / 5,
                        child: VerticalDivider(color: Colors.grey)),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'My Payment',
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
                                    builder: (content) => HistoryScreen(
                                        user: widget.user,
                                        payment: widget.payment)));
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
}//end main_screen;
