import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:su_chat_hakan/screens/login_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/6.png'),
          ),
        ),
      ),
      nextScreen: LoginPage(),
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.black45,
    );
  }
}
