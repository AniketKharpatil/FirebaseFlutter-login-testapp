import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_app1/icecream.dart';
import 'package:test_app1/login.dart';
import 'package:test_app1/sign_up.dart';
import 'package:test_app1/start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Start(),
      debugShowCheckedModeBanner: false,
      routes: <String,WidgetBuilder>{

        "Login" : (BuildContext context)=>Login(),
        "SignUp":(BuildContext context)=>SignUp(),
        "start":(BuildContext context)=>Start(),
        "store":(BuildContext context)=>Store(),
      },
    );
  }
}


