import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_Screen.dart';
import 'security_screen.dart';

class login_screen extends StatefulWidget {
  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  String email, password;
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
                      "D-Smart Home",
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
        maxRadius: 200.0,
        minRadius: 100.0,
        backgroundImage: AssetImage("images/logo.png"),
      ),
    );
  }

  Widget circleImageLand() {
    return Center(
      child: CircleAvatar(
        maxRadius: 130.0,
        minRadius: 100.0,
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
                      keyboardType: TextInputType.emailAddress,
                      controller: Email,
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
                      controller: Password,
                      obscureText: true,
                    ),
                  ),
                  MaterialButton(
                    onPressed: loginFunction,
                    child: Text(
                      "Login",
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
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: regFunction,
                    child: Text(
                      "Register",
                      style: GoogleFonts.lato(textStyle: TextStyle(color: Colors.white)),
                      // style: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 22.0,
                      // ),
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
    email = Email.text;
    password = Password.text;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Login(context);
      Email.clear();
      Password.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
            msg: "No user found for that email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.red);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(
            msg: "Wrong password provided for that user",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: Colors.red);
      }
    }
  }

  void regFunction() {
    reg(context);
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
                        "D-Smart Home",
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
                    controller: Email,
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
                    controller: Password,
                    obscureText: true,
                  ),
                ),
                MaterialButton(
                  onPressed: loginFunction,
                  child: Text(
                    "Login",
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
                  height: 20.0,
                ),
                MaterialButton(
                  onPressed: regFunction,
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

  void reg(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => security_screen()),
    );
  }
}

void Login(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
}
