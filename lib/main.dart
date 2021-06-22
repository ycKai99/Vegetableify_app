import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/screens/splash_screen.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'My Shop',
      home: SplashScreen(
          //body: ProductList(),
          ),
    );
  }
}

// class ProductList extends StatefulWidget {
//   @override
//   _ProductListState createState() => _ProductListState();
// }

// class _ProductListState extends State<ProductList> {
//   List _productList = [];
//   String titleCenter = "Loading...";
//   double screenHeight, screenWidth;

//   int cartitem = 0;
//   SharedPreferences prefs;
//   String email = "";
//   TextEditingController _srcController = new TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _testasync();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     screenHeight = MediaQuery.of(context).size.height;
//     screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Product List"),
//         actions: [
//           TextButton.icon(
//               onPressed: () => {_goCart()},
//               icon: Icon(
//                 Icons.shopping_cart,
//                 color: Colors.white,
//               ),
//               label: Text(
//                 cartitem.toString(),
//                 style: TextStyle(color: Colors.white),
//               )),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//                 width: 250,
//                 height: 100,
//                 padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: _srcController,
//                       decoration: InputDecoration(
//                         hintText: "Search product",
//                         suffixIcon: IconButton(
//                           onPressed: () => _loadProducts(_srcController.text),
//                           icon: Icon(Icons.search),
//                         ),
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white24)),
//                       ),
//                     ),
//                   ],
//                 )),
//             if (_productList.isEmpty)
//               Flexible(child: Center(child: Text('Loading...')))
//             else
//               Flexible(
//                   child: OrientationBuilder(builder: (context, orientation) {
//                 return StaggeredGridView.countBuilder(
//                     padding: EdgeInsets.all(10),
//                     crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
//                     itemCount: _productList.length,
//                     staggeredTileBuilder: (int index) =>
//                         new StaggeredTile.fit(1),
//                     mainAxisSpacing: 4.0,
//                     crossAxisSpacing: 4.0,
//                     itemBuilder: (BuildContext ctxt, int index) {
//                       return Column(
//                         children: [
//                           Container(
//                             //color: Colors.red,
//                             child: Card(
//                               elevation: 10,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.stretch,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                       height:
//                                           orientation == Orientation.portrait
//                                               ? 100
//                                               : 150,
//                                       width: orientation == Orientation.portrait
//                                           ? 100
//                                           : 150,
//                                       child: CachedNetworkImage(
//                                         imageUrl:
//                                             "http://yck99.com/myshop/images/${_productList[index]['prid']}.png",
//                                         height: 300,
//                                         width: 300,
//                                       ),
//                                       // Image.network(CONFIG.SERVER +
//                                       //     _productList[index]['picture']),
//                                     ),
//                                     Text(
//                                       //'test',
//                                       titleSub(
//                                         _productList[index]['prname'],
//                                       ),

//                                       style: TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(_productList[index]['prtype']),
//                                     Text("RM " +
//                                         double.parse(
//                                                 _productList[index]['prprice'])
//                                             .toStringAsFixed(2)),
//                                     Text(
//                                         "Qty: " + _productList[index]['prqty']),
//                                     Container(
//                                       child: ElevatedButton(
//                                         onPressed: () => {_addToCart(index)},
//                                         child: Text("Add to Cart"),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     });
//               })),
//           ],
//         ),
//       ),

//       // Center(
//       //   child: Column(children: [
//       //     _productList == null
//       //         ? Flexible(
//       //             child: Center(child: Text("No data")),
//       //           )
//       //         : Flexible(
//       //             child: Center(
//       //             child: Padding(
//       //               padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//       //               child: GridView.builder(
//       //                 itemCount: _productList.length,
//       //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       //                     crossAxisCount: 2,
//       //                     mainAxisSpacing: 10,
//       //                     crossAxisSpacing: 10,
//       //                     childAspectRatio: screenWidth / screenHeight),
//       //                 itemBuilder: (BuildContext context, int index) {
//       //                   return Card(
//       //                     child: InkWell(
//       //                       onTap: () {},
//       //                       child: Container(
//       //                         decoration: BoxDecoration(
//       //                             color: Colors.grey[200],
//       //                             boxShadow: [
//       //                               BoxShadow(
//       //                                 color: Colors.blueGrey,
//       //                                 spreadRadius: 2,
//       //                                 blurRadius: 2,
//       //                                 offset: Offset(1, 1),
//       //                               ),
//       //                             ]),
//       //                         child: SingleChildScrollView(
//       //                           child: Column(
//       //                             mainAxisAlignment: MainAxisAlignment.start,
//       //                             children: [
//       //                               ClipRRect(
//       //                                   borderRadius: BorderRadius.only(),
//       //                                   child: CachedNetworkImage(
//       //                                     imageUrl:
//       //                                         "http://yck99.com/myshop/images/${_productList[index]['prid']}.png",
//       //                                     height: 300,
//       //                                     width: 300,
//       //                                   )),
//       //                               SizedBox(height: 0),
//       //                               Row(
//       //                                   mainAxisAlignment:
//       //                                       MainAxisAlignment.spaceBetween,
//       //                                   children: [
//       //                                     Padding(
//       //                                       padding: const EdgeInsets.fromLTRB(
//       //                                           5, 10, 0, 0),
//       //                                       child: Text(
//       //                                           _productList[index]['prname'],
//       //                                           overflow: TextOverflow.ellipsis,
//       //                                           textAlign: TextAlign.left,
//       //                                           style: TextStyle(
//       //                                             fontSize: 20,
//       //                                             fontWeight: FontWeight.bold,
//       //                                             decoration:
//       //                                                 TextDecoration.underline,
//       //                                             decorationThickness: 2,
//       //                                           )),
//       //                                     ),
//       //                                   ]),
//       //                               Row(
//       //                                 children: [
//       //                                   Padding(
//       //                                     padding: const EdgeInsets.fromLTRB(
//       //                                         5, 15, 5, 0),
//       //                                     child: Text(
//       //                                       _productList[index]['prtype'],
//       //                                       overflow: TextOverflow.ellipsis,
//       //                                       style: TextStyle(
//       //                                           fontSize: 16,
//       //                                           fontStyle: FontStyle.italic,
//       //                                           color: Colors.blueGrey),
//       //                                     ),
//       //                                   ),
//       //                                 ],
//       //                               ),
//       //                               Row(
//       //                                   mainAxisAlignment:
//       //                                       MainAxisAlignment.spaceBetween,
//       //                                   children: [
//       //                                     Padding(
//       //                                       padding: const EdgeInsets.fromLTRB(
//       //                                           5, 5, 5, 0),
//       //                                       child: Text(
//       //                                         "Price: RM " +
//       //                                             _productList[index]
//       //                                                 ['prprice'],
//       //                                         style: TextStyle(fontSize: 16),
//       //                                       ),
//       //                                     ),
//       //                                   ]),
//       //                               Row(
//       //                                 children: [
//       //                                   Padding(
//       //                                     padding: const EdgeInsets.fromLTRB(
//       //                                         5, 5, 5, 0),
//       //                                     child: Text(
//       //                                       "Quantity Available: " +
//       //                                           _productList[index]['prqty'],
//       //                                       style: TextStyle(fontSize: 16),
//       //                                     ),
//       //                                   ),
//       //                                 ],
//       //                               ),
//       //                             ],
//       //                           ),
//       //                         ),
//       //                       ),
//       //                     ),
//       //                   );
//       //                 },
//       //               ),
//       //             ),
//       //           )),
//       //   ]),
//       // ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => NewProduct()));
//         },
//         label: Text(
//           "Add",
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         icon: Icon(Icons.add),
//       ),
//     );
//   }

//   _loadProducts(String prname) {
//     http.post(Uri.parse("http://yck99.com/myshop/php/loadproducts.php"),
//         body: {"prname": prname}).then((response) {
//       if (response.body != "nodata") {
//         var jsondata = json.decode(response.body);
//         _productList = jsondata["products"];
//         //titleCenter = "Contain Data";
//         setState(() {});
//         //print(_productList);
//       } else {
//         titleCenter = "No product";
//         return;
//       }
//     });
//     // String prname = "";
//     // http.post(Uri.parse("http://yck99.com/vegetableify/php/loadproducts.php"),
//     //     body: {"prname": prname}).then((response) {
//     //   if (response.body == "nodata") {
//     //     //_titlecenter = "No product";
//     //     _productList = [];
//     //     return;
//     //   } else {
//     //     var jsondata = json.decode(response.body);
//     //     print(jsondata);
//     //     _productList = jsondata["products"];
//     //     //_titlecenter = "";
//     //   }
//     //   setState(() {});
//     // });
//   }

//   _goCart() async {
//     if (email == "") {
//       Fluttertoast.showToast(
//           msg: "Please set your email first",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.TOP,
//           timeInSecForIosWeb: 1,
//           backgroundColor: Color.fromRGBO(191, 30, 46, 50),
//           textColor: Colors.white,
//           fontSize: 16.0);
//       _loademaildialog();
//     } else {
//       await Navigator.of(context).push(
//         MaterialPageRoute(
//           builder: (context) => CartScreen(email: email),
//         ),
//       );
//       _loadProducts("all");
//     }
//   }

//   _addToCart(int index) {
//     if (email == '') {
//       _loademaildialog();
//     } else {
//       String prid = _productList[index]['prid'];
//       http.post(Uri.parse("http://yck99.com/myshop/php/insertcart.php"),
//           body: {"email": email, "prid": prid}).then((response) {
//         print(response.body);
//         if (response.body == "failed") {
//           Fluttertoast.showToast(
//               msg: "Failed",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0);
//         } else {
//           Fluttertoast.showToast(
//               msg: "Success",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.CENTER,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.red,
//               textColor: Colors.white,
//               fontSize: 16.0);
//           _loadCart();
//         }
//       });
//     }
//   }

//   String titleSub(String title) {
//     if (title.length > 15) {
//       return title.substring(0, 15) + "...";
//     } else {
//       return title;
//     }
//   }

//   Future<void> _testasync() async {
//     await _loadPref();
//     _loadProducts("all");
//     _loadCart();
//   }

//   Future<void> _loadPref() async {
//     prefs = await SharedPreferences.getInstance();
//     email = prefs.getString("email") ?? '';
//     print(email);
//     if (email == '') {
//       _loademaildialog();
//     } else {}
//   }

//   void _loadCart() {
//     print(email);
//     http.post(Uri.parse("http://yck99.com/myshop/php/loadcartitem.php"),
//         body: {"email": email}).then((response) {
//       setState(() {
//         cartitem = int.parse(response.body);
//         print(cartitem);
//       });
//     });
//   }

//   void _loademaildialog() {
//     TextEditingController _emailController = new TextEditingController();
//     showDialog(
//         builder: (context) => new AlertDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(20.0))),
//                 title: new Text(
//                   'Your Email',
//                   style: TextStyle(
//                     color: Colors.black,
//                   ),
//                 ),
//                 actions: <Widget>[
//                   SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                               controller: _emailController,
//                               decoration: InputDecoration(
//                                 prefixIcon: Icon(
//                                   Icons.email,
//                                   color: Colors.black,
//                                 ),
//                                 border: OutlineInputBorder(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10.0)),
//                                     borderSide:
//                                         BorderSide(color: Colors.white24)),
//                               )),
//                           ElevatedButton(
//                               onPressed: () async {
//                                 String _email =
//                                     _emailController.text.toString();
//                                 prefs = await SharedPreferences.getInstance();
//                                 await prefs.setString("email", _email);
//                                 email = _email;
//                                 Fluttertoast.showToast(
//                                     msg: "Email stored",
//                                     toastLength: Toast.LENGTH_SHORT,
//                                     gravity: ToastGravity.TOP,
//                                     timeInSecForIosWeb: 1,
//                                     backgroundColor:
//                                         Color.fromRGBO(191, 30, 46, 50),
//                                     textColor: Colors.white,
//                                     fontSize: 16.0);
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text("Proceed"))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ]),
//         context: context);
//   }
// } //end main class
