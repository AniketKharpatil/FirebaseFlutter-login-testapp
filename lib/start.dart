//import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:test_app1/anonymous_login/anaon_sigin_in.dart';
import 'package:test_app1/anonymous_login/anon_auth.dart';
import 'package:test_app1/icecream.dart';
import 'package:test_app1/login.dart';
import 'package:test_app1/screens/login_ui.dart';
import 'package:test_app1/sign_up.dart';


class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
final AuthService _auth = AuthService();
  //final FirebaseAuth _auth = FirebaseAuth.instance;

  /*Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);

        await Navigator.pushReplacementNamed(context, "/");

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }*/
   final List imgList = [
    'images/home.jpg',
    'images/one.jpg',
    'images/cafe.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home page"),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[Padding(
              padding: EdgeInsets.only(top: 15),
            ),
             Container(
                child: CarouselSlider(
                  options: CarouselOptions(height: 300,autoPlay: true),
                  items: imgList
                      .map((item) => Container(child: Image.asset(item)))
                      .toList(),
                ),
              ),Padding(
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
                        MaterialPageRoute(builder: (context) => LoginUI()),
                      );
                    },
                    
                    
                    //for connecting to basic login screen,in above path:  put Login() instead of LoginUI, LoginUI is the class created for designed UI
                    
                    
                    child: Text(
                      "LOGIN",
                      style: TextStyle(fontSize: 22),
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
                      style: TextStyle(fontSize: 22),
                    ),
                    color: Colors.orange[800],
                    textColor: Colors.white),
                   
                   
              ],
              
            ), 
            RaisedButton(onPressed: () async {
            dynamic result = await _auth.signInAnon();
            Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Store()),);
            if(result == null){
              print('error signing in');
            } else {
              print('signed in');
              print(result);
            }
          }, child: Text(
                      "sign in anon",
                      style: TextStyle(fontSize: 22),
                    ),
                    color: Colors.orange[800],
                    textColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
