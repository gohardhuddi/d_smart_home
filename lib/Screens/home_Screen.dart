//import 'dart:ffi';

// import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
WeatherFactory wf = new WeatherFactory("60e7e642db7389f9f5a274a70fe08655");
const  apikeye="";

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final databaseReference = FirebaseDatabase.instance.reference();

  String bsocket = "images/socket1.png",
      lsocket = "images/socket1.png",
      bfan = "images/ceiling_fan1.png",
      lfan = "images/ceiling_fan1.png",
      bbulb = "images/bulb1.png",
      lbulb = "images/bulb1.png";
  String cityName = 'Lahore';

  String data, mobile,otemp;
  bool bbulbisSwitched = false;
  bool lbulbisSwitched = false;
  bool bfanisSwitched = false;
  bool lfanisSwitched = false;
  bool bsocketisSwitched = false;
  bool lsocketisSwitched = false;
  var textValue = 'Switch is OFF';
  // databaseReference
  //     .child('Mobile')
  //     .once()
  //     .then((DataSnapshot snapshot) {
  // data = 'Data : ${snapshot.value.toString()}';
  // print(data);
  Future fetchdata() async {
    try {
      await databaseReference
          .child('DeviceStatus')
          .once()
          .then((DataSnapshot snapshot) {
        data = '${snapshot.value.toString()}';
        print(data);
        databaseReference.child("Mobile").once().then((DataSnapshot snapshot) {
          mobile = '${snapshot.value.toString()}';
          print(mobile);
        });
        decision();
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void getweather( String city)async
  {
    Weather w = await wf.currentWeatherByCityName(cityName);
    print(w);
    double celsius = w.temperature.celsius;
    int temp=celsius.toInt();
    print("clecius temp is $temp");
    setState(() {
      otemp=temp.toString();
    });

  }

  @override
  void initState() {
    fetchdata();
    getweather("Lahore");
    print("init called");
    print('data$data');
    // before buildfunction
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // after buildfunction
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      getweather("Lahore");
      fetchdata();
    }
  }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if(state == AppLifecycleState.resumed){
  //     // user returned to our app
  //   }else if(state == AppLifecycleState.inactive){
  //     // app is inactive
  //   }else if(state == AppLifecycleState.paused){
  //     // user is about quit our app temporally
  //   }else if(state == AppLifecycleState.suspending){
  //     // app suspended (not used in iOS)
  //   }
  // }

  decision() {
    bbulbisSwitched = false;
    print(data);
    String dta;
    dta = 'OFF';
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (data != dta) {
        print("1 called");
        // bbulbisSwitched = true;
        bsocketisSwitched = true;
        bsocket = "images/socket_on.png";
      } else {
        print("0 called");
        //socketbedroom(false);
        bbulbisSwitched = true;
        bsocket = "images/socket1.png";
      }
    });
  }

  void socketbedroom(bool value) {
    print(value);
    if (bsocketisSwitched == false) {
      setState(() {
        bsocketisSwitched = true;
        textValue = 'Switch Button is ON';
        bsocket = "images/socket1.png";
      });
      print('Switch Button is ON');
    } else if (bsocketisSwitched == true && value == false) {
      setState(() {
        bsocketisSwitched = false;
        textValue = 'Switch Button is OFF';
        bsocket = "images/socket.png";
      });
      print('Switch Button is OFF');
    }
  }

  void socketlivingroom(bool value) {
    if (lsocketisSwitched == false) {
      setState(() {
        lsocketisSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        lsocketisSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void fanbedroom(bool value) {
    if (bfanisSwitched == false) {
      setState(() {
        bfanisSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        bfanisSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void fanlivingroom(bool value) {
    if (lfanisSwitched == false) {
      setState(() {
        lfanisSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        lfanisSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void bulbbedroom(bool value) {
    if (bbulbisSwitched == false) {
      setState(() {
        bbulbisSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        bbulbisSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  void bulblivingroom(bool value) {
    if (lbulbisSwitched == false) {
      setState(() {
        lbulbisSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        lbulbisSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  @override
  Widget build(BuildContext context) {
    return
        // debugShowCheckedModeBanner: false,
        Scaffold(
      // backgroundColor: Colors.lightBlue[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    "D-Smart Home",
                    style:GoogleFonts.kronaOne(color: Colors.black,textStyle: TextStyle(fontSize: 30.0)),
                        //TextStyle(fontSize: 40.0, fontFamily: "Lato-Regular"),
                  )),
              SizedBox(
                height: 5.0,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  color: Colors.lightBlue,
                  elevation: 10.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            gradient: new LinearGradient(
                                colors: [Colors.lightBlueAccent, Colors.blue]),
                          ),
                          child: Text(
                            "Tempreature",
                            style:GoogleFonts.lato(color: Colors.white,textStyle: TextStyle(fontSize: 30.0)),
                                //TextStyle(fontSize: 30.0, color: Colors.white),
                          )),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                          gradient: new LinearGradient(colors: [
                            Colors.lightBlue,
                            Colors.lightBlueAccent
                          ]),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: Image.asset(
                                "images/home.png",
                                width: 100.0,
                                height: 100.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              //color: Colors.blueAccent,
                              child: Text(
                                "20.0",
                                style: GoogleFonts.lato(color: Colors.white,textStyle: TextStyle(fontSize: 30.0)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              child: Image.asset(
                                "images/hot.png",
                                width: 100.0,
                                height: 100.0,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10.0),
                              //color: Colors.blueAccent,
                              child: Text(
                                otemp,
                                style: GoogleFonts.lato(color: Colors.white,textStyle: TextStyle(fontSize: 30.0)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              // Padding(
              //   padding: EdgeInsets.all(10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        //shadowColor: Colors.blue,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    bsocket,
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  Switch(
                                    onChanged: socketbedroom,
                                    value: bsocketisSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Socket",
                                style: GoogleFonts.lato(color: Colors.black,
                                    textStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Text(
                              "Bed Room",
                              style: GoogleFonts.lato(color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   width: 10.0,
                  // ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    '$lsocket',
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  Switch(
                                    onChanged: socketlivingroom,
                                    value: lsocketisSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Socket",
                                style: GoogleFonts.lato(color: Colors.black,
                                    textStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Text(
                              "Living Room",
                              style: GoogleFonts.lato(color: Colors.black,
    textStyle: TextStyle(fontSize: 20.0,),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    bbulb,
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  Switch(
                                    onChanged: bulbbedroom,
                                    value: bbulbisSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Ceeling Lamp",
                                style: GoogleFonts.lato(color: Colors.black,
                                    textStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Text(
                              "Bed Room",
                              style: GoogleFonts.lato(color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    lbulb,
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  Switch(
                                    onChanged: bulblivingroom,
                                    value: lbulbisSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Ceeling Lamp",
                                style: GoogleFonts.lato(color: Colors.black,
                                    textStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Text(
                              "Living Room",
                              style: GoogleFonts.lato(color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    bfan,
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  Switch(
                                    onChanged: fanbedroom,
                                    value: bfanisSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Ceeling Fan",
                                style: GoogleFonts.lato(color: Colors.black,
                                    textStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Text(
                              "Bed Room",
                              style: GoogleFonts.lato(color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Image.asset(
                                    lfan,
                                    width: 70.0,
                                    height: 70.0,
                                  ),
                                  Switch(
                                    onChanged: fanlivingroom,
                                    value: lfanisSwitched,
                                    activeColor: Colors.blue,
                                    activeTrackColor: Colors.blueGrey,
                                    inactiveThumbColor: Colors.white,
                                    inactiveTrackColor: Colors.blueGrey,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Ceeling Fan",
                                style: GoogleFonts.lato(color: Colors.black,
                                    textStyle: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Text(
                              "Living Room",
                              style: GoogleFonts.lato(color: Colors.black,
                                  textStyle: TextStyle(fontSize: 20.0,)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void btnpressed() {
    int vChange;
    switch (vChange) {
      case 1:
        {
          databaseReference.update({'Mobile': '1'});
        }
    }
  }
}
