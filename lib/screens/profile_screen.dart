import 'package:flutter/material.dart';
import 'package:midtermstiw2044myshop/models/payment.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'recent_payment_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  const ProfileScreen({Key key, this.user, this.payment}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name;
  String _phone;
  String _email;
  double _totalPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('My Profile')),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Row(
                  children: [
                    Expanded(flex: 2, child: Icon(Icons.history, size: 25)),
                    //SizedBox(width: 20),
                    Expanded(
                      flex: 6,
                      child: Text(
                        'Payment History',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: IconButton(
                          onPressed: () {
                            Payment _pay = new Payment(
                                _email, _phone, _name, _totalPrice.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (content) =>
                                        HistoryScreen(payment: _pay)));
                          },
                          icon: Icon(Icons.arrow_forward_ios_rounded)),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
