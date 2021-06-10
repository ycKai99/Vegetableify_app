import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:midtermstiw2044myshop/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:midtermstiw2044myshop/screens/main_screen.dart';
import 'package:midtermstiw2044myshop/screens/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final User user;

  const LoginScreen({Key key, this.user}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  SharedPreferences sharedPref;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  @override
  void initState() {
    loadPreference();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.fromLTRB(25, 20, 20, 10),
                    child: Image.asset('assets/images/logo.png')),
                SizedBox(height: 5),
                Card(
                  margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                  elevation: 8,
                  shadowColor: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text('LOGIN', style: TextStyle(fontSize: 25)),
                        ),
                        //email field
                        TextField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Please enter valid email',
                            icon: Icon(Icons.email, size: 20),
                          ),
                        ),
                        //password field
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: '8 - 10 character',
                            icon: Icon(Icons.lock, size: 20),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 10),

                        Row(
                          children: [
                            Checkbox(
                                value: _rememberMe,
                                onChanged: (bool value) {
                                  _onChange(value);
                                }),
                            Text("Remember me")
                          ],
                        ),
                        //login button
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                          child: MaterialButton(
                            highlightElevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            minWidth: 150,
                            color: Colors.greenAccent,
                            child: Text('Login',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15)),
                            onPressed: _login,
                          ),
                        ), //login button
                      ],
                    ),
                  ),
                ),
                //register function
                GestureDetector(
                  child: Text('Register New Account',
                      style: TextStyle(fontSize: 14)),
                  onTap: _regNewUser,
                ),
                SizedBox(height: 5),
                //reset password function
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                  ),
                  onTap: _forgotPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  } //end build content

  void _onChange(bool value) {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    if (_email.isEmpty || _password.isEmpty) {
      showToast(1);
      return;
    }
    setState(() {
      _rememberMe = value;
      savePreference(value, _email, _password);
    });
  } //end onChange

  Future<void> savePreference(bool value, String email, String password) async {
    sharedPref = await SharedPreferences.getInstance();
    if (value) {
      await sharedPref.setString("email", email);
      await sharedPref.setString("password", password);
      await sharedPref.setBool("rememberMe", value);
      Fluttertoast.showToast(
        msg: "Your email and password is saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 15,
      );
      return;
    } else {
      await sharedPref.setString("email", '');
      await sharedPref.setString("password", '');
      await sharedPref.setBool("rememberMe", value);
      Fluttertoast.showToast(
        msg: "Preference removed",
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.black,
        fontSize: 15,
      );
      setState(() {
        _emailController.text = "";
        _passwordController.text = "";
        _rememberMe = false;
      });
      return;
    }
  } //end savePreference

  Future<void> loadPreference() async {
    sharedPref = await SharedPreferences.getInstance();
    String _email = sharedPref.getString("email") ?? '';
    String _password = sharedPref.getString("password") ?? '';
    _rememberMe = sharedPref.getBool("rememberMe") ?? false;

    setState(() {
      _emailController.text = _email;
      _passwordController.text = _password;
    });
  } //end loadPreference

  void _regNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
  } //end regNewUser

  void _forgotPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            //title: Text("Forgot Password"),
            content: new Container(
              height: 80,
              child: Column(
                children: [
                  Text("Reset your password ?"),
                  TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email, size: 18))),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Submit"),
                  onPressed: () {
                    print(_emailController.text);
                    _resetPassword(_emailController.text);
                  }),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        }); //end showDialog
  } //end forgotPassword

  void _login() {
    String _email = _emailController.text.toString();
    String _password = _passwordController.text.toString();
    _checkEmailPassword(_email, _password);
  } //end login

  void _checkEmailPassword(String email, String password) {
    if (email.isEmpty == true || password.isEmpty == true) {
      showToast(1);
    } else {
      if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(email) ==
              true &&
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,10}$')
                  .hasMatch(password) ==
              true) {
        http.post(Uri.parse("http://yck99.com/vegetableify/php/login_user.php"),
            body: {"email": email, "password": password}).then((response) {
          print(response.body);
          if (response.body == "failed") {
            showToast(3);
          } else {
            List userdata = response.body.split(",");
            User user = User(
                email: email,
                password: password,
                name: userdata[1],
                datereg: userdata[2],
                rating: userdata[3],
                point: userdata[4],
                status: userdata[5]);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(user: user)));
          }
        });
      } else {
        showToast(0);
      }
    }
  } //end _checkEmailPassword

  void showToast(int num) {
    switch (num) {
      case 1:
        Fluttertoast.showToast(
            msg: "Please enter your email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 15);
        break;
      case 2:
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 15);

        break;
      case 3:
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 15);
        break;
      default:
        Fluttertoast.showToast(
            msg: "Please enter correct email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 15);
    }
  }

  void _resetPassword(String email) {
    http.post(Uri.parse("http://yck99.com/vegetableify/php/reset_password.php"),
        body: {"email": email}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 15);
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 15);
      }
    });
  } //end _resetPassword

} //end login screen

