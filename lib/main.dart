import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/newproduct.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      home: Scaffold(
        body: ProductList(),
      ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List _productList;
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  final df = new DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: Center(
        child: Column(children: [
          _productList == null
              ? Flexible(
                  child: Center(child: Text("No data")),
                )
              : Flexible(
                  child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: GridView.builder(
                      itemCount: _productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: screenWidth / screenHeight),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueGrey,
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ]),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.only(),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://yck99.com/myshop/images/${_productList[index]['prid']}.png",
                                          height: 300,
                                          width: 300,
                                        )),
                                    SizedBox(height: 0),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 10, 0, 0),
                                            child: Text(
                                                _productList[index]['prname'],
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline,
                                                  decorationThickness: 2,
                                                )),
                                          ),
                                        ]),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 15, 5, 0),
                                          child: Text(
                                            _productList[index]['prtype'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.blueGrey),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                5, 5, 5, 0),
                                            child: Text(
                                              "Price: RM " +
                                                  _productList[index]
                                                      ['prprice'],
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ]),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 5, 5, 0),
                                          child: Text(
                                            "Quantity Available: " +
                                                _productList[index]['prqty'],
                                            style: TextStyle(fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewProduct()));
        },
        label: Text(
          "Add",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.add),
      ),
    );
  }

  Future<void> _loadProducts() async {
    http.post(Uri.parse("http://yck99.com/myshop/php/loadproducts.php"),
        body: {}).then((response) {
      if (response.body != "nodata") {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        titleCenter = "Contain Data";
        setState(() {});
        print(_productList);
      } else {
        titleCenter = "No data";
        return;
      }
    });
  }
} //end main class
