import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:test_app1/start.dart';

class Store extends StatefulWidget {
  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  bool isloggedin = false;

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Start()),
        );
      }
    });
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
        this.isloggedin = true;
      });
    }
  }

  Future signOut() async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Logout'),
        content: Text(
            'You have been successfully logged out, now you will be redirected to Homepage'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
    return await _auth.signOut();
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
    this.getUser();
  }

  final List imgList = [
    'images/chocolate.jpg',
    'images/butterscotch.jpg',
    'images/mango.jpg',
    'images/strawberry.jpg',
    'images/blueberry.jpg',
    'images/vanilla.jpg'
  ];

  List<String> flav = [
    "Mango",
    "Strawberry",
    "Vanilla",
    "Chocolate",
    "Butterscotch",
    "Blueberry"
  ];
  /*if (_response != null){
    if(_response.weatherInfo.description == 'clear sky') {
      bgImg = 'assets/sunny.jpg';
    } else if(_response.weatherInfo.description == 'dust') {
      bgImg = 'assets/night.jpg';
    } else if(_response.weatherInfo.description == 'Rainy') {
      bgImg = 'assets/rainy.jpg';
    } else if(_response.weatherInfo.description == 'haze') {
      bgImg = 'assets/cloudy.jpeg';
    }}
    else{

    bgImg = 'assets/cloudy.jpeg';}*/
  int flavindex = 1;
  int imgindx = 1;
  
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokemon Cafe page"),
          automaticallyImplyLeading: false,
          actions: [IconButton(icon: Icon(Icons.logout), onPressed: signOut)],
        ),
        body: Container(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Text("Pokemon Ice-cream!",
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.pink[600],
                      fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 35),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(height: 300),
                  items: imgList
                      .map((item) => Container(child: Image.asset(item)))
                      .toList(),
                ),
              ),

              /*child: Image(
                  image: AssetImage("images/download.jpg"),
                  fit: BoxFit.contain,
                ),*/
              Padding(padding: EdgeInsets.only(top: 30)),
              Text("Which Ice cream flavour do you want?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(flav[flavindex],
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.only(top: 15),
              ),
              FlatButton(
                onPressed: () {
                  updateindex();
                },
                child: Text(
                  "Next flavour",
                  style: TextStyle(fontSize: 28),
                ),
                color: Colors.yellow[800],
                textColor: Colors.black,
              ),
            ],
          ),
        ));
  }

  void updateindex() {
    final random = Random();
    final index = random.nextInt(flav.length);
    final imgindex = random.nextInt(imgList.length);
    setState(() {
      flavindex = index;
      imgindx = imgindex;
    });
  }
}
