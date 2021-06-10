import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:midtermstiw2044myshop/screens/newproduct.dart';

class PostScreen extends StatefulWidget {
  final User user;
  PostScreen({Key key, this.user}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Product')),
      body: Center(
          child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Card(
              child: Row(
                children: [
                  Icon(Icons.list, size: 25),
                  SizedBox(width: 20),
                  Text(
                    'Product List',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (content) => ProductListScreen(
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
                  Icon(Icons.add, size: 25),
                  SizedBox(width: 20),
                  Text(
                    'Add Product',
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(85, 0, 0, 0),
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
