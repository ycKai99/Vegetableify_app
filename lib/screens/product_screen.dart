import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtermstiw2044myshop/models/user.dart';

class ProductScreen extends StatefulWidget {
  final User user;
  const ProductScreen({Key key, this.user}) : super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  double screenHeight, screenWidth;
  List _productList = [];
  String titleCenter = "Loading...";
  TextEditingController _prnameController = new TextEditingController();
  TextEditingController _prpriceController = new TextEditingController();
  TextEditingController _prqtyController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProduct("all");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('My Product'),
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: TextButton.icon(
                onPressed: () => {_loadProduct("all")},
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: Text(''),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              if (_productList.isEmpty)
                Flexible(child: Center(child: Text('Loading...')))
              else
                Flexible(
                    child: OrientationBuilder(builder: (context, orientation) {
                  return StaggeredGridView.countBuilder(
                      padding: EdgeInsets.all(10),
                      crossAxisCount:
                          orientation == Orientation.portrait ? 2 : 4,
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
                                        width:
                                            orientation == Orientation.portrait
                                                ? 100
                                                : 150,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://yck99.com/myshop/images/${_productList[index]['prid']}.png",
                                          height: 300,
                                          width: 300,
                                        ),
                                      ),
                                      Text(
                                        titleSub(
                                          _productList[index]['prname'],
                                        ),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(_productList[index]['prtype']),
                                      Text("RM " +
                                          double.parse(_productList[index]
                                                  ['prprice'])
                                              .toStringAsFixed(2)),
                                      Text("Qty: " +
                                          _productList[index]['prqty']),
                                      Container(
                                          child: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: IconButton(
                                                onPressed: _editProduct(index),
                                                icon:
                                                    Icon(Icons.edit_outlined)),
                                          ),
                                          Container(
                                              height: screenHeight / 15,
                                              child: VerticalDivider(
                                                  color: Colors.grey)),
                                          Expanded(
                                            flex: 5,
                                            child: IconButton(
                                                onPressed:
                                                    _deleteProduct(index),
                                                icon:
                                                    Icon(Icons.delete_outline)),
                                          ),
                                        ],
                                      )),
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
        ));
  }

  _deleteProduct(int index) {
    http.post(Uri.parse("http://yck99.com/myshop/php/delete_product.php"),
        body: {"prid": _productList[index]['prid']}).then((response) {
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
        _loadProduct("all");
        return;
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

  String titleSub(String title) {
    if (title.length > 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }

  _loadProduct(String prname) {
    String prname = "all";
    http.post(Uri.parse("http://yck99.com/myshop/php/load_products.php"),
        body: {"prname": prname}).then((response) {
      if (response.body != "nodata") {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        print("Success");
        //titleCenter = "Contain Data";
        setState(() {});
      } else {
        print("Failed");
        return;
      }
    });
  }

  _editProduct(int index) {
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.all(Radius.circular(20))),
    //         title: Text("Add Product "),
    //         content: new Container(
    //           height: 40,
    //           child: Text("Are you sure you want to add this product?"),
    //         ),
    //         actions: [
    //           TextButton(
    //               child: Text("Confirm",
    //                   style: TextStyle(
    //                       color: Colors.greenAccent,
    //                       fontWeight: FontWeight.bold)),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               }),
    //           TextButton(
    //               child: Text("Cancel",
    //                   style: TextStyle(
    //                       color: Colors.greenAccent,
    //                       fontWeight: FontWeight.bold)),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //               }),
    //         ],
    //       );
    //     });
  }
} //end class product_screen
