import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'home_Screen.dart';

class registration_screen extends StatefulWidget {
  @override
  _registration_screenState createState() => _registration_screenState();
}

class _registration_screenState extends State<registration_screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailText = new TextEditingController();
  TextEditingController passwordText = new TextEditingController();
  TextEditingController confpassText = new TextEditingController();
  String email, password, confpass;
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: SafeArea(
          child: Container(
        child: orientation(),
      )),
    ));
  }

  Widget orientation() {
    Orientation orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return buildpotrate();
    } else {
      return buildLand();
    }
  }

  Widget buildpotrate() => SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      "Registration",
                      style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: "Lato-Regular",
                      ),
                    )),
              ),
              circleImagepotrate(),
              operationalArea(),
            ],
          ),
        ),
      );

  Widget circleImagepotrate() {
    return Center(
      child: CircleAvatar(
        maxRadius: 100.0,
        minRadius: 50.0,
        backgroundImage: AssetImage("images/logo.png"),
      ),
    );
  }

  Widget circleImageLand() {
    return Center(
      child: CircleAvatar(
        maxRadius: 100.0,
        minRadius: 50.0,
        backgroundImage: AssetImage("images/logo.png"),
      ),
    );
  }

  Widget operationalArea() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              shadowColor: Colors.blue,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.mail_rounded),
                        border: OutlineInputBorder(),
                      ),
                      controller: emailText,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
//errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                      controller: passwordText,
                      obscureText: true,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    margin: EdgeInsets.all(20.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Re-Type Password',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
//errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                      controller: confpassText,
                      obscureText: true,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: loginFunction,
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                      ),
                    ),
                    padding: EdgeInsets.all(15.0),
                    color: Colors.blue,
                    splashColor: Colors.pink,
                    minWidth: 250.0,
                    elevation: 8.0,
                    highlightElevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  void loginFunction() async {
    email = emailText.text;
    password = passwordText.text;
    confpass = confpassText.text;
    if (email.isNotEmpty && password.isNotEmpty && confpass.isNotEmpty) {
      if (password == confpass) {
        final bool isValid = EmailValidator.validate(email);
        if (isValid == true) {
          try {
            final newuser = await auth.createUserWithEmailAndPassword(
                email: email, password: password);
            if (newuser != null) {
              Login(context);
              emailText.clear();
              passwordText.clear();
              confpassText.clear();
            } else {
              Fluttertoast.showToast(
                  msg: 'Registration Error',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.white,
                  textColor: Colors.red);
            }
          } catch (e) {
            print(e);
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Please provide Valid Email',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.red);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Password do not match',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.red);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Fill the fields',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red);
    }
  }

  Widget buildLand() {
    return SingleChildScrollView(
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: "Lato-Regular",
                        ),
                      )),
                ),
                circleImageLand(),
              ],
            ),
          ),
          operationalAreaLand(),
        ],
      ),
    );
  }

  Widget operationalAreaLand() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Card(
            shadowColor: Colors.blue,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail_rounded),
                      border: OutlineInputBorder(),
                    ),
                    controller: emailText,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: 1.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key_rounded),
//errorText: 'Error message',
                      border: OutlineInputBorder(),
                    ),
                    controller: passwordText,
                    obscureText: true,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  margin: EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Re-Type-Password',
                      prefixIcon: Icon(Icons.vpn_key_rounded),
//errorText: 'Error message',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    controller: confpassText,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: loginFunction,
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.0,
                    ),
                  ),
                  padding: EdgeInsets.all(15.0),
                  color: Colors.blue,
                  splashColor: Colors.pink,
                  minWidth: 250.0,
                  elevation: 8.0,
                  highlightElevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void Login(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}
