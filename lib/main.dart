import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/newproduct.dart';

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Add'),
        onPressed: () {
          _newProduct();
        },
        icon: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(98, 40, 10, 10),
            child: Text('Product List',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          )
        ]),
      ),
    );
  }

  void _newProduct() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NewProduct()));
  }
} //end main class

// body: Center(
//           child: CustomScrollView(
//         primary: false,
//         slivers: <Widget>[
//           SliverPadding(
//             padding: const EdgeInsets.all(20),
//             sliver: SliverGrid.count(
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//               crossAxisCount: 2,
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("He'd have you all unravel at the"),
//                   color: Colors.green[100],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text('Heed not the rabble'),
//                   color: Colors.green[200],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text('Sound of screams but the'),
//                   color: Colors.green[300],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text('Who scream'),
//                   color: Colors.green[400],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text('Revolution is coming...'),
//                   color: Colors.green[500],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text('Revolution, they...'),
//                   color: Colors.green[600],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       )),
