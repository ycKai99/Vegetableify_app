import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/payment.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  const HistoryScreen({Key key, this.user, this.payment}) : super(key: key);
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  double screenHeight, screenWidth;
  List _receiptList = [];
  String email = "yck0146859295@gmail.com";
  @override
  void initState() {
    super.initState();
    _loadReceipt();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Payment',
            style: TextStyle(color: Colors.white, fontSize: 17)),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton.icon(
              onPressed: () => {_loadReceipt()},
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              label: Text(''),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: AutoSizeText('Order ID',
                      style: TextStyle(fontSize: 15),
                      minFontSize: 1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)),
              Container(
                  height: screenHeight / 10,
                  child: VerticalDivider(color: Colors.grey)),
              Expanded(
                  flex: 3,
                  child: AutoSizeText('Payment(RM)',
                      style: TextStyle(fontSize: 15),
                      minFontSize: 1,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)),
              Container(
                  height: screenHeight / 10,
                  child: VerticalDivider(color: Colors.grey)),
              Expanded(
                  flex: 4,
                  child: AutoSizeText('Date & Time',
                      style: TextStyle(fontSize: 15),
                      minFontSize: 1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis))
            ],
          ),
          Flexible(child: OrientationBuilder(builder: (context, orientation) {
            return GridView.count(
                crossAxisCount: 1,
                childAspectRatio: 3 / 1,
                children: List.generate(_receiptList.length, (index) {
                  return Column(
                    children: [
                      Container(
                          height: 80,
                          child: Card(
                            elevation: 3,
                            //color: Colors.lightGreenAccent[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)),
                            child: Row(
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                        _receiptList[index]['receiptid'],
                                        style: TextStyle(fontSize: 17),
                                        minFontSize: 1,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                                SizedBox(width: 20),
                                Expanded(
                                    flex: 3,
                                    child: AutoSizeText(
                                        _receiptList[index]['amount'],
                                        style: TextStyle(fontSize: 17),
                                        minFontSize: 1,
                                        maxLines: 2,
                                        overflow: TextOverflow.fade)),
                                SizedBox(width: 20),
                                Expanded(
                                    flex: 4,
                                    child: AutoSizeText(
                                        _convert(_receiptList[index]['date']),
                                        style: TextStyle(fontSize: 18),
                                        minFontSize: 1,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis)),
                              ],
                            ),
                          )),
                    ],
                  );
                }));
          })),

          // Center(
          //     child: Container(
          //         child: CircularProgressIndicator(color: Colors.greenAccent))),
        ],
      ),
    );
  }

  _loadReceipt() {
    http.post(Uri.parse("http://yck99.com/myshop/php/load_receipt.php"),
        body: {"email": widget.user.email}).then((response) {
      if (response.body != "nodata") {
        var jsondata = json.decode(response.body);
        _receiptList = jsondata["receipt"];
        print(jsondata);
      } else {
        print("Failed");
        return;
      }
    });
    setState(() {});
  }

  String _convert(receiptList) {
    var time = receiptList.split(".");
    String a = time[0];
    //String b = time[1];
    return a;
  }
}
