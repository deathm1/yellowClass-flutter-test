import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    _mockCheckForSession().then(
            (status) {


          if (status) {
            _navigateToHome();
          } else {
            _navigateToLogin();
          }
        }
    );
  }


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    bool _isLoggedIn = false;

    getValue() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      //Return String
      String stringValue = prefs.getString('auth');
      return stringValue;
    }
    getValue();

    String value = await getValue() ?? "";
    if(value=="exists"){
      _isLoggedIn=true;
    }
    else{
      _isLoggedIn=false;
    }

    return _isLoggedIn;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen()
        )
    );
  }

  void _navigateToLogin(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => AuthScreen()
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Opacity(
                opacity: 0.5,
                child: Image.asset('assets/img/bg.png')
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 1500),
              baseColor: Colors.black,
              highlightColor: Colors.yellow,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(

                  "Yellow Class",
                  style: TextStyle(
                      fontSize: 50.0,
                      fontFamily: 'sans-serif',
                      shadows: <Shadow>[
                        Shadow(
                            blurRadius: 18.0,
                            color: Colors.black87,
                            offset: Offset.fromDirection(120, 12)
                        )
                      ]
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}