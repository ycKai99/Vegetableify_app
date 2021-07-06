import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:midtermstiw2044myshop/screens/addproduct_screen.dart';

import 'product_screen.dart';

class PostScreen extends StatefulWidget {
  final User user;
  PostScreen({Key key, this.user}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  double screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('My Product')),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Card(
              elevation: 3,
              child: Row(
                children: [
                  Expanded(flex: 2, child: Icon(Icons.list, size: 25)),
                  Container(
                      height: screenHeight / 2,
                      child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Product List',
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
                                  builder: (content) => ProductScreen(
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
                  Expanded(flex: 2, child: Icon(Icons.add, size: 25)),
                  Container(
                      height: screenHeight / 2,
                      child: VerticalDivider(color: Colors.grey)),
                  Expanded(
                    flex: 6,
                    child: Text(
                      'Add Product',
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
                                  builder: (content) => NewProduct(
                                        user: widget.user,
                                      )));
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded)),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
