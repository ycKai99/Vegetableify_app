import 'dart:convert';
import '/models/user.dart';
import 'checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CartScreen extends StatefulWidget {
  final String email;
  final User user;
  CartScreen({Key key, this.user, this.email}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List _cartList = [];
  String _titlecenter = "No product in my cart...";
  double _totalprice = 0.0;
  double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    _loadMyCart();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Cart', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: Column(
          children: [
            if (_cartList.isEmpty)
              Flexible(
                  child: Center(
                      child:
                          Text(_titlecenter, style: TextStyle(fontSize: 18))))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return GridView.count(
                    crossAxisCount: 1,
                    childAspectRatio: 3 / 1,
                    children: List.generate(_cartList.length, (index) {
                      return Padding(
                          padding: EdgeInsets.all(1),
                          child: Container(
                              child: Card(
                                  child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  height: orientation == Orientation.portrait
                                      ? 100
                                      : 150,
                                  width: orientation == Orientation.portrait
                                      ? 100
                                      : 150,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "http://yck99.com/myshop/images/${_cartList[index]['prid']}.png",
                                    height: 300,
                                    width: 300,
                                  ),
                                ),
                              ),
                              Container(
                                  height: screenHeight / 2,
                                  child: VerticalDivider(color: Colors.grey)),
                              Expanded(
                                flex: 6,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(_cartList[index]['prname'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: screenHeight / 20),
                                          AutoSizeText(
                                              "RM " +
                                                  (int.parse(_cartList[index]
                                                              ['cartqty']) *
                                                          double.parse(
                                                              _cartList[index]
                                                                  ['prprice']))
                                                      .toStringAsFixed(2),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                              minFontSize: 1,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        flex: 6,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green[200],
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 3,
                                                          blurRadius: 4,
                                                          offset: Offset(0, 3),
                                                        )
                                                      ]),
                                                  child: IconButton(
                                                    icon: Icon(Icons.remove,
                                                        size: 15),
                                                    onPressed: () {
                                                      _modQty(
                                                          index, "removecart");
                                                    },
                                                  ),
                                                ),
                                                AutoSizeText(
                                                    _cartList[index]['cartqty'],
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.black87),
                                                    minFontSize: 1,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                                Container(
                                                  height: 28,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.green[200],
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 3,
                                                          blurRadius: 4,
                                                          offset: Offset(0, 3),
                                                        )
                                                      ]),
                                                  child: IconButton(
                                                    icon: Icon(Icons.add,
                                                        size: 15),
                                                    onPressed: () {
                                                      _modQty(index, "addcart");
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.cancel_outlined),
                                      onPressed: () {
                                        _deleteCartDialog(index);
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))));
                    }));
              })),
            Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('TOTAL', style: TextStyle(fontSize: 15)),
                          Text(
                            "RM " + _totalprice.toStringAsFixed(2),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent),
                        onPressed: () {
                          _payDialog();
                        },
                        child: Text("CHECKOUT",
                            style: TextStyle(color: Colors.black87)),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  _loadMyCart() {
    http.post(Uri.parse("http://yck99.com/myshop/php/load_user_cart.php"),
        body: {"email": widget.user.email}).then((response) {
      print(response.body);
      if (response.body == "nodata") {
        _titlecenter = "No product in my cart...";
        _cartList = [];
        return;
      } else {
        var jsondata = json.decode(response.body);
        print(jsondata);
        _cartList = jsondata["cart"];
        _titlecenter = "";
        _totalprice = 0.0;
        for (int i = 0; i < _cartList.length; i++) {
          _totalprice = _totalprice +
              double.parse(_cartList[i]['prprice']) *
                  int.parse(_cartList[i]['cartqty']);
        }
      }
      setState(() {});
    });
  }

  void _modQty(int index, String action) {
    http.post(Uri.parse("http://yck99.com/myshop/php/update_cart.php"), body: {
      "email": widget.user.email,
      "op": action,
      "prid": _cartList[index]['prid'],
      "cartqty": _cartList[index]['cartqty']
    }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
        _loadMyCart();
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  void _deleteCartDialog(int index) {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Delete from your cart?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () {
                      Navigator.of(context).pop();
                      _deleteCart(index);
                    },
                  ),
                  TextButton(
                      child: Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]),
        context: context);
  }

  void _deleteCart(int index) {
    http.post(Uri.parse("http://yck99.com/myshop/php/delete_cart.php"), body: {
      "email": widget.email,
      "prid": _cartList[index]['prid']
    }).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
        _loadMyCart();
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  void _payDialog() {
    if (_totalprice == 0.0) {
      Fluttertoast.showToast(
          msg: "Amount not payable",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      showDialog(
          builder: (context) => new AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  title: new Text(
                    'Continue with checkout?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text("Yes"),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Checkout(
                                email: widget.user.email,
                                totalPrice: _totalprice),
                          ),
                        );
                      },
                    ),
                    TextButton(
                        child: Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ]),
          context: context);
    }
  }
}//end cart screen