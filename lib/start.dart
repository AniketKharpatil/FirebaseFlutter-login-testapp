//import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app1/anonymous_login/anaon_sigin_in.dart';
import 'package:test_app1/anonymous_login/anon_auth.dart';
import 'package:test_app1/icecream.dart';
import 'package:test_app1/login.dart';
import 'package:test_app1/sign_up.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final AuthService _auth1 = AuthService();
  FirebaseAuth _auth = FirebaseAuth.instance;
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
        Navigator.pushReplacementNamed(context, "store");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }
  
  final List imgList = [
    'images/home.jpg',
    'images/one.jpg',
    'images/cafe.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            Container(child: Image(image: AssetImage('images/cafe.png'),)
              // child: CarouselSlider(
              //   options: CarouselOptions(height: 300, autoPlay: true),
              //   items: imgList
              //       .map((item) => Container(child: Image.asset(item)))
              //       .toList(),
              // ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Welcome to",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Pokemon Cafe 🍔',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange[700]))
                    ])),
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.orange[800],
                    textColor: Colors.white),
                SizedBox(width: 35.0),
                RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      "REGISTER",
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.orange[800],
                    textColor: Colors.white),
              ],
            ),Container(child: Padding(padding: EdgeInsets.all(10),child: Text("Don't want to create an account?",style: TextStyle(fontSize: 16),))),
            RaisedButton(
                onPressed: () async {
                  dynamic result = await _auth1.signInAnon();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Store()),
                  );
                  if (result == null) {
                    print('error signing in');
                  } else {
                    print('signed in');
                    print(result);
                  }
                },
                child: Text(
                  "Sign in as guest",
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.orange[800],
                textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
