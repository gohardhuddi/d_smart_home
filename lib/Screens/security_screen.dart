import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'registration_screen.dart';

class security_screen extends StatefulWidget {
  @override
  _security_screenState createState() => _security_screenState();
}

class _security_screenState extends State<security_screen> {
  final databaseReference = FirebaseDatabase.instance.reference();
  TextEditingController hardwareid = new TextEditingController();
  String hwid, inputid;
  String id;
  @override
  void initState() {
    // TODO: implement initState
    fetchdata();
    super.initState();
  }

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
                  SizedBox(
                    height: 50.0,
                    child: Text(
                        "Plese Enter Hardware_ID provided by\n Engineer at the type of purchase "),
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
                        labelText: 'Hardware_id',
                        prefixIcon: Icon(Icons.vpn_key_rounded),
//errorText: 'Error message',
                        border: OutlineInputBorder(),
                      ),
                      controller: hardwareid,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  MaterialButton(
                    onPressed: loginFunction,
                    child: Text(
                      "Proceed",
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
  void loginFunction() {
    inputid = hardwareid.text;
    if (inputid.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please provide Hardware ID',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: Colors.red);
    } else if (hwid != inputid) {
      print("not match");
      Fluttertoast.showToast(
          msg: 'Invalid ID',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    } else {
      Login(context);
      hardwareid.clear();
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
                SizedBox(
                  height: 50.0,
                  child: Text(
                      "Plese Enter Hardware_ID provided by\n Engineer at the type of purchase "),
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
                      labelText: 'Hardware-ID',
                      prefixIcon: Icon(Icons.vpn_key_rounded),
//errorText: 'Error message',
                      border: OutlineInputBorder(),
                    ),
                    controller: hardwareid,
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

  Future fetchdata() async {
    try {
      await databaseReference
          .child('HardwareID')
          .once()
          .then((DataSnapshot snapshot) {
        hwid = '${snapshot.value.toString()}';
        print(hwid);
        loginFunction();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

void Login(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => registration_screen()),
  );
}
