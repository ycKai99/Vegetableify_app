import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:midtermstiw2044myshop/screens/cartscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      home: Scaffold(
        body: ProductList(),
      ),
    );
  }
} //end of class _HomeScreen

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List _productList = [];
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  int cartitem = 0;
  SharedPreferences prefs;
  String email = "";
  TextEditingController _srcController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _testasync();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          TextButton.icon(
              onPressed: () => {_goCart()},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
              label: Text(
                cartitem.toString(),
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                width: 250,
                height: 100,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _srcController,
                      decoration: InputDecoration(
                        hintText: "Search product",
                        suffixIcon: IconButton(
                          onPressed: () => _loadProducts(_srcController.text),
                          icon: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white24)),
                      ),
                    ),
                  ],
                )),
            if (_productList.isEmpty)
              Flexible(child: Center(child: Text('Loading...')))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(10),
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    itemCount: _productList.length,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Container(
                            //color: Colors.red,
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          orientation == Orientation.portrait
                                              ? 100
                                              : 150,
                                      width: orientation == Orientation.portrait
                                          ? 100
                                          : 150,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "http://yck99.com/myshop/images/${_productList[index]['prid']}.png",
                                        height: 300,
                                        width: 300,
                                      ),
                                      // Image.network(CONFIG.SERVER +
                                      //     _productList[index]['picture']),
                                    ),
                                    Text(
                                      //'test',
                                      titleSub(
                                        _productList[index]['prname'],
                                      ),

                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(_productList[index]['prtype']),
                                    Text("RM " +
                                        double.parse(
                                                _productList[index]['prprice'])
                                            .toStringAsFixed(2)),
                                    Text(
                                        "Qty: " + _productList[index]['prqty']),
                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.greenAccent),
                                        onPressed: () => {_addToCart(index)},
                                        child: Text("Add to Cart",
                                            style: TextStyle(
                                                color: Colors.black87)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              })),
          ],
        ),
      ),
    );
  }

  _loadProducts(String prname) {
    http.post(Uri.parse("http://yck99.com/myshop/php/loadproducts.php"),
        body: {"prname": prname}).then((response) {
      if (response.body != "nodata") {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        //titleCenter = "Contain Data";
        setState(() {});
        print(_productList);
      } else {
        Fluttertoast.showToast(
            msg: "No data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 16.0);
        return;
      }
    });
  }

  _goCart() async {
    if (email == "") {
      Fluttertoast.showToast(
          msg: "Please set your email first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Color.fromRGBO(191, 30, 46, 50),
          textColor: Colors.white,
          fontSize: 16.0);
      _loademaildialog();
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartScreen(email: email),
        ),
      );
      _loadProducts("all");
    }
  }

  _addToCart(int index) {
    if (email == '') {
      _loademaildialog();
    } else {
      String prid = _productList[index]['prid'];
      http.post(Uri.parse("http://yck99.com/myshop/php/insertcart.php"),
          body: {"email": email, "prid": prid}).then((response) {
        print(response.body);
        if (response.body == "failed") {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          _loadCart();
        }
      });
    }
  }

  String titleSub(String title) {
    if (title.length > 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }

  Future<void> _testasync() async {
    await _loadPref();
    _loadProducts("all");
    _loadCart();
  }

  Future<void> _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? '';
    print(email);
    if (email == '') {
      _loademaildialog();
    } else {}
  }

  void _loadCart() {
    print(email);
    http.post(Uri.parse("http://yck99.com/myshop/php/loadcartitem.php"),
        body: {"email": email}).then((response) {
      setState(() {
        cartitem = int.parse(response.body);
        //print(cartitem);
      });
    });
  }

  void _loademaildialog() {
    TextEditingController _emailController = new TextEditingController();
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: new Text(
                  'Your Email',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.white24)),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                String _email =
                                    _emailController.text.toString();
                                prefs = await SharedPreferences.getInstance();
                                await prefs.setString("email", _email);
                                email = _email;
                                Fluttertoast.showToast(
                                    msg: "Email stored",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Color.fromRGBO(191, 30, 46, 50),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.of(context).pop();
                              },
                              child: Text("Proceed"))
                        ],
                      ),
                    ),
                  ),
                ]),
        context: context);
  }
} //end product class
