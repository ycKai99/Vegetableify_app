import 'dart:async';
import 'main_screen.dart';
import '/models/user.dart';
import '/models/payment.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
        title: Text('Payment', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.green[200],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 7,
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
              ),
              TextButton(
                onPressed: () {
                  Payment _pay = new Payment(
                      widget.payment.email,
                      widget.payment.phone,
                      widget.payment.name,
                      widget.payment.amount);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          MainScreen(payment: _pay, user: widget.user),
                    ),
                  );
                },
                child: AutoSizeText('Go Back to Main Page',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                    minFontSize: 1,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              )
            ],
          ),
        ),
      ),
    );
  }
}//end payment screen
