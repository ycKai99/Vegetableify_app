import 'dart:async';
import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/payment.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  const PaymentScreen({Key key, this.user, this.payment}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: WebView(
                  initialUrl:
                      'http://yck99.com/myshop/php/generate_bill.php?email=' +
                          widget.payment.email +
                          '&mobile=' +
                          widget.payment.phone +
                          '&name=' +
                          widget.payment.name +
                          '&amount=' +
                          widget.payment.amount,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
