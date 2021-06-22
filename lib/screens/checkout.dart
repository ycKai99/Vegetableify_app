import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:midtermstiw2044myshop/models/delivery.dart';
import 'package:midtermstiw2044myshop/models/payment.dart';
import 'package:ndialog/ndialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'map_screen.dart';
import 'payment_screen.dart';

class Checkout extends StatefulWidget {
  final String email;
  final double totalPrice;

  const Checkout({Key key, this.email, this.totalPrice}) : super(key: key);
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String address = "";
  int _radioValue = 0;
  String _delivery = "Pickup";
  bool _statusdel = false;
  bool _statuspickup = true;
  String _selectedtime = "09:00 A.M";
  String _curtime = "";
  String _name = "Write your name here";
  String _phone = "Write your phone number here";
  SharedPreferences prefs;
  double screenHeight, screenWidth;
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    _loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    final now = new DateTime.now();
    String today = DateFormat('hh:mm a').format(now);
    String todaybanner = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text('Payment')),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: screenWidth,
                      color: Colors.red,
                      child: Image.asset(
                        'assets/images/checkout.jpg',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      right: 0.0,
                      left: 0.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                child: Text(
                              todaybanner,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              flex: 7,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
                    child: Text(
                      'CUSTOMER DETAILS',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Text('Email : '),
                            Text('Name  : '),
                            Text('Phone : '),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 7,
                          child: Column(
                            children: [
                              Text(widget.email),
                              GestureDetector(
                                  onTap: _setName, child: Text(_name)),
                              GestureDetector(
                                  onTap: _setPhone, child: Text(_phone)),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 2,
                  ),
                  Container(
                    margin: EdgeInsets.all(2),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                      child: Column(
                        children: [
                          Text(
                            "SHIPPING METHOD",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Pickup"),
                              new Radio(
                                value: 0,
                                groupValue: _radioValue,
                                onChanged: (int value) {
                                  _handleRadioValueChange(value);
                                },
                              ),
                              Text("Delivery"),
                              new Radio(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: (int value) {
                                  _handleRadioValueChange(value);
                                },
                              ),
                            ],
                          ),
                          Divider(
                            height: 2,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _statuspickup,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                        child: Column(
                          children: [
                            Text(
                              "PICKUP TIME",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              width: 300,
                              child: Text(
                                  "Pickup time daily from 8.00 A.M to 8.00 P.M from our store. Please allow 15-30 minutes to prepare your order before pickup time"),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4, child: Text("Current Time: ")),
                                Container(
                                    height: 20,
                                    child: VerticalDivider(color: Colors.grey)),
                                Expanded(
                                  flex: 6,
                                  child: Text(today),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 4, child: Text("Set Pickup Time: ")),
                                Container(
                                    height: 20,
                                    child: VerticalDivider(color: Colors.grey)),
                                Expanded(
                                  flex: 6,
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          _selectedtime,
                                        ),
                                        Container(
                                            child: IconButton(
                                                iconSize: 32,
                                                icon: Icon(Icons.timer),
                                                onPressed: () =>
                                                    {_selectTime(context)})),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _statusdel,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 5, 15, 5),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
                        child: Column(
                          children: [
                            Text(
                              "SHIPPING ADDRESS",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 160,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.greenAccent),
                                            onPressed: () =>
                                                {_getUserCurrentLoc()},
                                            child: Text("Location",
                                                style: TextStyle(
                                                    color: Colors.black87)),
                                          ),
                                        ),
                                        // Divider(
                                        //   color: Colors.grey,
                                        //   height: 2,
                                        // ),
                                        Container(
                                          width: 160,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.greenAccent),
                                            onPressed: () async {
                                              Delivery _del =
                                                  await Navigator.of(context)
                                                      .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MapScreen(),
                                                ),
                                              );
                                              print(address);
                                              setState(() {
                                                _locationController.text =
                                                    _del.address;
                                              });
                                            },
                                            child: Text("Map",
                                                style: TextStyle(
                                                    color: Colors.black87)),
                                          ),
                                        ),
                                      ],
                                    )),
                                Container(
                                    height: 120,
                                    child: VerticalDivider(color: Colors.grey)),
                                Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
                                        TextField(
                                          controller: _locationController,
                                          style: TextStyle(fontSize: 14),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Search/Enter address'),
                                          keyboardType: TextInputType.multiline,
                                          minLines:
                                              4, //Normal textInputField will be displayed
                                          maxLines:
                                              4, // when user presses enter it will adapt to it
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // SizedBox(height: 5),
                          // Divider(
                          //   color: Colors.greenAccent,
                          //   height: 1,
                          //   thickness: 10.0,
                          // ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Text('TOTAL', style: TextStyle(fontSize: 15)),
                                Text(
                                  "RM " + widget.totalPrice.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
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
                              child: Text("PAY NOW",
                                  style: TextStyle(color: Colors.black87)),
                            ),
                          )
                        ],
                      )),
                ],
              ),
            )
          ],
        ));
  }

  void _setName() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                title: new Text(
                  'Your name?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your name here'),
                    keyboardType: TextInputType.name,
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Text("Confirm"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          _name = nameController.text;
                          prefs = await SharedPreferences.getInstance();
                          await prefs.setString("name", _name);
                          setState(() {});
                        },
                      ),
                      TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ]),
        context: context);
  }

  void _setPhone() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0))),
                title: new Text(
                  'Your phone number?',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextField(
                    controller: phoneController,
                    style: TextStyle(fontSize: 12),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your phone here'),
                    keyboardType: TextInputType.phone,
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Text("Confirm"),
                        onPressed: () async {
                          Navigator.of(context).pop();
                          _phone = phoneController.text;
                          prefs = await SharedPreferences.getInstance();
                          await prefs.setString("phone", _phone);
                          setState(() {});
                        },
                      ),
                      TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ],
                  ),
                ]),
        context: context);
  }

  Future<void> _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    _name = prefs.getString("name") ?? 'Write your name here';
    _phone = prefs.getString("phone") ?? 'Write your phone number here';
    setState(() {});
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _delivery = "Pickup";
          _statusdel = false;
          _statuspickup = true;
          setPickupExt();
          break;
        case 1:
          _delivery = "Delivery";
          _statusdel = true;
          _statuspickup = false;
          break;
      }
      print(_delivery);
    });
  }

  void setPickupExt() {
    final now = new DateTime.now();
    _curtime = DateFormat("Hm").format(now);
    int cm = _convMin(_curtime);
    _selectedtime = _minToTime(cm);
    setState(() {});
  }

  int _convMin(String c) {
    var val = c.split(":");
    int h = int.parse(val[0]);
    int m = int.parse(val[1]);
    int tmin = (h * 60) + m;
    return tmin;
  }

  String _minToTime(int min) {
    var m = min + 30;
    var d = Duration(minutes: m);
    List<String> parts = d.toString().split(':');
    String tm = '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    return DateFormat.jm().format(DateFormat("hh:mm").parse(tm));
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
    final now = new DateTime.now();
    print("NOW: " + now.toString());
    String year = DateFormat('y').format(now);
    String month = DateFormat('M').format(now);
    String day = DateFormat('d').format(now);

    String _hour, _minute, _time = "";
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute;
        _selectedtime = _time;
        _curtime = DateFormat("Hm").format(now);

        _selectedtime = formatDate(
            DateTime(int.parse(year), int.parse(month), int.parse(day),
                selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        int ct = _convMin(_curtime);
        int st = _convMin(_time);
        int diff = st - ct;
        if (diff < 30) {
          Fluttertoast.showToast(
              msg: "Invalid time selection",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black,
              fontSize: 16.0);
          _selectedtime = _minToTime(ct);
          setState(() {});
          return;
        }
      });
  }

  _getUserCurrentLoc() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: Text("Searching address"), title: Text("Locating..."));
    progressDialog.show();
    await _determinePosition().then((value) => {_getPlace(value)});
    setState(
      () {},
    );
    progressDialog.dismiss();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  void _getPlace(Position pos) async {
    List<Placemark> newPlace =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    Placemark placeMark = newPlace[0];
    String name = placeMark.name.toString();
    String subLocality = placeMark.subLocality.toString();
    String locality = placeMark.locality.toString();
    String administrativeArea = placeMark.administrativeArea.toString();
    String postalCode = placeMark.postalCode.toString();
    String country = placeMark.country.toString();
    address = name +
        "," +
        subLocality +
        ",\n" +
        locality +
        "," +
        postalCode +
        ",\n" +
        administrativeArea +
        "," +
        country;
    _locationController.text = address;
  }

  void _payDialog() {
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                title: new Text(
                  'Pay RM ' + widget.totalPrice.toStringAsFixed(2) + "?",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text("Yes"),
                    onPressed: () async {
                      Navigator.of(context).pop();
                      Payment _pay = new Payment(widget.email, _phone, _name,
                          widget.totalPrice.toString());
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(payment: _pay),
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
}//end checkout 
