import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviebookingapp/pages/login_screen.dart';
import 'package:moviebookingapp/utils/mytheme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _animation = CurvedAnimation(
        parent: animationController,
        curve: Curves.bounceOut,reverseCurve: Curves.bounceInOut );
    animationController.forward();
    Timer(const Duration(milliseconds: 3000) , () =>  Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> const LoginScreen())));
    super.initState();
  }
  @override
  void dispose(){
    animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context){
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: MyTheme.splash));
    print(_animation);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
            child: ScaleTransition(
              scale: _animation,
              child: Hero(
                tag: 'logo',
                child: Image.asset(
          'assets/icons/logo.png',
                    height: MediaQuery.of(context).size.height*0.25,
        ),
              ),
            )
        ),
      ),
    );
  }
}
